return {
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
    },
    on_attach = function(client)
        if vim.fn.expand('%:e') == 'template' then
            client.stop()
        end
    end,
}
