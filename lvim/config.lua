--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

-- general
lvim.log.level = "info"
lvim.colorscheme = "lunar"
lvim.format_on_save = {
  enabled = false,
  pattern = "*.lua",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- 需要安装xclip才能使用，在visual模式下按下空格和y可以复制到浏览器
lvim.keys.visual_mode["<Space>y"] = ":w !xclip -selection clipboard<CR>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
-- lvim.colorscheme = "lunar"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

---- treesitter配置
-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true
-- treesitter彩虹括号
lvim.builtin.treesitter.rainbow.enable = true
-- 语法解析器，可以添加语言
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}
-- 指定语言不安装语法解析器
lvim.builtin.treesitter.ignore_install = { "haskell" }
-- 启用语法高亮
lvim.builtin.treesitter.highlight.enable = true

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
    -- 诊断、快速修复和查看LSP，只有输入了cmd = "TroubleToggle"才能加载
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  -- 基于tree-sitter的彩虹括号插件
  {
    "mrjones2014/nvim-ts-rainbow",
  },
  -- 高亮源代码中的TODO、FIXME等注释
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  -- 快速跳转插件
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "m", ":HopLine<cr>", { silent = true })
    end,
  },
  -- 活动窗口高亮突出显示
  {
    "zbirenbaum/neodim",
    lazy = true,
    event = "LspAttach",
    config = function()
      require("neodim").setup({
        alpha = 0.75,
        blend_color = "#000000",
        update_in_insert = {
          enable = true,
          delay = 100,
        },
        hide = {
          virtual_text = true,
          signs = false,
          underline = false,
        },
      })
    end,
  },
  -- 窗口分隔符添加彩色渐变效果
  {
    "nvim-zh/colorful-winsep.nvim",
    lazy = true,
    event = "WinNew",
    config = function()
      require("colorful-winsep").setup()
    end,
  },
  -- rust工具插件 https://github.com/simrat39/rust-tools.nvim https://github.com/LunarVim/LunarVim/issues/2894
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local rs = require("rust-tools")
      rs.setup({
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<Space>z", rs.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Space>a", rs.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      })
      -- 缓冲区嵌套提示
      rs.inlay_hints.set()
      -- 嵌套提示自动更新
      rs.inlay_hints.enable()
      -- RustRunnables
      rs.runnables.runnables()
      -- RustExpandMacro  
      rs.expand_macro.expand_macro()
      -- 向上向下移动项目
      local up = true -- true = move up, false = move down
      rs.move_item.move_item(up)
      -- 悬停动作
      rs.hover_actions.hover_actions()
      -- 打开cargo.toml
      rs.open_cargo_toml.open_cargo_toml()
    end,
  },
  -- 显示符号大纲的插件
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
  },
}


-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
