return {
    -- 1. Mason: Modifying the setup to include the Roslyn registry
    --    Standard Mason doesn't have the official Roslyn package yet,
    --    so we add a community registry.
    {
        "williamboman/mason.nvim",
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry", -- The registry for Roslyn
            },
        },
    },

    -- 2. Roslyn.nvim: The modern C# LSP
    {
        "seblyng/roslyn.nvim",
        ft = "cs",
        opts = {
            -- Automatically install the Roslyn LSP via Mason
            -- This requires the registry addition above!
            exe = {
                "dotnet",
                vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages", "roslyn", "libexec",
                    "Microsoft.CodeAnalysis.LanguageServer.dll"),
            },
            -- Optional: tweaking capabilities if you use cmp-nvim-lsp
            config = {
                on_attach = function(client, bufnr)
                    -- Standard LSP keymaps (Go to definition, etc.)
                    -- You likely already have these in your general LSP config
                end,
                settings = {
                    ["csharp|inlay_hints"] = {
                        csharp_enable_inlay_hints_for_implicit_object_creation = true,
                        csharp_enable_inlay_hints_for_implicit_variable_types = true,
                    },
                },
            },
        },
        init = function()
            -- Ensure Mason installs the server
            vim.api.nvim_create_autocmd("User", {
                pattern = "MasonToolsStartingInstall",
                callback = function()
                    local mason_registry = require("mason-registry")
                    if not mason_registry.is_installed("roslyn") then
                        vim.cmd("MasonInstall roslyn")
                    end
                end,
            })
        end
    },

    -- 3. Debugging (DAP) + netcoredbg
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()

            -- Auto-open debugger UI when debugging starts
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

            -- C# Debug Adapter Config
            dap.adapters.coreclr = {
                type = 'executable',
                command = vim.fn.stdpath("data") .. '/mason/bin/netcoredbg',
                args = { '--interpreter=vscode' }
            }

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        -- Helper to find the .dll path
                        return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/net8.0/', 'file')
                    end,
                },
            }
        end
    },

    -- 4. Formatting (Optional but recommended)
    --    If you use conform.nvim or none-ls, add "csharpier" there.
    --    This ensures 'csharpier' is installed via Mason.
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            table.insert(opts.ensure_installed, "netcoredbg")
            table.insert(opts.ensure_installed, "csharpier")
        end,
    }
}
