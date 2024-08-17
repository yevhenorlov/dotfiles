local function bind(mode, outer_opts)
	return function(lhs, rhs, opts)
		opts = vim.tbl_extend("force", outer_opts or {}, opts or {})
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

local M = {}
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.inoremap = bind("i")

M.buf_nnoremap = bind("n", { buffer = 0 })
M.buf_vnoremap = bind("v", { buffer = 0 })
M.buf_inoremap = bind("i", { buffer = 0 })

return M
