-- NOTE: This is where your plugins related to LSP can be installed.
--  The configuration is done below. Search for lspconfig to find it below.
return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		{ "mason-org/mason.nvim", opts = {} }, --, config = true },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{
			"seblyng/roslyn.nvim",
			---@module 'roslyn.config'
			---@type RoslynNvimConfig
			opts = {
				-- your configuration comes here; leave empty for default settings
			},
		},

		-- Useful status updates for LSP
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

		-- Configures Lua LSP for nvim config, neovim runtime and plugin directorys
		-- Various Annotations and hovers
		"folke/neodev.nvim",
		-- {
		-- 	"chomosuke/typst-preview.nvim",
		-- 	lazy = false, -- or ft = 'typst'
		-- 	version = "1.*",
		-- 	opts = {}, -- lazy.nvim will implicitly calls `setup {}`
		-- 	dependencies_bin = {tinymist = "tinymist.cmd"}
		-- },
	},
	-- [[ Configure LSP ]]
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-ref-lsp-attach", { clear = true }),
			--This function gets run when an LSP attaches to a particular buffer.
			--That is to say, every time a new file is opened that is associated with
			--an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--function will be executed to configure the current buffer
			callback = function(event)
				-- NOTE: Remember that lua is a real programming language, and as such it is possible
				-- to define small helper and utility functions so you don't have to repeat yourself
				-- many times.
				--
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				local imap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("i", keys, func, { buffer = bufnr, desc = desc })
				end

				nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

				nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
				nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				nmap("<leader>gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

				-- See `:help K` for why this keymap
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
				imap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

				-- Lesser used LSP functionality
				nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
				nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				nmap("<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[W]orkspace [L]ist Folders")

				-- Create a command `:Format` local to the LSP buffer
				vim.api.nvim_buf_create_user_command(event.buf, "Format", function(_)
					vim.lsp.buf.format()
				end, { desc = "Format current buffer with LSP" })

				-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
				---@param client vim.lsp.Client
				---@param method vim.lsp.protocol.Method
				---@param bufnr? integer some lsp support methods only in specific files
				---@return boolean
				local function client_supports_method(client, method, bufnr)
					if vim.fn.has("nvim-0.11") == 1 then
						return client:supports_method(method, bufnr)
					else
						return client.supports_method(method, { bufnr = bufnr })
					end
				end

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client
					and client_supports_method(
						client,
						vim.lsp.protocol.Methods.textDocument_documentHighlight,
						event.buf
					)
				then
					local highlight_augroup =
						vim.api.nvim_create_augroup("kickstart-ref-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-ref-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-ref-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if
					client
					and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
				then
					nmap("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end

				-- lspclient specific commands and keymaps
				if client and client["name"] == "tinymist" then
					opentypstpdf = function()
						local filepath = vim.api.nvim_buf_get_name(0)

						if filepath:match("%.typ$") then
							local pdf_path = filepath:gsub("%.typ$", ".pdf")
							print(pdf_path)

							vim.system({ "zathura", pdf_path })
						end
					end
					vim.api.nvim_create_user_command("OpenTypstPdf", opentypstpdf, {})
					nmap("<leader>ll", opentypstpdf, "Open Typst PDF")
				end

			end,
		})
		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--
		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			clangd = {},
			gopls = {},
			pyright = {},
			rust_analyzer = {},
			ts_ls = {},
			cssls = { filetypes = { "css", "scss", "less" } },
			html = { filetypes = { "html", "twig", "hbs" } },
			astro = {},
			roslyn = {},
			rzls = {},
			tinymist = {
			        settings = {
				    formatterMode = "typstyle",
				    exportPdf = "onSave",
				    semanticTokens = "disable",
				},
			},
			lua_ls = {
				Lua = {
					-- completion = {
					--     callSnippet = Replace
					-- },
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
					-- diagnostics = { disable = { 'missing-fields' } },
					diagnostics = {
						-- disable = { 'missing-fields' }
					},
				},
			},
		}

		-- Setup neovim lua for developing neovim configuration
		require("neodev").setup()

		if vim.api.nvim_buf_get_name(0):find("LuaSnip") then
			servers.lua_ls.Lua.diagnostics.globals = {
				"ls",
				"s",
				"sn",
				"isn",
				"t",
				"i",
				"f",
				"c",
				"d",
				"r",
				"evetns",
				"ai",
				"extras",
				"l",
				"rep",
				"p",
				"m",
				"n",
				"dl",
				"fmt",
				"fmta",
				"conds",
				"postfix",
				"types",
				"parse",
				"ms",
				"k",
			}
		end

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
		})

		require("mason").setup({
			registries = {
				"github:Crashdummyy/mason-registry", -- this contains the register for Roslyn
				"github:mason-org/mason-registry",
			},
		})

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup()

		-- TODO make the servers load all the specific settings
		vim.lsp.config("tinymist", servers["tinymist"])


	end,
}
