return {
  -- nvim-web-devicons — 图标库
  -- function: 为 Neovim 提供文件类型图标，在文件树、状态栏、标签栏等地方显示对应图标，增强文件辨识度。
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = {
        copilot = {
          icon = "",
          color = "#cba6f7", -- Catppuccin.mocha.mauve
          name = "Copilot",
        },
      },
    },
  },
  -- lualine.nvim —— 底部状态栏美化
  -- opts {
    -- theme = "catppuccin"：状态栏颜色主题与 Catppuccin 配色一致。
    -- always_divide_middle = false：不强制在中间分割状态栏，让布局更紧凑。
    -- component_separators 和 section_separators：将组件之间的分隔符设为空，实现极简风格。
    -- sections：定义活动窗口的底部状态栏从左到右的显示内容：
    --   lualine_a：显示当前模式（普通、插入等）。
    --   lualine_b：显示 Git 分支、diff 统计和 LSP 诊断信息。
    --   lualine_c：显示文件名，并会在后面插入一个自定义的 Copilot 组件（见 config 部分）。
    --   lualine_y：显示文件编码、格式、类型和文件进度百分比。
    --   lualine_z：显示光标位置（行号:列号）。
    --   lualine_x：原本为空，但在 config 中会插入宏录制状态组件。
    -- winbar 和 inactive_winbar：窗口栏配置。活动窗口顶部显示文件名和 LSP 状态，非活动窗口顶部留空白（但仍显示一个分隔符，保证始终可见窗口栏）。
    -- extensions：虽然没有显式写出，但 lualine 支持扩展（如 nvim-tree），这里未直接配置，但通过后续集成自动生效。
    --}
    -- config 函数中的自定义：
    -- 获取 Catppuccin 调色板：local mocha = require("catppuccin.palettes").get_palette("mocha")，以便后续自定义颜色时使用主题色。
    -- 宏录制显示组件 macro_recording:
    --  定义函数 show_macro_recording：当录制宏时（vim.fn.reg_recording() 非空），返回 󰑋 图标加寄存器字母；否则返回空字符串。
    --  将该函数包装为状态栏组件，背景色为 mocha.red（红色），左侧添加  斜角分隔符，右侧添加  斜角分隔符，无内边距。这样录制宏时会在状态栏醒目提示。
    -- Copilot 状态组件 copilot：
    --  使用 copilot-lualine 插件提供的组件，显示 Copilot 连接状态（启用、睡眠、禁用、未知）。
    --  配置了不同状态的颜色（取自主题调色板），例如启用时为绿色（mocha.green），并指定了旋转加载图标的颜色（mocha.mauve）。
    -- 将组件插入状态栏：
    --  table.insert(opts.sections.lualine_x, 1, macro_recording)：将宏录制组件插入 lualine_x 的最左侧。
    --  table.insert(opts.sections.lualine_c, copilot)：将 Copilot 组件追加到 lualine_c（文件名后面）。
    -- 最后调用 require("lualine").setup(opts) 应用配置。
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
       'nvim-tree/nvim-web-devicons',
       "AndreM222/copilot-lualine" ,
    },
    opts = {
      options = {
        theme = "catppuccin",
        always_divide_middle = false,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = { "encoding", "fileformat", "filetype", "progress" },
        lualine_z = { "location" },
      },
      winbar = {
        lualine_a = {
          "filename"
        },
        lualine_b = {
          { function() return " " end, color = 'Comment'},
        },
        lualine_x = {
          "lsp_status"
        }
      },
      inactive_winbar = {
        -- Always show winbar
        lualine_b = { function() return " " end },
      },
    },
    config = function(_, opts)
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      local function show_macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return ""
        else
          return "󰑋 " .. recording_register
        end
      end

      local macro_recording = {
        show_macro_recording,
        color = { fg = "#333333", bg = mocha.red },
        separator = { left = "", right = "" },
        padding = 0,
      }

      local copilot = {
        "copilot",
        show_colors = true,
        symbols = {
          status = {
            hl = {
              enabled = mocha.green,
              sleep = mocha.overlay0,
              disabled = mocha.surface0,
              warning = mocha.peach,
              unknown = mocha.red,
            },
          },
          spinner_color = mocha.mauve,
        },
      }

      table.insert(opts.sections.lualine_x, 1, macro_recording)
      table.insert(opts.sections.lualine_c, copilot)

      require("lualine").setup(opts)
    end
  },
  -- barbar.nvim — 标签页增强
  -- function：美化并增强 Neovim 的多个文件缓冲区标签页（tabline），使多个文件的切换更直观。
  -- keys：定义了一系列快捷键，用于快速操作缓冲区：
  --  <A-h> / <A-l>：切换到上一个/下一个缓冲区。
  --  <A-< / <A->>：移动当前缓冲区到左侧/右侧。
  --  <A-1> 到 <A-9>：直接跳转到第 1~9 号缓冲区。
  {
    'romgrk/barbar.nvim',
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    event = { "VeryLazy" },
    keys = {
      { "<A-<>", "<CMD>BufferMovePrevious<CR>", mode = {"n"}, desc = "[Buffer] Move buffer left"  },
      { "<A->>", "<CMD>BufferMoveNext<CR>",     mode = {"n"}, desc = "[Buffer] Move buffer right" },
      { "<A-1>", "<CMD>BufferGoto 1<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 1"    },
      { "<A-2>", "<CMD>BufferGoto 2<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 2"    },
      { "<A-3>", "<CMD>BufferGoto 3<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 3"    },
      { "<A-4>", "<CMD>BufferGoto 4<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 4"    },
      { "<A-5>", "<CMD>BufferGoto 5<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 5"    },
      { "<A-6>", "<CMD>BufferGoto 6<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 6"    },
      { "<A-7>", "<CMD>BufferGoto 7<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 7"    },
      { "<A-8>", "<CMD>BufferGoto 8<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 8"    },
      { "<A-9>", "<CMD>BufferGoto 9<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 9"    },
      { "<A-h>", "<CMD>BufferPrevious<CR>",     mode = {"n"}, desc = "[Buffer] Previous buffer"   },
      { "<A-l>", "<CMD>BufferNext<CR>",         mode = {"n"}, desc = "[Buffer] Next buffer"       },
    },
    opts = {
      animation = false,
      -- Automatically hide the tabline when there are this many buffers left.
      -- Set to any value >=0 to enable.
      auto_hide = 1,

      -- Set the filetypes which barbar will offset itself for
      sidebar_filetypes = {
        NvimTree = true, -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
      },
    },
  },
  -- 文件树浏览器
  -- function: 在侧边栏显示项目文件树，方便浏览和打开文件。
  -- keys：
  --  <leader>e 来打开/关闭文件树。
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>e", "<CMD>NvimTreeToggle<CR>", mode = {"n"}, desc = "[NvimTree] Toggle NvimTree" },
    },
    opts = {}
  },

  -- rainbow-delimiters 彩虹括号
  -- function: 将代码中的括号（圆括号、方括号、花括号）用不同颜色高亮显示，提高代码可读性。
  {
    "HiPhish/rainbow-delimiters.nvim",
    main = "rainbow-delimiters.setup",
    submodules = false,
    opts = {}
  },
  -- 消息界面增强
  -- keys:
  --  <leader>sN 打开notice历史的挑选器
  --  <leader>N 打开Notice历史消息列表
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- {"rcarriga/nvim-notify", opts = {background_colour = "#000000"}}
    },
    keys = {
      { "<leader>sN", "<CMD>Noice pick<CR>", desc = "[Noice] Pick history messages" }, -- FIXME: Currently unusable
      { "<leader>N", "<CMD>Noice<CR>", desc = "[Noice] Show history messages" },
    },

    opts = {
      popupmenu = {
        enabled = false,
      },
      notify = {
        enabled = false,
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
          ["vim.lsp.util.stylize_markdown"] = false,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      routes = {
        -- Hide search count
        { filter = { event = "msg_show", kind = "search_count", }, opts = { skip = true }, },
        -- Hide written message
        { filter = { event = "msg_show", kind = "", }, opts = { skip = true }, },
      },
    }
  },
  -- mini.diff - Git 行级差异提示
  -- 作用：在缓冲区左侧显示 Git 修改状态（新增、修改、删除的行标记）
  {
    "echasnovski/mini.diff",
    event = "VeryLazy",
    version = "*",
    opts = {},
  },

  -- which-key - 按键提示
  -- function: 当你按下部分前缀键（如 <leader>）时，弹出浮动窗口显示后续可用的按键及其说明，帮助记忆和探索快捷键。
  -- keys:
  --  <leader>?: 调用 which-key.show({ global = false })，显示当前缓冲区局部的按键映射，方便查看。
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = "helix",
      win = {
        -- no_overlap = true,
        title = false,
        width = 0.5,
      },
      -- stylua: ignore
      spec = {
        { "<leader>cc", group = "<CodeCompanion>", icon = "" },
        { "<leader>s",  group = "<Snacks>"                    },
        { "<leader>t",  group = "<Snacks> Toggle"             },
      },
      -- expand all nodes wighout a description
      expand = function(node)
        return not node.desc
      end,
    },
    keys = {
      -- stylua: ignore
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "[Which-key] Buffer Local Keymaps", },
    },
  },

}
