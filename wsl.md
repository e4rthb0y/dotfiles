**Required for `auto-dark-mode` plugin for nvim in WSL**

To query the appearance of the Windows host system, two options must be enabled in /etc/wsl.conf:

```ini

[automount]
enabled = true

[interop]
enabled = true
```
