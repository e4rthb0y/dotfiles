return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
    },
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')

        dapui.setup()

        -- 1. Global UI Triggers
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        -- 2. Global Keymaps
        vim.keymap.set('n', '<F5>', function()
            require('dap').continue()
        end, { desc = 'Debug: Start/Continue' })
        vim.keymap.set('n', '<F10>', function()
            require('dap').step_over()
        end, { desc = 'Debug: Step Over' })
        vim.keymap.set('n', '<F11>', function()
            require('dap').step_into()
        end, { desc = 'Debug: Step Into' })
        vim.keymap.set('n', '<leader>b', function()
            require('dap').toggle_breakpoint()
        end, { desc = 'Debug: Toggle Breakpoint' })
    end,
}
