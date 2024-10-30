# randomword.nvim

This Neovim plugin generates random words and inserts debug print statements with those words into your code. It provides a convenient way to add quick debug statements that are easy to find while printf debugging. It can be easily configured to use your own templates, which are selected on a per-language basis.

<img width="342" alt="image" src="https://github.com/kungfusheep/randomword.nvim/assets/6867511/f22518f0-110e-4630-b9ae-2b8ac9ea0412">


## Features

- Generates random 5-letter words by combining syllables.
- Supports language-specific templates for debug print statements.
- Allows simple customization of templates and keybinds.
- Provides a user command and keybinds for easy insertion of debug print statements.

## Installation

You can install the plugin using your preferred package manager, below is an example using Lazy:

```lua
{
    "kungfusheep/randomword.nvim",
    event = "VeryLazy",
    config = function()
        require("randomword").setup({  })
    end,
}
```

## Configuration

You can configure the plugin by calling the `setup` function in your Neovim configuration file. It's here you configure the templates for the lanaguage you are using, and the keybinds to use the templates.

If no configuration is provided for the language you are using, the plugin will insert a random word on the current line by itself.

Below is an example of how to configure the plugin to use templates and keybinds for Lua and Go:

```lua
require('randomword').setup({
    templates = {
        lua = {
            default = 'print(string.format("<word> %s", ${1}))',
            line = "print('<word>')",
        },
        go = {
            default = 'fmt.Printf("<word>: %v \\n", ${1})',
            line = 'fmt.Println("<word>")',
        },
        -- Add more language-specific templates here
    },
    keybinds = {
        default = '<leader>rw',
        line = '<leader>rl',
        -- Add more keybinds here
    }
})
```

- `templates`: Defines the language-specific templates for debug print statements. Each language can have a `default` template and additional named templates. The `<word>` placeholder will be replaced with the generated random word, and `${1}` will be the cursor position after the template is inserted. The templates are inserted as native neovim snippets and so can contain additional snippet placeholders based on your needs.
- `keybinds`: Defines the keybinds for inserting debug print statements. The `default` keybind is used for the default template, and additional named keybinds can be defined for specific templates. 

## Usage

- To insert a debug print statement using the default template, press the configured `default` keybind in normal mode.
- To insert a debug print statement using a specific named template, press the corresponding keybind in normal mode.
- To insert a debug print statement using the `:RandomWord` command, run `:RandomWord [template-name]` in Neovim, where `[template-name]` is optional and defaults to the `default` template.

## License

This plugin is released under the [MIT License](https://opensource.org/licenses/MIT).
