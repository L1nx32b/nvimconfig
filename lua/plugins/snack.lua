return {
  -- folke/snacks.nvim - 一个“零食包”式的插件，包含多个独立模块，可选择性启用。旨在替代多个独立插件，减少配置复杂度。
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      -- bigfile — 大文件优化
      bigfile = { enabled = true },
      -- dashboard —— 启动页
      -- function：启动 Neovim 时显示一个美观的仪表盘，通常包含最近打开的文件、项目列表、快捷命令等
      -- 你的配置采用默认设置，会展示一个带有 ASCII 艺术字或图标的启动界面。
      -- default: dashboard = { enabled = true },
      dashboard = { enabled = false },
      
      -- explorer —— 文件树
      -- 已在 ui.lua 使用 nvim-tree.lua，避免冲突
      explorer = { enabled = false },
      -- image —— 图片预览
      -- function：支持在 Neovim 内预览图片（如 Markdown 中的图片链接）和 LaTeX 数学公式。
      -- doc：文档中图片的显示方式，inline = false 表示不在行内显示，
      -- float = false 表示不弹出浮动窗口，但可以通过 :Snacks image.hover 触发悬浮预览。
      -- math：LaTeX 公式渲染，字体设为 small。
      image = {
        enabled = true,
        doc = { inline = false, float = false, max_width = 80, max_height = 40 },
        math = { latex = { font_size = "small" } },
      },
      -- indent — 缩进线
      -- function：显示缩进参考线，帮助对齐代码。
      -- animate：关闭缩进线动画（提升性能）。
      -- indent.only_scope = true：只显示当前作用域（如函数、循环）的缩进线，减少视觉干扰。
      -- scope：高亮当前作用域（如所在函数体），并用下划线标记作用域起始行。
      -- chunk：将作用域渲染为“块”，使代码结构更清晰。
      indent = {
        enabled = true,
        animate = {
          enabled = false
        },
        indent = {
          only_scope = true
        },
        scope = {
          enabled = true,   -- enable highlighting the current scope
          underline = true, -- underline the start of the scope
        },
        chunk = {
          -- when enabled, scopes will be rendered as chunks, except for the top-level scope which will be rendered as a scope.
          enabled = true,
        },
      },
      -- input — 输入增强
      -- function：改进 Neovim 的命令行输入体验，提供历史记录、补全等（类似 fzf-lua 的输入框）。
      input = { enabled = true },
      -- lazygit — Git 终端界面
      -- function：集成终端 Git 客户端 Lazygit，可以在 Neovim 内直接打开 Lazygit 界面。
      -- configure = false：不自动配置 Lazygit 的选项，保留其默认设置。
      lazygit = {
        enabled = true,
        configure = false,
      },
      -- notifier — 通知系统
      -- function：替代 Neovim 原生消息，以浮动窗口或通知条的形式显示信息，更美观且可管理历史。
      -- style = "notification"：使用通知样式（右下角弹出）。
      notifier = {
        enabled = true,
        style = "notification",
      },
      -- picker — 选择器（核心功能）
      -- function 提供类似 Telescope 的模糊查找界面，用于搜索文件、缓冲区、符号、Git 记录等。
      picker = {
        enabled = true,
        previewers = {
          diff = {
            builtin = false,   -- use Neovim for previewing diffs (true) or use an external tool (false)
            cmd = { "delta" }, -- example to show a diff with delta
          },
          git = {
            builtin = false, -- use Neovim for previewing git output (true) or use git (false)
            args = {},       -- additional arguments passed to the git command. Useful to set pager options using `-c ...`
          },
        },
        sources = {
          spelling = {
            layout = { preset = "select" }
          },
        },
        win = {
          input = {
            keys = {
              ["<Tab>"] = { "select_and_prev", mode = { "i", "n" } },
              ["<S-Tab>"] = { "select_and_next", mode = { "i", "n" } },
              ["<A-Up>"] = { "history_back", mode = { "n", "i" } },
              ["<A-Down>"] = { "history_forward", mode = { "n", "i" } },
              ["<A-j>"] = { "list_down", mode = { "n", "i" } },
              ["<A-k>"] = { "list_up", mode = { "n", "i" } },
              ["<C-u>"] = { "preview_scroll_up", mode = { "n", "i" } },
              ["<C-d>"] = { "preview_scroll_down", mode = { "n", "i" } },
              ["<A-u>"] = { "list_scroll_up", mode = { "n", "i" } },
              ["<A-d>"] = { "list_scroll_down", mode = { "n", "i" } },
              ["<c-j>"] = {},
              ["<c-k>"] = {},
            },
          },
        },
        layout = {
          preset = "telescope",
        },
      },
      -- quickfile — 快速文件
      -- function: 记录最近打开的文件，用于快速跳转（类似 viminfo 但更智能）。
      quickfile = { enabled = true },
      -- scroll —— 滚动动画
      -- function: 为窗口滚动添加平滑动画。
      scroll = { enabled = false },
      -- scope —— 范围跳转
      -- 提供类似 [i 和 ]i 的跳转，用于在相同缩进级别的代码块之间移动（比如在函数间跳转）。cursor = false 表示不自动移动光标到作用域开头。
      -- Create keymappings of `ii` and `ai` for textobjects, and `[i` and `]i` for jumps
      scope = {
        enabled = true,
        cursor = false,
      },
      -- statuscolumn —— 状态列
      -- function: 自定义行号区域（状态列），可以显示 Git 状态、诊断符号等，比原生更灵活。
      statuscolumn = { enabled = true },
      -- terminal —— 终端
      -- function: 在 Neovim 中打开终端窗口，支持浮动或分屏。你的配置会在稍后的 styles 中定义终端样式。
      terminal = {
        enabled = true,
      },
      -- words —— 词跳转
      -- function: 高亮当前光标下的单词及其所有出现，并支持 ]] / [[ 在出现位置间跳转。
      words = { enabled = true },
      -- styles.terminal —— 终端窗口样式
      styles = {
        terminal = {
          relative = "editor",
          border = "rounded",
          position = "float",
          backdrop = 60,
          height = 0.9,
          width = 0.9,
          zindex = 50,
        },
      },
    },
    -- keys —— 快捷键映射
    -- 缓冲区管理
    -- <A-w>：调用 snacks.bufdelete() 删除当前缓冲区，比原生 :bdelete 更智能（不会破坏窗口布局）。
    -- 图片预览
    -- <leader>si：悬停显示图片（snacks.image.hover()），适合 Markdown 预览。
    -- 终端
    -- <A-i>：切换终端（snacks.terminal()），在普通模式和终端模式下均可用。
    -- 通知
    -- <leader>sn / <leader>n：打开通知历史选择器。
    -- <leader>un：隐藏所有通知。
    -- 查找文件与缓冲区
    -- <leader><space>：智能查找文件（smart()，混合最近使用和项目文件）。
    -- <leader>, / <leader>sb：查找缓冲区。
    -- <leader>sf：查找项目文件。
    -- <leader>sp：查找项目（最近打开的项目）。
    -- <leader>sr：最近打开的文件。
    -- Git操作
    -- <C-g>：打开 Lazygit。
    -- <leader>gl：Git 日志选择器。
    -- <leader>gd：Git 差异选择器。
    -- <leader>gb：显示当前行的 Git 责备信息。
    -- <leader>gB：在浏览器中打开当前文件的远程仓库页面（Git browse)
    -- 搜索与查询
    -- <leader>sg：全局搜索（grep）。
    -- <leader>s"：寄存器选择器。
    -- <leader>s/：搜索历史。
    -- <leader>sa：拼写建议。
    -- <leader>sA：自动命令选择器。
    -- <leader>s:：命令历史。
    -- <leader>sc：执行命令。
    -- <leader>sd / <leader>sD：诊断信息（全局/当前缓冲区）。
    -- <leader>sH：帮助文档。
    -- <leader>sh：高亮组。
    -- <leader>sI：图标选择器（查看所有可用图标）。
    -- <leader>sj：跳转列表。
    -- <leader>sk：键位映射。
    -- <leader>sl：位置列表。
    -- <leader>sm：标记（marks）。
    -- <leader>sM：手册页。
    -- <leader>sp：插件规格搜索（lazy.nvim）。
    -- <leader>sq：快速修复列表。
    -- <leader>sr：恢复上一次选择器。
    -- <leader>su：撤销历史。
    -- LSP
    -- gd：跳转到定义。
    -- gD：跳转到声明。
    -- gr：查找引用。
    -- gI：跳转到实现。
    -- gy：跳转到类型定义。
    -- <leader>ss：当前文档的 LSP 符号。
    -- <leader>sS：工作区的 LSP 符号。
    -- 词跳转
    -- ]] / [[：在单词引用间跳转（基于 words 模块）。
    -- 禅模式
    -- <leader>z：切换禅模式（隐藏多余界面，专注编辑）。
    -- <leader>Z：切换缩放（仅保留当前窗口）。
    keys = {
      { "<A-w>",           function() require("snacks").bufdelete() end,                    desc = "[Snacks] Delete buffer" },
      { "<leader>si",      function() require("snacks").image.hover() end,                  desc = "[Snacks] Display image" },
      { "<A-i>",           function() require("snacks").terminal() end,                     desc = "[Snacks] Toggle terminal",          mode = { "n", "t" } },
      -- Notification
      { "<leader>sn",      function() require("snacks").picker.notifications() end,         desc = "[Snacks] Notification history" },
      { "<leader>n",       function() require("snacks").notifier.show_history() end,        desc = "[Snacks] Notification history" },
      { "<leader>un",      function() require("snacks").notifier.hide() end,                desc = "[Snacks] Dismiss all notifications" },
      -- Top Pickers & Explorer
      { "<leader><space>", function() require("snacks").picker.smart() end,                 desc = "[Snacks] Smart find files" },
      { "<leader>,",       function() require("snacks").picker.buffers() end,               desc = "[Snacks] Buffers" },
      -- find
      { "<leader>sb",      function() require("snacks").picker.buffers() end,               desc = "[Snacks] Buffers" },
      { "<leader>sf",      function() require("snacks").picker.files() end,                 desc = "[Snacks] Find files" },
      { "<leader>sp",      function() require("snacks").picker.projects() end,              desc = "[Snacks] Projects" },
      { "<leader>sr",      function() require("snacks").picker.recent() end,                desc = "[Snacks] Recent" },
      -- git
      { "<C-g>",           function() require("snacks").lazygit() end,                      desc = "[Snacks] Lazygit" },
      { "<leader>gl",      function() require("snacks").picker.git_log() end,               desc = "[Snacks] Git log" },
      { "<leader>gd",      function() require("snacks").picker.git_diff() end,              desc = "[Snacks] Git diff" },
      { "<leader>gb",      function() require("snacks").git.blame_line() end,               desc = "[Snacks] Git blame line" },
      { "<leader>gB",      function() require("snacks").gitbrowse() end,                    desc = "[Snacks] Git browse" },
      -- Grep
      -- { "<leader>sb", function() require("snacks").picker.lines() end, desc = "[Snacks] Buffer lines" },
      -- { "<leader>sB", function() require("snacks").picker.grep_buffers() end, desc = "[Snacks] Grep open buffers" },
      { "<leader>sg",      function() require("snacks").picker.grep() end,                  desc = "[Snacks] Grep" },
      -- { "<leader>sw", function() require("snacks").picker.grep_word() end, desc = "[Snacks] Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"',      function() require("snacks").picker.registers() end,             desc = "[Snacks] Registers" },
      { '<leader>s/',      function() require("snacks").picker.search_history() end,        desc = "[Snacks] Search history" },
      { "<leader>sa",      function() require("snacks").picker.spelling() end,              desc = "[Snacks] Spelling" },
      { "<leader>sA",      function() require("snacks").picker.autocmds() end,              desc = "[Snacks] Autocmds" },
      { "<leader>s:",      function() require("snacks").picker.command_history() end,       desc = "[Snacks] Command history" },
      { "<leader>sc",      function() require("snacks").picker.commands() end,              desc = "[Snacks] Commands" },
      { "<leader>sd",      function() require("snacks").picker.diagnostics() end,           desc = "[Snacks] Diagnostics" },
      { "<leader>sD",      function() require("snacks").picker.diagnostics_buffer() end,    desc = "[Snacks] Diagnostics buffer" },
      { "<leader>sH",      function() require("snacks").picker.help() end,                  desc = "[Snacks] Help pages" },
      { "<leader>sh",      function() require("snacks").picker.highlights() end,            desc = "[Snacks] Highlights" },
      { "<leader>sI",      function() require("snacks").picker.icons() end,                 desc = "[Snacks] Icons" },
      { "<leader>sj",      function() require("snacks").picker.jumps() end,                 desc = "[Snacks] Jumps" },
      { "<leader>sk",      function() require("snacks").picker.keymaps() end,               desc = "[Snacks] Keymaps" },
      { "<leader>sl",      function() require("snacks").picker.loclist() end,               desc = "[Snacks] Location list" },
      { "<leader>sm",      function() require("snacks").picker.marks() end,                 desc = "[Snacks] Marks" },
      { "<leader>sM",      function() require("snacks").picker.man() end,                   desc = "[Snacks] Man pages" },
      { "<leader>sp",      function() require("snacks").picker.lazy() end,                  desc = "[Snacks] Search for plugin spec" },
      { "<leader>sq",      function() require("snacks").picker.qflist() end,                desc = "[Snacks] Quickfix list" },
      { "<leader>sr",      function() require("snacks").picker.resume() end,                desc = "[Snacks] Resume" },
      { "<leader>su",      function() require("snacks").picker.undo() end,                  desc = "[Snacks] Undo history" },
      -- LSP
      { "gd",              function() require("snacks").picker.lsp_definitions() end,       desc = "[Snacks] Goto definition" },
      { "gD",              function() require("snacks").picker.lsp_declarations() end,      desc = "[Snacks] Goto declaration" },
      { "gr",              function() require("snacks").picker.lsp_references() end,        desc = "[Snacks] References" },
      { "gI",              function() require("snacks").picker.lsp_implementations() end,   desc = "[Snacks] Goto implementation" },
      { "gy",              function() require("snacks").picker.lsp_type_definitions() end,  desc = "[Snacks] Goto t[y]pe definition" },
      { "<leader>ss",      function() require("snacks").picker.lsp_symbols() end,           desc = "[Snacks] LSP symbols" },
      { "<leader>sS",      function() require("snacks").picker.lsp_workspace_symbols() end, desc = "[Snacks] LSP workspace symbols" },
      -- Words
      { "]]",              function() require("snacks").words.jump(vim.v.count1) end,       desc = "[Snacks] Next Reference",           mode = { "n", "t" } },
      { "[[",              function() require("snacks").words.jump(-vim.v.count1) end,      desc = "[Snacks] Prev Reference",           mode = { "n", "t" } },
      -- Zen mode
      { "<leader>z",       function() require("snacks").zen() end,                          desc = "[Snacks] Toggle Zen Mode" },
      { "<leader>Z",       function() require("snacks").zen.zoom() end,                     desc = "[Snacks] Toggle Zoom" },
    },

    init = function()
      local Snacks = require("snacks")
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          Snacks.toggle.new({
            id = "Animation",
            name = "Animation",
            get = function()
              return Snacks.animate.enabled()
            end,
            set = function(state)
              vim.g.snacks_animate = state
            end
          }):map("<leader>ta")

          Snacks.toggle.new({
            id = "scroll_anima",
            name = "Scroll animation",
            get = function()
              return Snacks.scroll.enabled
            end,
            set = function(state)
              if state then
                Snacks.scroll.enable()
              else
                Snacks.scroll.disable()
              end
            end,
          }):map("<leader>tS")

          -- Create some toggle mappings
          Snacks.toggle.dim():map("<leader>tD")

          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tL")
          Snacks.toggle.diagnostics():map("<leader>td")
          Snacks.toggle.line_number():map("<leader>tl")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
            "<leader>tc")
          Snacks.toggle.treesitter():map("<leader>tT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>tb")
          Snacks.toggle.inlay_hints():map("<leader>th")
          Snacks.toggle.indent():map("<leader>tg")
          Snacks.toggle.dim():map("<leader>tD")
          -- Toggle the profiler
          Snacks.toggle.profiler():map("<leader>tpp")
          -- Toggle the profiler highlights
          Snacks.toggle.profiler_highlights():map("<leader>tph")

          vim.keymap.del("n", "grn")
          vim.keymap.del("n", "gra")
          vim.keymap.del("n", "grr")
          vim.keymap.del("n", "gri")

          vim.api.nvim_set_hl(0, "SnacksPickerListCursorLine", { bg = "#313244" })
        end,
      })
    end,
  }
}
