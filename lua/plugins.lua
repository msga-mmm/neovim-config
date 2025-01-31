-- @important: from doc
-- install packer if it's missing
local packer_bootstrap = nil
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

-- @important: from doc
-- auto-compile on change in plugins.lua
vim.cmd([[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

local packer = require("packer")

packer.startup({
    function(use)
        use("wbthomason/packer.nvim")

        -- Fuzzy finder
        use({
            {
                "nvim-telescope/telescope.nvim",
                requires = {
                    "nvim-lua/popup.nvim",
                    "nvim-lua/plenary.nvim",
                },
            },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
            },
            {
                "nvim-telescope/telescope-media-files.nvim",
            },
        })

        -- File explorer
        use("kyazdani42/nvim-tree.lua")

        -- Snippets
        -- use({
        --     {
        --         "hrsh7th/vim-vsnip-integ",
        --         requires = "hrsh7th/vim-vsnip",
        --     },
        --     "rafamadriz/friendly-snippets",
        -- })

        -- LSP (completion & linting)
        use({
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        })
        use({
            "neovim/nvim-lspconfig",
        })

        -- Auto-completion
        use({
            "hrsh7th/nvim-cmp",
            requires = {
                -- pretty icons
                "onsails/lspkind.nvim",

                -- LuaSnip
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
                "rafamadriz/friendly-snippets",
                -- "hrsh7th/cmp-nvim-lua",

                -- "neovim/nvim-lspconfig",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                -- "hrsh7th/cmp-vsnip",
                "lukas-reineke/cmp-under-comparator",
                "andersevenrud/cmp-tmux",

                -- "hrsh7th/vim-vsnip",
                "hrsh7th/cmp-nvim-lsp",
            },
        })

        -- Commenter
        use({
            "numToStr/Comment.nvim",
        })
        use("JoosepAlviste/nvim-ts-context-commentstring")

        -- TreeSitter
        use({
            "nvim-treesitter/nvim-treesitter",
            requires = {
                "nvim-treesitter/nvim-treesitter-refactor",
                "RRethy/nvim-treesitter-textsubjects",
            },
            run = ":TSUpdate",
        })

        -- Fancy icons
        use("kyazdani42/nvim-web-devicons")

        -- Pairing
        use("windwp/nvim-autopairs")

        -- Outline
        use("simrat39/symbols-outline.nvim")

        -- Identation viewer
        use("lukas-reineke/indent-blankline.nvim")

        -- Colorscheme
        use("bluz71/vim-nightfly-guicolors")

        -- use "tpope/vim-surround"
        --[[ use {
        "mattn/emmet-vim",
        setup = function ()
            vim.g.user_emmet_leader_key = ','
        end
    } ]]
        -- use "windwp/nvim-ts-autotag"

        -- Viewer/Remover trailing spaces
        use("ntpeters/vim-better-whitespace")

        -- use "akinsho/toggleterm.nvim"

        -- QuickFixer (LSP diagnostic)
        use({
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
        })

        -- Rainbow pairing
        --use("p00f/nvim-ts-rainbow")

        -- Markdown previewer
        use({
            "iamcco/markdown-preview.nvim",
            run = "cd app && npm install",
            setup = function()
                vim.g.mkdp_filetypes = { "markdown" }
                vim.g.mkdp_echo_preview_url = 1
            end,
            ft = { "markdown" },
        })
        -- use({
        --     "iamcco/markdown-preview.nvim",
        --     run = function()
        --         vim.fn["mkdp#util#install"]()
        --     end,
        -- })

        -- Git
        use("tpope/vim-fugitive")

        -- LSP
        -- use({
        --     "williamboman/nvim-lsp-installer",
        --     requires = "neovim/nvim-lspconfig",
        --     run = ":LspUninstallAll",
        -- })

        -- Temporal solution for slowness
        -- use("antoinemadec/FixCursorHold.nvim")

        -- .editorconfig
        use("gpanders/editorconfig.nvim")

        -- use "Pocco81/AutoSave.nvim"

        -- use "gioele/vim-autoswap"

        use({
            "jose-elias-alvarez/null-ls.nvim",
            requires = { "nvim-lua/plenary.nvim" },
        })

        use({
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
        })

        -- Lua
        use({
            "SmiteshP/nvim-gps",
            requires = "nvim-treesitter/nvim-treesitter",
        })

        -- use({ "saadparwaiz1/cmp_luasnip" })

        use({
            "ray-x/lsp_signature.nvim",
        })

        use("junegunn/vim-easy-align")

        use("renerocksai/telekasten.nvim")

        use("hrsh7th/cmp-nvim-lua")

        use("udalov/kotlin-vim")

        use("natecraddock/workspaces.nvim")

        use("natecraddock/sessions.nvim")

        use("ahmedkhalf/project.nvim")

        use("folke/tokyonight.nvim")

        use("mfussenegger/nvim-dap")

        -- useful plugin for easier setup between
        -- nvim-dap and mason
        use("jay-babu/mason-nvim-dap.nvim")

        use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

        use("mxsdev/nvim-dap-vscode-js")

        use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

        use({
            "microsoft/vscode-js-debug",
            opt = true,
            run = "npm install --legacy-peer-deps && npm run compile",
        })

        use({
            "jparise/vim-graphql",
            config = function()
                vim.cmd([[
                au BufNewFile,BufRead *.prisma setfiletype graphql
            ]])
            end,
        })

        use("simrat39/rust-tools.nvim")
        use("sigmasd/deno-nvim")
        use("lvimuser/lsp-inlayhints.nvim")

        use("sam4llis/nvim-tundra") -- packer.nvim

        use({
            "pmizio/typescript-tools.nvim",
            requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
            config = function()
                require("typescript-tools").setup({
                    settings = {
                        expose_as_code_action = "all",
                    },
                })
            end,

            -- ft = {
            -- "javascript",
            -- "javascriptreact",
            -- "javascript.jsx",
            -- "typescript",
            -- "typescriptreact",
            -- "typescript.tsx",
            -- "vue",
            -- },
            -- opts = {},
        })

        -- use({
        --     "jose-elias-alvarez/typescript.nvim",
        --     -- config = function()
        --     --     require("typescript").setup({})
        --     -- end,
        -- })

        use("uga-rosa/ccc.nvim")
        use({
            "klen/nvim-test",
            config = function()
                require("nvim-test").setup()
                require("nvim-test.runners.jest"):setup({
                    command = "./node_modules/.bin/react-app-rewired",
                    args = {
                        "test",
                        "--env=jest-environment-jsdom-sixteen",
                    },
                    -- env = { CUSTOM_VAR = "value" },

                    -- file_pattern = "\\v(__tests__/.*|(spec|test))\\.(js|jsx|coffee|ts|tsx)$",
                    -- find_files = { "{name}.test.{ext}", "{name}.spec.{ext}" },

                    -- filename_modifier = nil,
                    -- working_directory = nil,
                })
            end,
        })

        use({
            "glacambre/firenvim",
            run = function()
                vim.fn["firenvim#install"](0)
            end,
        })

        use("jay-babu/mason-null-ls.nvim")

        -- @important: from doc
        -- automatically load the settings after cloning packer.nvim
        if packer_bootstrap then
            packer.sync()
        end

        use({
            "ruifm/gitlinker.nvim",
            requires = "nvim-lua/plenary.nvim",
        })

        use({
            "nvim-telescope/telescope-live-grep-args.nvim",
        })

        use({
            "folke/neodev.nvim",
            config = function()
                require("neodev").setup({
                    -- https://github.com/nvim-neotest/neotest#configuration
                    library = { plugins = { "neotest" }, types = true },
                })
            end,
        })

        use({
            "nvim-neotest/neotest",
            requires = {
                "nvim-neotest/nvim-nio",
                "nvim-lua/plenary.nvim",
                "antoinemadec/FixCursorHold.nvim",
                "nvim-treesitter/nvim-treesitter",

                -- runners
                "nvim-neotest/neotest-jest",
            },
            config = function()
                require("neotest").setup({
                    -- https://github.com/nvim-neotest/neotest-jest#parameterized-tests
                    discovery = {
                        enabled = false,
                    },
                    jestCommand = "npx jest",
                    jestConfigFile = "package.json",
                    cwd = function(path)
                        return vim.fn.getcwd()
                    end,
                })
            end,
        })

        use({
            "kdheepak/lazygit.nvim",
            -- optional for floating window border decoration
            requires = {
                "nvim-lua/plenary.nvim",
            },
        })

        use({
            "lewis6991/gitsigns.nvim",
        })

        use({
            "nomnivore/ollama.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
                require("ollama").setup({})
            end,
        })

        use({
            "huggingface/llm.nvim",
        })

        use({
            "tzachar/cmp-ai",

            requires = {
                "nvim-lua/plenary.nvim",
            },
        })

        use({
            "amitds1997/remote-nvim.nvim",

            requires = {
                "nvim-lua/plenary.nvim",         -- For standard functions
                "MunifTanjim/nui.nvim",          -- To build the plugin UI
                "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
            },

            config = function()
                require("remote-nvim").setup()
            end,
        })

        use({
            "https://gitlab.com/schrieveslaach/sonarlint.nvim",
            config = function()
                require("sonarlint").setup({
                    server = {
                        cmd = {
                            "sonarlint-language-server",
                            -- Ensure that sonarlint-language-server uses stdio channel
                            "-stdio",
                            "-analyzers",
                            -- paths to the analyzers
                            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
                            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
                            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
                            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
                            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarhtml.jar"),
                        },
                    },
                    filetypes = {
                        "python",
                        "cpp",
                        "java",
                        "javascript",
                        "javascriptreact",
                        "typescript",
                        "typescriptreact",
                    },
                })
            end,
        })
    end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end,
        },
        git = {
            clone_timeout = 600,
        },
    },
})
