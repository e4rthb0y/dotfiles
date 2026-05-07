# GitHub App Authentication Service

This service provides secure, automated authentication for agents using a GitHub App installation. It manages token generation, identity retrieval, and secure caching.

## Features
- **App Authentication**: Generates installation access tokens.
- **Identity Retrieval**: Automatically identifies the bot's username and email.
- **Secure Caching**: Caches credentials using AES-GCM encryption (requires a seed).
- **Portable Output**: Provides auth data in a clean JSON format for environment scripts.

## Requirements
- **Deno**: Required to run the authentication logic.
- **GitHub App**: An application with appropriate permissions (Issues, PRs, etc.) installed on the target repository.

## Configuration
Create a `.env` file in this directory based on `.env.example`:
- `GH_APP_ID`: Your GitHub App's ID.
- `GH_INSTALLATION_ID`: The ID of the installation on your account/org.
- `GH_APP_KEY_PATH`: Absolute path to your App's private key (`.pem`).
- `GH_CACHE_SEED`: A secret string used to derive the encryption key for the local cache.

## Usage
The `run.sh` script is the primary entry point:
```bash
./run.sh
```
It outputs a JSON object:
```json
{
  "token": "ghs_...",
  "name": "your-bot[bot]",
  "email": "your-bot[bot]@users.noreply.github.com",
  "expiresAt": "2026-05-01T..."
}
```

## Structure
- `src/index.ts`: Main logic for authentication and identity.
- `src/cache.ts`: Generic encrypted file cache provider.
- `run.sh`: Bash wrapper to execute the service with necessary permissions.
