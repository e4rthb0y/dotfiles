import { assertEquals } from '@std/assert'
import { FileCacheProvider } from '../src/cache.ts'
import { join } from '@std/path'

Deno.test('FileCacheProvider - set and get', async () => {
    const tempDir = await Deno.makeTempDir()
    const cachePath = join(tempDir, 'cache.json')
    const cache = new FileCacheProvider<string>(cachePath, 0)

    const data = 'test-token'
    const expiresAt = new Date(Date.now() + 10000).toISOString()

    await cache.set(data, expiresAt)
    const cachedData = await cache.get()

    assertEquals(cachedData, data)

    await Deno.remove(tempDir, { recursive: true })
})

Deno.test('FileCacheProvider - expired data', async () => {
    const tempDir = await Deno.makeTempDir()
    const cachePath = join(tempDir, 'cache.json')
    const cache = new FileCacheProvider<string>(cachePath)

    const data = 'expired-token'
    // Set expiration in the past (beyond the 5 min buffer)
    const expiresAt = new Date(Date.now() - 600000).toISOString()

    await cache.set(data, expiresAt)
    const cachedData = await cache.get()

    assertEquals(cachedData, null)

    await Deno.remove(tempDir, { recursive: true })
})

Deno.test('FileCacheProvider - missing file', async () => {
    const cache = new FileCacheProvider<string>('non-existent.json')
    const cachedData = await cache.get()
    assertEquals(cachedData, null)
})
