return {
  "goolord/alpha-nvim",
    opts = function(_, opts)
      -- 使用 alpha-term 在 Kitty 中渲染图片
      local banner = require("alpha-term").get_banner({
        source = vim.fn.expand("../pic/bocchi.png"), -- 你的图片绝对路径
        height = 20, -- 图片显示的行高
        backend = "kitty", -- 指定 Kitty 后端
      })

      -- 将生成的图片数据设置为标题
      opts.section.header.val = banner
      return opts
    end,
}
