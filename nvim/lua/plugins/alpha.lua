local function divwidth(divby)
    return math.floor(vim.api.nvim_win_get_width(0) / divby)
end

local function gettime()
    local total_plugins = require('lazy').stats().count
    local datetime = os.date(' %d-%m-%Y   %H:%M:%S')
    local version = vim.version()
    local nvim_version_info = '   v'
        .. version.major
        .. '.'
        .. version.minor
        .. '.'
        .. version.patch

    return datetime
        .. '   '
        .. total_plugins
        .. ' plugins'
        .. nvim_version_info
end

local function header()
    local header = {
        type = 'text',
        opts = {
            position = 'center',
            hl = 'Type',
        },
    }

    header.val = {
        '                                                       ',
        '   ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓  ',
        '   ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒  ',
        '  ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░  ',
        '  ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██   ',
        '  ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒  ',
        '  ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░  ',
        '  ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░  ',
        '     ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░     ',
        '           ░    ░  ░    ░ ░        ░   ░         ░     ',
        '                                  ░                    ',
    }

    return header
end

local function time()
    return { type = 'text', val = gettime(), opts = { position = 'center' } }
end

local function buttons()
    local a_dashboard = require('alpha.themes.dashboard')

    local buttons = {
        type = 'group',
        opts = {
            spacing = 1,
        },
    }

    buttons.val = {
        a_dashboard.button(
            'e',
            '  > New file',
            ':ene <BAR> startinsert <CR>'
        ),
        a_dashboard.button(
            'f',
            '  > Find file',
            ':Neotree float filesystem toggle=true<CR>'
        ),
        a_dashboard.button(
            's',
            '  > Settings',
            ':e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>'
        ),
        a_dashboard.button('q', '  > Quit NVIM', ':qa<CR>'),
    }

    return buttons
end

local function setup()
    local a_startify = require('alpha.themes.startify')

    return {
        layout = {
            { type = 'padding', val = 2 },
            header(),
            { type = 'padding', val = 2 },
            time(),
            { type = 'padding', val = 2 },
            buttons(),
            { type = 'padding', val = 1 },
            a_startify.section.mru_cwd,
            { type = 'padding', val = 2 },
        },
        opts = {
            margin = divwidth(3),
            redraw_on_resize = true,
            setup = a_startify.config.opts.setup,
        },
    }
end

local config = function()
    require('alpha').setup(setup())

    vim.cmd([[
        autocmd FileType alpha setlocal nofoldenable
    ]])
end

return {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = config,
}
