return {
  -- nvim-treesitter - 代码高亮插件
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- 使用最新的commit
    build = ":TSUpdate",
    config = function()
      -- 使用 pcall 防止插件未下载完时直接报错崩溃
      local status_ok, configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end

      configs.setup({
        auto_install = true,
        sync_install = false,
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "cpp", "java", "go", "markdown", "markdown_inline", "vue", "css" },
        highlight = { enable = true },
        indent = { enable = true }, -- 开启treesitter缩进
      })
    end,
  },
}
