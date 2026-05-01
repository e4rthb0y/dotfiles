import { assert } from '@std/assert'
import { join } from '@std/path'
import { App } from 'octokit'

Deno.test('Configuration - required environment variables', () => {
    const required = ['GH_APP_ID', 'GH_INSTALLATION_ID', 'GH_APP_KEY_PATH']
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

Deno.test('Configuration - App initialization dry-run', async () => {
    const appId = Deno.env.get('GH_APP_ID')
    const keyPath = Deno.env.get('GH_APP_KEY_PATH')

    if (!appId || !keyPath) return

    try {
        const privateKey = await Deno.readTextFile(keyPath)
        new App({ appId, privateKey })
    } catch (e) {
        assert(false, `Failed to initialize GitHub App: ${e}`)
    }
})

Deno.test('Configuration - cache file writability', async () => {
    const __dirname = new URL('.', import.meta.url).pathname
    const cachePath = join(__dirname, '.cache.json')
    try {
        const testData = { data: 'test', expiresAt: new Date(Date.now() + 10000).toISOString() }
        await Deno.writeTextFile(cachePath, JSON.stringify(testData, null, 2))
        const content = await Deno.readTextFile(cachePath)
        assert(JSON.parse(content).data === 'test', 'Failed to read back test cache data')
    } catch (e) {
        assert(false, `Cache file at ${cachePath} is not writable: ${e}`)
    }
})
