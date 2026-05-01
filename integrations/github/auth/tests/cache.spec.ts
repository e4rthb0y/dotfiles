import { assertEquals, assertNotEquals } from '@std/assert'
import { FileCacheProvider } from '../src/cache.ts'
import { join } from '@std/path'

const TEST_SEED = "test-seed-1234567890";

Deno.test('FileCacheProvider - set and get encrypted', async () => {
    const tempDir = await Deno.makeTempDir()
    const cachePath = join(tempDir, 'cache.json')
    const cache = new FileCacheProvider(cachePath, TEST_SEED, 0)

    const data = 'test-token'
    const expiresAt = new Date(Date.now() + 10000).toISOString()

    await cache.set(data, expiresAt)
    
    // Verify file is encrypted (should not contain the raw data)
    const rawContent = await Deno.readTextFile(cachePath)
    assertNotEquals(rawContent.includes(data), true, "Cache file should not contain plain text data")
    
    const cachedData = await cache.get()
    assertEquals(cachedData, data)

    await Deno.remove(tempDir, { recursive: true })
})

Deno.test('FileCacheProvider - expired data', async () => {
    const tempDir = await Deno.makeTempDir()
    const cachePath = join(tempDir, 'cache.json')
    const cache = new FileCacheProvider(cachePath, TEST_SEED)

    const data = 'expired-token'
    // Set expiration in the past (beyond the 5 min buffer)
    const expiresAt = new Date(Date.now() - 600000).toISOString()

    await cache.set(data, expiresAt)
    const cachedData = await cache.get()

    assertEquals(cachedData, null)

    await Deno.remove(tempDir, { recursive: true })
})

Deno.test('FileCacheProvider - missing file', async () => {
    const cache = new FileCacheProvider('non-existent.json', TEST_SEED)
    const cachedData = await cache.get()
    assertEquals(cachedData, null)
})

Deno.test('FileCacheProvider - wrong seed cannot decrypt', async () => {
    const tempDir = await Deno.makeTempDir()
    const cachePath = join(tempDir, 'cache.json')
    
    const cache1 = new FileCacheProvider(cachePath, TEST_SEED, 0)
    const cache2 = new FileCacheProvider(cachePath, "wrong-seed", 0)

    const data = 'secret-token'
    const expiresAt = new Date(Date.now() + 10000).toISOString()

    await cache1.set(data, expiresAt)
    
    // Attempting to get with wrong seed should return null (due to decryption failure)
    const cachedData = await cache2.get()
    assertEquals(cachedData, null)

    await Deno.remove(tempDir, { recursive: true })
})
