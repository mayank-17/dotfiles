-- LSP Configuration with comprehensive language support
return {
  -- Completion framework
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 1000,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- Command line completion
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      -- Common on_attach function for keymaps
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, silent = true }

        -- LSP keymaps
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)

        -- Diagnostics
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
      end

      -- LSP servers configuration
      local servers = {
        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },

        -- Python
        pyright = {},

        -- JavaScript/TypeScript
        tsserver = {
          settings = {
            typescript = {
              preferences = {
                disableSuggestions = true,
              },
            },
          },
        },

        -- C/C++
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },

        -- Rust
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
            },
          },
        },

        -- Go
        gopls = {
          settings = {
            gopls = {
              experimentalPostfixCompletions = true,
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
              gofumpt = true,
            },
          },
        },

        -- Haskell
        hls = {
          settings = {
            haskell = {
              cabalFormattingProvider = "cabalfmt",
              formattingProvider = "ormolu",
            },
          },
        },

        -- Java
        jdtls = {},

        -- C#
        omnisharp = {
          cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
        },

        -- PHP
        intelephense = {
          settings = {
            intelephense = {
              stubs = {
                "bcmath",
                "bz2",
                "calendar",
                "Core",
                "curl",
                "date",
                "dba",
                "dom",
                "enchant",
                "fileinfo",
                "filter",
                "ftp",
                "gd",
                "gettext",
                "hash",
                "iconv",
                "imap",
                "intl",
                "json",
                "ldap",
                "libxml",
                "mbstring",
                "mcrypt",
                "mysql",
                "mysqli",
                "password",
                "pcntl",
                "pcre",
                "PDO",
                "pdo_mysql",
                "Phar",
                "readline",
                "recode",
                "Reflection",
                "regex",
                "session",
                "SimpleXML",
                "soap",
                "sockets",
                "sodium",
                "SPL",
                "standard",
                "superglobals",
                "sysvsem",
                "sysvshm",
                "tokenizer",
                "xml",
                "xdebug",
                "xmlreader",
                "xmlwriter",
                "yaml",
                "zip",
                "zlib",
                "wordpress",
                "woocommerce",
                "acf-pro",
                "wordpress-globals",
                "wp-cli",
                "genesis",
                "polylang",
              },
              files = {
                maxSize = 5000000,
              },
            },
          },
        },

        -- Elixir
        elixirls = {
          cmd = { "elixir-ls" },
        },

        -- Erlang
        erlangls = {},

        -- OCaml
        ocamllsp = {},

        -- Zig
        zls = {},

        -- Nim
        nimls = {},

        -- Crystal
        crystalline = {},

        -- Dart/Flutter
        dartls = {},

        -- Kotlin
        kotlin_language_server = {},

        -- Scala
        metals = {},

        -- Shell/Bash
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },

        -- PowerShell
        powershell_es = {
          bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
        },

        -- Fish
        fish_lsp = {},

        -- Docker
        dockerls = {},
        docker_compose_language_service = {},

        -- YAML
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://json.schemastore.org/github-action.json"] = "/.github/actions/*/action.yml",
                ["https://json.schemastore.org/docker-compose.json"] = "/*docker-compose*.yml",
                ["https://json.schemastore.org/kustomization.json"] = "/kustomization.yaml",
                ["https://json.schemastore.org/chart.json"] = "/Chart.yaml",
              },
            },
          },
        },

        -- JSON
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },

        -- TOML
        taplo = {},

        -- XML
        lemminx = {},

        -- HTML
        html = {
          filetypes = { "html", "templ" },
        },

        -- CSS
        cssls = {},

        -- Tailwind CSS
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "svelte",
          },
        },

        -- Emmet
        emmet_ls = {
          filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "svelte",
          },
        },

        -- Vue
        volar = {},

        -- Svelte
        svelte = {},

        -- Prisma
        prismals = {},

        -- GraphQL
        graphql = {},

        -- Terraform
        terraformls = {},

        -- Ansible
        ansiblels = {},

        -- Puppet
        puppet = {},

        -- Nginx
        nginx_language_server = {},

        -- SQL
        sqlls = {},

        -- LaTeX
        texlab = {},

        -- Markdown
        marksman = {},

        -- Vim
        vimls = {},

        -- CMake
        cmake = {},

        -- Makefile
        -- Note: No LSP for Makefile, but you can use syntax highlighting

        -- Assembly
        asm_lsp = {},

        -- LLVM IR
        -- Note: Limited LSP support for LLVM IR

        -- Protocol Buffers
        protols = {},

        -- Thrift
        -- Note: Limited LSP support for Thrift

        -- Bazel/BUILD files
        -- Note: Use bzl LSP or Bazel language server

        -- Nix
        nil_ls = {},

        -- Dhall
        dhall_lsp_server = {},

        -- Jsonnet
        jsonnet_ls = {},

        -- Common Lisp
        -- Note: Use SLIME or similar for Common Lisp

        -- Clojure
        clojure_lsp = {},

        -- Racket
        racket_langserver = {},

        -- Scheme
        -- Note: Limited LSP support for Scheme

        -- R
        r_language_server = {},

        -- Julia
        julials = {},

        -- MATLAB
        -- Note: Limited LSP support for MATLAB

        -- Fortran
        fortls = {},

        -- COBOL
        -- Note: Limited LSP support for COBOL

        -- Pascal
        -- Note: Limited LSP support for Pascal

        -- D
        serve_d = {},

        -- F#
        fsautocomplete = {},

        -- VB.NET
        -- Note: Use OmniSharp for VB.NET

        -- Delphi/Object Pascal
        -- Note: Limited LSP support

        -- ActionScript
        -- Note: Limited LSP support

        -- HLSL/GLSL
        -- Note: Limited LSP support for shader languages

        -- VHDL
        -- Note: Limited LSP support for VHDL

        -- Move (Blockchain)
        -- Note: Limited LSP support

        -- Cairo (StarkNet)
        -- Note: Limited LSP support

        -- Substrate/Ink! (Rust-based blockchain)
        -- Note: Use rust-analyzer

        -- Web Assembly Text Format
        -- Note: Limited LSP support

        -- Game Development
        -- Godot GDScript
        -- Note: Use Godot's built-in LSP

        -- Unity C# (use omnisharp)
        -- Unreal C++ (use clangd)

        -- Mobile Development
        -- Swift
        -- sourcekit = {},

        -- Objective-C (use clangd)
        -- Java (Android, use jdtls)
        -- React Native (use tsserver)

        -- Data Science/ML
        -- Python (use pyright)
        -- R (use r_language_server)
        -- Julia (use julials)

        -- DevOps/Infrastructure
        -- Already covered: Docker, Terraform, Ansible, etc.
      }

      -- Setup each server
      for server, config in pairs(servers) do
        config.capabilities = capabilities
        config.on_attach = on_attach
        lspconfig[server].setup(config)
      end
    end,
  },

  -- Mason for LSP server management
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Mason-lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Core languages
          "lua_ls",
          "pyright",
          "ts_ls",
          "clangd",
          "rust_analyzer",
          "gopls",
          "hls",

          -- Web development
          "html",
          "cssls",
          "jsonls",
          "yamlls",
          "tailwindcss",
          "emmet_ls",

          -- System/Shell
          "bashls",
          "dockerls",
          "taplo", -- TOML

          -- Additional popular languages
          "jdtls", -- Java
          "omnisharp", -- C#
          "intelephense", -- PHP
        },
        automatic_installation = true,
      })
    end,
  },

  -- JSON schemas for enhanced JSON/YAML support
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },
}
