return {
  settings = {
    yaml = {
      schemaStore = {
        enable = false,  -- disable built-in schemastore (we use SchemaStore.nvim)
        url = "",
      },
      schemas = require("schemastore").yaml.schemas(),
      validate = true,
      format = { enable = true },
    },
  },
}
