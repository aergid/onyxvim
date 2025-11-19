return {
  {
    "persisted.nvim",
    lazy = false,
    after = function(plugin)
      require("persisted").setup({
        autostart = true,
        autoload = true, -- load session on startup
        on_autoload_no_session = function()
          vim.notify("No existing session to load.")
        end,

        should_save = function()
          local allowed = {
            alpha = false
          }
          return allowed[vim.bo.filetype] or true
        end,

        -- change session file name to match current working directory if it changes
        follow_cwd = false,
        allowed_dirs = {
          "~/Develop",
          "~/Notes",
        },

      })
      -- close nvim-tree before saving
      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "PersistedSavePre",
        group = vim.api.nvim_create_augroup("PersistedHooks", {}),
        callback = function()
          vim.cmd("NvimTreeClose")
        end,
      })
    end,
  },
}
