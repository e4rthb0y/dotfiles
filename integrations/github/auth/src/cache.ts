export interface CacheEntry<T> {
    data: T
    expiresAt: string
}

export interface ICacheProvider<T> {
    get(): Promise<T | null>
    set(data: T, expiresAt: string): Promise<void>
}

export class FileCacheProvider<T> implements ICacheProvider<T> {
    constructor(
        private cacheFilePath: string,
        private bufferMs: number = 300000,
    ) {}

    async get(): Promise<T | null> {
        try {
            const raw = await Deno.readTextFile(this.cacheFilePath)
            const entry: CacheEntry<T> = JSON.parse(raw)
            if (this.isExpired(entry)) return null

            return entry.data
        } catch {
            return null
        }
    }

    async set(data: T, expiresAt: string): Promise<void> {
        const entry: CacheEntry<T> = { data, expiresAt }
        await Deno.writeTextFile(this.cacheFilePath, JSON.stringify(entry, null, 2))
    }

    private isExpired<T>(entry: CacheEntry<T>): boolean {
        return Date.now() > new Date(entry.expiresAt).getTime() - this.bufferMs
    }
}
