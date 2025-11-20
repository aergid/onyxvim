return {
  {
    "marks.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("marks").setup({
        default_mappings = false,
        mappings = {
          delete_line = "mx",
          delete_buf = "mX",
          -- set_next = false,
          -- toggle = false,
          next = "m]",
          prev = "m[",
          preview = "m:",
          -- set = false,
          -- delete = false,
          -- set_bookmark = false,
          -- delete_bookmark = false,
          -- next_bookmark = false,
          -- prev_bookmark = false,
          -- annotate = false,
        },
        -- whether cycle back to the beginning/end of buffer
        cyclic = true,
        -- Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = "⚑",
          virt_text = "",
          -- prompt for a virtual line annotation when setting a bookmark
          annotate = false,
        },
      })

      -- disable distracting highlights
      vim.cmd([[
        highlight MarkSignHL guibg=NONE guifg=NONE
        highlight MarkSignNumHL guibg=NONE guifg=NONE
        highlight MarkVirtTextHL guibg=NONE guifg=NONE
    ]])
    end,
  },
}
