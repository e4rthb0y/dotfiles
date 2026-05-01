export interface CacheEntry<T> {
    data: T
    expiresAt: string
}

export interface ICacheProvider<T> {
    get(): Promise<T | null>
    set(data: T, expiresAt: string): Promise<void>
}

export class FileCacheProvider<T> implements ICacheProvider<T> {
    private key: CryptoKey | null = null;

    constructor(
        private cacheFilePath: string,
        private seed: string,
        private bufferMs: number = 300000,
    ) {}

    private async getKey(): Promise<CryptoKey> {
        if (this.key) return this.key;

        const rawSeed = new TextEncoder().encode(this.seed);
        // Ensure the seed is hashed to a fixed length suitable for AES (256-bit)
        const hash = await crypto.subtle.digest("SHA-256", rawSeed);
        
        this.key = await crypto.subtle.importKey(
            "raw",
            hash,
            { name: "AES-GCM" },
            false,
            ["encrypt", "decrypt"]
        );
        
        return this.key;
    }

    async get(): Promise<T | null> {
        try {
            const raw = await Deno.readTextFile(this.cacheFilePath);
            const entry: { iv: string; encrypted: string; expiresAt: string } = JSON.parse(raw);
            
            if (this.isExpired(entry.expiresAt)) return null;

            const key = await this.getKey();
            const iv = Uint8Array.from(atob(entry.iv), (c) => c.charCodeAt(0));
            const encryptedData = Uint8Array.from(atob(entry.encrypted), (c) => c.charCodeAt(0));

            const decrypted = await crypto.subtle.decrypt(
                { name: "AES-GCM", iv },
                key,
                encryptedData
            );

            const decoded = new TextDecoder().decode(decrypted);
            return JSON.parse(decoded) as T;
        } catch {
            return null;
        }
    }

    async set(data: T, expiresAt: string): Promise<void> {
        const key = await this.getKey();
        const iv = crypto.getRandomValues(new Uint8Array(12));
        const encodedData = new TextEncoder().encode(JSON.stringify(data));

        const encrypted = await crypto.subtle.encrypt(
            { name: "AES-GCM", iv },
            key,
            encodedData
        );

        const entry = {
            iv: btoa(String.fromCharCode(...iv)),
            encrypted: btoa(String.fromCharCode(...new Uint8Array(encrypted))),
            expiresAt,
        };

        await Deno.writeTextFile(this.cacheFilePath, JSON.stringify(entry, null, 2));
    }

    private isExpired(expiresAt: string): boolean {
        return Date.now() > new Date(expiresAt).getTime() - this.bufferMs;
    }
}
