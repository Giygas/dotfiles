---@brief
---
--- https://github.com/python-lsp/python-lsp-server
---
--- A Python 3.6+ implementation of the Language Server Protocol.
---
--- See the [project's README](https://github.com/python-lsp/python-lsp-server) for installation instructions.
---
--- Configuration options are documented [here](https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md).
--- In order to configure an option, it must be translated to a nested Lua table and included in the `settings` argument to the `config('pylsp', {})` function.
--- For example, in order to set the `pylsp.plugins.pycodestyle.ignore` option:
--- ```lua
--- vim.lsp.config('pylsp', {
---   settings = {
---     pylsp = {
---       plugins = {
---         pycodestyle = {
---           ignore = {'W391'},
---           maxLineLength = 100
---         }
---       }
---     }
---   }
--- })
--- ```
---
--- Note: This is a community fork of `pyls`.

---@type vim.lsp.Config
return {
	cmd = { "pylsp" },
	vim.lsp.config("pylsp", {
		settings = {
			pylsp = {
				signature = {
					formatter = "black",
				},
				plugins = {
					pycodestyle = { enabled = true, maxLineLength = 100 },
					pyflakes = { enabled = true },
					pylint = { enabled = false }, -- optional
					mccabe = { enabled = false },
					jedi_completion = {
						enabled = true,
						-- include_function_objects = true,
						-- include_class_objects = true,
					},
				},
			},
		},
	}),
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		".git",
	},
}
