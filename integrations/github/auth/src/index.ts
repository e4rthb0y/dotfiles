import { join } from '@std/path'
import { load } from '@std/dotenv'
import { App } from 'octokit'
import { FileCacheProvider, ICacheProvider } from './cache.ts'

interface OctokitAuthResponse {
    token: string
    expiresAt: string
}

const __dirname = new URL('.', import.meta.url).pathname

await load({
    export: true,
    envPath: join(__dirname, '.env'),
})

export async function run(cacheProvider?: ICacheProvider<string>) {
    const APP_ID = Deno.env.get('GH_APP_ID')
    const INSTALLATION_ID = Deno.env.get('GH_INSTALLATION_ID')
    const KEY_PATH = Deno.env.get('GH_APP_KEY_PATH')

    if (!APP_ID || !INSTALLATION_ID || !KEY_PATH) {
        throw new Error(
            'Missing required environment variables: GH_APP_ID, GH_INSTALLATION_ID, GH_APP_KEY_PATH',
        )
    }

    const CACHE_PATH = join(__dirname, '.cache.json')
    const cache = cacheProvider || new FileCacheProvider(CACHE_PATH)

    try {
        const cachedToken = await cache.get()
        if (cachedToken) {
            Deno.stdout.writeSync(new TextEncoder().encode(cachedToken))
            return
        }

        const privateKey = await Deno.readTextFile(KEY_PATH)
        const app = new App({ appId: APP_ID, privateKey })
        const octokit = await app.getInstallationOctokit(Number(INSTALLATION_ID))
        const auth = (await octokit.auth()) as OctokitAuthResponse

        await cache.set(auth.token, auth.expiresAt)
        Deno.stdout.writeSync(new TextEncoder().encode(auth.token))
    } catch (error: unknown) {
        let message: string

        if (error instanceof Error) message = error.message
        else message = String(error)

        console.error(`GitHub Auth: ${message}`)
        Deno.exit(1)
    }
}

if (import.meta.main) {
    run()
}
