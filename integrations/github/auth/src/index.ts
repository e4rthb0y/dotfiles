import { join } from '@std/path'
import { load } from '@std/dotenv'
import { App } from 'octokit'
import { FileCacheProvider, ICacheProvider } from './cache.ts'

interface AuthData {
    token: string
    name: string
    email: string
    expiresAt: string
}

const __dirname = new URL('.', import.meta.url).pathname
const rootDir = join(__dirname, '..')

await load({
    export: true,
    envPath: join(rootDir, '.env'),
})

export async function run(cacheProvider?: ICacheProvider<AuthData>) {
    const APP_ID = Deno.env.get('GH_APP_ID')
    const INSTALLATION_ID = Deno.env.get('GH_INSTALLATION_ID')
    const KEY_PATH = Deno.env.get('GH_APP_KEY_PATH')
    const SEED = Deno.env.get('GH_CACHE_SEED')

    if (!APP_ID || !INSTALLATION_ID || !KEY_PATH || !SEED) {
        throw new Error(
            'Missing required environment variables: GH_APP_ID, GH_INSTALLATION_ID, GH_APP_KEY_PATH, GH_CACHE_SEED',
        )
    }

    const CACHE_PATH = join(rootDir, '.cache.json')
    const cache = cacheProvider || new FileCacheProvider<AuthData>(CACHE_PATH, SEED)

    try {
        const cached = await cache.get()
        if (cached) {
            Deno.stdout.writeSync(new TextEncoder().encode(JSON.stringify(cached)))
            return
        }

        const privateKey = await Deno.readTextFile(KEY_PATH)
        const app = new App({ appId: APP_ID, privateKey })

        const { data: auth } = await app.octokit.rest.apps.createInstallationAccessToken({
            installation_id: Number(INSTALLATION_ID),
        })

        // Fetch the App's information to get its slug and ID
        const { data: appInfo } = await app.octokit.rest.apps.getAuthenticated()

        const botName = `${appInfo.slug}[bot]`
        // Official GitHub bot email format: id+slug[bot]@users.noreply.github.com
        const botEmail = `${appInfo.id}+${botName}@users.noreply.github.com`

        const authData: AuthData = {
            token: auth.token,
            name: botName,
            email: botEmail,
            expiresAt: auth.expires_at,
        }

        await cache.set(authData, auth.expires_at)
        Deno.stdout.writeSync(new TextEncoder().encode(JSON.stringify(authData)))
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
