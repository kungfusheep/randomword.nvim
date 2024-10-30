local config = {
	templates = {
		lua = {
			default = 'print(string.format("<word> %s", ${1}))',
			line = "print('<word>')",
		},
	},
	keybinds = {
		default = '<leader>rw',
		line = '<leader>rl',
	}
}

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

-- getTemplate returns the template for the given language and name
local function getTemplate(lang, name)
	local tpl = config.templates
	if tpl[lang] and tpl[lang][name] then
		return tpl[lang][name]
	elseif tpl[lang] and tpl[lang].default then
		return tpl[lang].default
	else
		return "<word>"
	end
end

-- replaceUserDefinedTokens replaces the user-defined tokens in the statement by calling the corresponding functions
local function replace_user_tokens(stmt)
	for userDefinedToken in stmt:gmatch("<(.-)>") do
		local tokenFunction = config.user_tokens[userDefinedToken]
		if tokenFunction then
			stmt = stmt:gsub("<" .. userDefinedToken .. ">", tokenFunction())
		end
	end
	return stmt
end

-- insertDebugPrint inserts a debug print statement at the current cursor position
local function insert_debug_print(templateName)
	local word = get_word()
	local bufferFiletype = vim.bo.filetype
	local template = getTemplate(bufferFiletype, templateName)

	-- replace the word placeholder with the random word
	local stmtWithWord = template:gsub("<word>", word)
	-- remove the cursor placeholder from the statement for backward compatibility
	local stmt = stmtWithWord:gsub("<cursor>", "${1}")
	-- replace the user-defined tokens in the statement
	stmt = replace_user_tokens(stmt)

	-- insert the debug print statement on a new line
	vim.cmd('normal! o ')
	vim.snippet.expand(stmt)
end

-- setup sets up the plugin with the user's configuration.
function M.setup(user_config)
	-- Merge the user config with the default config
	config = vim.tbl_deep_extend("force", config, user_config or {})

	-- Map the commands to Neovim
	vim.api.nvim_create_user_command('RandomWord', function(opts)
		insert_debug_print(opts.args)
	end, { nargs = '?' })

	-- Map the keybinds
	vim.keymap.set('n', config.keybinds.default, ':RandomWord<CR>', { noremap = true, silent = true })
	for name, keybind in pairs(config.keybinds) do
		if name ~= "default" then
			vim.keymap.set('n', keybind, ':RandomWord ' .. name .. '<CR>', { noremap = true, silent = true })
		end
	end
end

return M
