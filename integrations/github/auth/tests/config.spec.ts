import { assert } from '@std/assert'
import { join } from '@std/path'
import { load } from '@std/dotenv'
import { App, Octokit } from 'octokit'

const __dirname = new URL('.', import.meta.url).pathname

await load({
    export: true,
    envPath: join(__dirname, '../.env'),
})

Deno.test('Configuration - required environment variables', () => {
    const required = ['GH_APP_ID', 'GH_INSTALLATION_ID', 'GH_APP_KEY_PATH', 'GH_CACHE_SEED']
    for (const env of required) {
        assert(Deno.env.get(env), `Environment variable ${env} is missing`)
    }
})

Deno.test('Configuration - private key file existence', async () => {
    const keyPath = Deno.env.get('GH_APP_KEY_PATH')
    if (!keyPath) return

    try {
        const stats = await Deno.stat(keyPath)
        assert(stats.isFile, `Key path ${keyPath} is not a file`)

        const content = await Deno.readTextFile(keyPath)
        assert(content.includes('-----BEGIN'), 'Key file does not look like a PEM private key')
    } catch (e) {
        assert(false, `Failed to access key file at ${keyPath}: ${e}`)
    }
})

Deno.test({
    name: 'Configuration - App initialization dry-run',
    // We disable sanitizers because Octokit starts internal bottleneck intervals
    // that do not expose a shutdown hook for dry-run scenarios.
    sanitizeOps: false,
    sanitizeResources: false,
    async fn() {
        const appId = Deno.env.get('GH_APP_ID')
        const keyPath = Deno.env.get('GH_APP_KEY_PATH')

        if (!appId || !keyPath) return

        const controller = new AbortController()
        try {
            const privateKey = await Deno.readTextFile(keyPath)
            new App({
                appId,
                privateKey,
                Octokit: Octokit.defaults({
                    request: { signal: controller.signal },
                }),
            })
        } catch (e) {
            assert(false, `Failed to initialize GitHub App: ${e}`)
        } finally {
            controller.abort()
        }
    },
})

Deno.test('Configuration - cache file writability', async () => {
    const tempDir = await Deno.makeTempDir()
    const cachePath = join(tempDir, '.cache.json')
    try {
        const testData = { data: 'test', expiresAt: new Date(Date.now() + 10000).toISOString() }
        await Deno.writeTextFile(cachePath, JSON.stringify(testData, null, 2))
        const content = await Deno.readTextFile(cachePath)
        assert(JSON.parse(content).data === 'test', 'Failed to read back test cache data')
    } catch (e) {
        assert(false, `Cache file at ${cachePath} is not writable: ${e}`)
    } finally {
        await Deno.remove(tempDir, { recursive: true })
    }
})
