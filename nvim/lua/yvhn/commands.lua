local nnoremap = require("yvhn.keymap").nnoremap

-- toggle relative number
vim.api.nvim_create_user_command("ToggleRelativeNumber", function()
	local is_relative_number = vim.o.relativenumber
	if is_relative_number then
		vim.o.relativenumber = false
	else
		vim.o.relativenumber = true
	end
end, {})
nnoremap("<Leader>tn", vim.cmd.ToggleRelativeNumber, {
	desc = "Toggle between absolute and relative line numbers",
	silent = true,
})

-- toggle zen mode
vim.api.nvim_create_user_command("ToggleZenMode", function()
	local is_zen_mode = vim.o.showcmd and vim.o.number
	if is_zen_mode then
		vim.opt.showcmd = false
		vim.opt.laststatus = 0
		vim.opt.number = false
		vim.opt.relativenumber = false
	else
		vim.opt.showcmd = true
		vim.opt.laststatus = 2
		vim.opt.number = true
		vim.opt.relativenumber = false
	end
end, {})
nnoremap("<Leader>tz", vim.cmd.ToggleZenMode, {
	desc = "Remove distractions and focus on the code",
	silent = true,
})

-- toggle copilot
local is_copilot_enabled = true
vim.api.nvim_create_user_command("ToggleCopilot", function()
	if is_copilot_enabled then
		vim.cmd(":Copilot disable")
		print("Copilot disabled")
	else
		vim.cmd(":Copilot enable")
		print("Copilot enabled")
	end
	is_copilot_enabled = not is_copilot_enabled
end, {})
nnoremap("<Leader>tc", vim.cmd.ToggleCopilot, {
	desc = "Toggle Copilot",
})
nnoremap("<Leader>cs", "<cmd>:Copilot status<CR>")
