return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- 可选依赖
  ft = { "markdown" }, -- 只在打开 markdown 文件时加载
  opts = {
    -- 在这里配置你的选项，以下是常用设置示例
    file_types = { "markdown" }, -- 启用的文件类型
    -- 是否在切换模式（normal/insert）时自动刷新渲染
    render_modes = true, -- 同时渲染 normal 和 visual 模式下的缓冲区
    -- 代码块样式
    code = {
      enabled = true,
      sign = true, -- 在代码块左侧显示竖线
      style = "full", -- 代码块背景样式：'full' | 'normal' | 'language' | 'minimal'
      position = "left", -- 代码块标记位置：'left' | 'right'
      width = "block", -- 代码块宽度：'block' | 'full'
      left_pad = 1,
      right_pad = 1,
      min_width = 0,
      border = "thin", -- 代码块边框样式：'thin' | 'thick' | 'none'
    },
    -- 标题样式
    heading = {
      enabled = true,
      -- 可以自定义标题的图标、前景色等
      icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " }, -- 六种标题图标
      signs = { " 󰉫 ", " 󰉬 ", " 󰉭 ", " 󰉮 ", " 󰉯 ", " 󰉰 " }, -- 左侧标记
      width = "block",
      left_pad = 1,
      right_pad = 1,
      min_width = 0,
      border = false,
    },
    -- 引用块样式
    quote = {
      enabled = true,
      icon = "▋", -- 引用块左侧的图标
      repeat_linebreak = true,
    },
    -- 列表样式
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" }, -- 列表项图标
      left_pad = 0,
      right_pad = 0,
    },
    -- 表格样式
    table = {
      enabled = true,
    },
    -- LaTeX 公式（需要安装 treesitter 的 latex 解析器）
    latex = {
      enabled = true,
    },
    -- 是否在保存时重新渲染
    on = { "BufReadPost", "BufWritePost" },
  },
  -- 如果你需要更复杂的初始化，可以使用 config 函数
  -- config = function(_, opts)
  --   require("render-markdown").setup(opts)
  --   -- 可以添加自定义命令或键映射
  --   vim.keymap.set("n", "<leader>mr", ":RenderMarkdown toggle<CR>", { desc = "Toggle Markdown Rendering" })
  -- end,
}
