dashboard = {
        enabled = true,
        preset = {
          -- 头部字符画
          -- img2art - 将png图片转化为ascii
          -- img2art .\116603054_p0.jpg  --scale 0.03  --threshold 50  --save-raw ./test.lua --alpha
          -- function: 将本地图片解析完之后，转换成开箱即用的lua格式并保存在本地
          -- –scale 姑且理解为缩放值，浮点数，调整以确保能适配你的neovim主页
          -- –threshold 这是一个色彩相关的数据，调整以确保生成满足你色彩需求的图片
          -- 剩余的指令就是生成适合alpha配置的dashboard图片标题信息的结构体lua文件
          header = [[
--                                    ___________________       _____________
  --------_,,_____-----------         I   EVERGREEN     I       I
  I~~~~~~~         ~ ~ ~ IooI___     _I-----------------I_     _I------------
I_I_=_=_=____NS______----I__I__I_I __I \----------------/I__ __I \-----------
`-'O==O==O~============~O==O==O`-'~`o==o---------------o==o'~`o==o-----------
          ]],

          -- 自定义快捷键
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },

        -- item field formatters 格式化器
        formats = {
          icon = function(item)
            if item.file and item.icon == "file" or item.icon == "directory" then
              return Snacks.dashboard.icon(item.file, item.icon)
            end
            return { item.icon, width = 2, hl = "icon" }
          end,
          footer = { "%s", align = "center" },
          header = { "%s", align = "center" },
          file = function(item, ctx)
            local fname = vim.fn.fnamemodify(item.file, ":~")
            fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
            if #fname > ctx.width then
              local dir = vim.fn.fnamemodify(fname, ":h")
              local file = vim.fn.fnamemodify(fname, ":t")
              if dir and file then
                file = file:sub(-(ctx.width - #dir - 2))
                fname = dir .. "/…" .. file
              end
            end
            local dir, file = fname:match("^(.*)/(.+)$")
            return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
          end,
        },

        -- 自定义页面排版
        sections = {
          -- {
          --  section = "terminal",
          --  cmd = "sh -c 'chafa -c full --symbols vhalf -s 80x24 ~/.config/nvim/lua/pic/bocchi.png'",
          --  height = 19,
          --  padding = 2,
          -- },
          { section = "header" },
          { section = "keys",   gap = 1, padding = 1 },
          { section = "startup" },
        },
        debug = false,
      },