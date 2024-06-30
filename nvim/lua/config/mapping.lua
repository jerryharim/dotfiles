local function nnoremap(rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end


-- Nerd tree

nnoremap('<leader>n', ':NERDTreeFocus<CR>', {noremap = true, silent=true})
nnoremap('<leader>t', ':NERDTreeToggle<CR>', {noremap = true, silent=true})

-- TELESCOPE

local telescope = require('telescope.builtin')

nnoremap('<leader>ff', telescope.find_files, {noremap=true, silent=true}, "Find files")
nnoremap('<leader>fg', telescope.live_grep, {noremap=true, silent=true}, "Live grep")
nnoremap('<leader>fb', telescope.buffers, {noremap=true, silent=true}, "Show buffers")
nnoremap('<leader>fh', telescope.help_tags, {noremap=true, silent=true}, "Help tags")

-- LSP
nnoremap('<leader>fs', "<cmd>Telescope lsp_document_symbols<cr>", {noremap=true, silent=true}, "Find symbols (LSP)")
