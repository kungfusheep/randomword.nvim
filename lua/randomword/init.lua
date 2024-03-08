local M = {}

-- Define the syllables
local syllables_2 = { 'ka', 'ki', 'ku', 'ke', 'ko', 'ga', 'gi', 'gu', 'ge', 'go',
	'sa', 'su', 'se', 'so', 'za', 'ji', 'zu', 'ze', 'zo',
	'ta', 'te', 'to', 'da', 'de', 'do', 'na', 'ni', 'nu',
	'ne', 'no', 'ha', 'hi', 'fu', 'he', 'ho', 'ba', 'bi', 'bu',
	'be', 'bo', 'pa', 'pi', 'pu', 'pe', 'po', 'ma', 'mi', 'mu',
	'me', 'mo', 'ya', 'yu', 'yo', 'ra', 'ri', 'ru', 're', 'ro',
	'wa', 'wo' }

local syllables_3 = { 'shi', 'tsu', 'chi', 'nai', 'nei', 'nou', 'sai', 'sei', 'sou',
	'tai', 'tei', 'tou', 'hai', 'hei', 'hou', 'mai', 'mei', 'mou',
	'yai', 'you', 'rai', 'rei', 'rou', 'wai', 'wou',
	'jya', 'jyu', 'jyo', 'gya', 'gyu', 'gyo', 'nya', 'nyu', 'nyo',
	'hya', 'hyu', 'hyo', 'bya', 'byu', 'byo', 'pya', 'pyu', 'pyo',
	'mya', 'myu', 'myo', 'rya', 'ryu', 'ryo' }

-- Function to get a random word
local function get_word()
	return syllables_3[math.random(#syllables_3)] .. syllables_2[math.random(#syllables_2)]
end

M.go_debug_print_var = function()
	local word = get_word()
	local line = string.format('fmt.Printf("%s: %%v\\n", ', word)
	vim.api.nvim_put({ line }, '', true, true)
end

M.go_debug_print_line = function()
	local word = get_word()
	local line = string.format('fmt.Printf("%s")', word)
	vim.api.nvim_put({ line }, '', true, true)
end

M.debug_word = function()
	local word = get_word()
	vim.api.nvim_put({ word }, '', true, true)
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>wd', M.go_debug_print_var, opts)
vim.keymap.set('n', '<leader>wd', M.go_debug_print_line, opts)

-- Map the commands to Neovim
vim.api.nvim_create_user_command('RandomWord', M.debug_word, {})
return M
