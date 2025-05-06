# Stroiman's neovim config

This is my re-sourcable, plugin-manager free neovim configuration

## Installation

**Requirements:** This configuration requires neovim 0.11. LSP configuration
will not work with earlier versions.

Git clone this to `$HOME/.config.nvim` and run the default make target in the
root. Alternatively, clone to another folder in `$HOME/.config`; see below.

```sh
> make
```

The make task will

- Fetch plugins that exist as git submodules
- Execute custom build steps for luasnip.

Launch neovim, and run 
- `:checkhealth` to check if there are other tools you might want to install,
  like `ripgrep` or `fd`.
- `:helptags ALL` to generate helptags for all the plugins that were loaded.

Note, on first startup, LSPs will be installed by Mason.

### Non-default configuration folder

By default, neovim will load the configuration from the folder, `nvim/` inside
`$HOME/.config`. The default can be overridden using the `NVIM_APPNAME`
environment variable.

```sh
> git clone https://github.com/stroiman/neovim-config $HOME/.config/nvim-stroiman
> cd $HOME/.config/nvim-stroiman
> make
> NVIM_APPNAME=nvim-stroiman nvim
```

You can create an alias for the last command

```sh
> alias nvs="NVIM_APPNAME=nvim-stroiman nvim"
> nvs .
```

This is also used for other relevant stdpath directories, like cache, and data;
so ephemeral data cached by plugins will also be kept separate. See also `:help
stdpath`.

## Philosophy

A vim configuration is a dynamic beast that often mutates over a long period of
time, often as you identify a better way of performing a repetitive task.

My philosophy is that I need to _quickly_ be able to edit my configuration and
re-`:source` it without reloading neovim, i.e., keeping existing buffers open.

Being able to _re-source_ the configuration seems to be the _lost art of neovim
configuration_.

Some changes _may_ require a restact, if I accidentally placed neovim in a bad
state. But restarting should be the exception, not the default.

As plugin managers seem to want to control plugin configuration, they really
work against my purpose. Loading plugins isn't really a difficult task. Plugins
are added as git submodules to this repository, so I have no need for a
lock-file to recreate a known state.

## Configuration

There's some documentation in `init.lua` describing the reasoning behind the
choices. I will extend as I get more time.

### Navigation

Navigation uses 

- netrw, vim's build in file managers. See `:help netrw`
- [Telescope] provides fuzzy finding for virtually everything
- [vim-projectionist] allows describing semantic relationships between files
- Settings inspired by [vim-vinegar], e.g., mapping `-` to open the directory,
  showing the current file in netrw. In netrw itself, `-` navigates to parent
  directory; so this just acts as an "up" command.

[Telescope]: https://github.com/nvim-telescope/telescope.nvim
[vim-projectionist]: https://github.com/tpope/vim-projectionist

### LSP

- [nvim-lspconfig] Provides default configuration for most LSPs. Some
  customization may be necessary.
- [Mason] Helps install LSPs and other tools, such as linters and formatters. 

[nvim-lspconfig]: https://github.com/tpope/vim-projectionist
[Mason]: https://github.com/williamboman/mason.nvim

`nvim-lspconfig` creates the necessary configuration for most LSPs to enable
attaching the right LSP to the buffer. But it doesn't do much more, just set up
a few idiomatic keyboard maps, e.g. `K` which is used for showing documentation,
is mapped to show code documentation for the symbol under the cursor; unless
a map already exist.

> [!Note] 
> Many tutorials include mason-lspconfig, which helps build a bridge from mason
> to lspconfig. At the time of writing this, mason-lspconfig is not updated to
> new neovim 0.11 functionality, and it's documentation suggests using a method
> from lspconfig which is no longer supported. That's why it's not present in
> this configuration.

#### Custom LSP configuration

A new feature of neovim 0.11 is to search for configurations in the `lsp/`
folder, merging any configuration found here with other configurations.

This contains a lua configuration that will find neovim runtime files

### Utils

- [todo-comments] - Highlight `TODO:` style comments, and supports project wide
  navigation.

[todo-comments]: https://github.com/folke/todo-comments.nvim

## Select plugin description

Some plugins deserve a little more explaining

### Projectioninst

This old gem seems to be overlooked by modern neovimmers. The plugin requires a
bit of custom configuration; sometimes on a project basis. But it provides quick
navigation between related files, either in the same window, or new split,
vsplit, or tab.

Some example use cases:

  - Navigate between test and implementation file
  - Navigate between `.cc` and `.h` file
  - Navigate between different languages in translation files.

The navigation can be as simple as just navigate to alternate file, `:A`, or
navigate to a specific related file. E.g., for translations use `:Een` to open
the English translation file, `:Ede` to open the German translation file, etc.

## Usage

Don't expect full documentation of everything here, it just takes to long to
keep up to date. But some essential principles are worth mentioning.

### Working with the configuration itself

It's essential that quick editing, and reapplication of the configuration is
quick and painless.

| Map          | Description                                                                                                                                                                  |
+--------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| `<leader>ve` | **V**im **E**dit. Open `init.lua`. When executed from a project, open a new tab and set the cwd for the tab. If executed from the vim configuration, open in the same window |
| `<leader>vs` | **V**im **S**ource. Run `:source $MYVIMRC`, rerunning the configuration. Remember to save before running                                                                     |
| `<leader>vs` | **V**im e**X**exute. Save and `:source %` (execute currently open file)                                                                                                      |

### LSP

| Map          | Description                                                |
+--------------+------------------------------------------------------------+
| `<leader>ca` | **C**ode **A**ctions                                       |
| `<leader>ca` | **C**ode **R**ename                                        |
| `[d` / `]d`  | Previous/next diagnostics. Shows the diagnostic in a float |
| `gd`         | **G**oto **D**efinition                                    |
| `gr`         | **G**oto **R**eferences                                    |

### Searching

Searching is based on [Telescope]. Be sure to check the documentation regarding
default mappings (I included `<C-q>` as I use it heavily)

| Map          | Description                                                          |
+--------------+----------------------------------------------------------------------+
| `<leader>ff` | **F**ind **F**ilenames                                               |
| `<leader>fg` | **F**ind **G**rep - use ripgrep for fast file content search         |
| `<leader>ft` | **F**ind **T**odd - find `TODO:` style comments with [todo-comments] |
| `<C-q>`      | (Default telescope map) Crate a quicklist with current results       |

## Inspiration

Big shoutout goes to all who has served as inspiration for vim configuration
over many, many years.

- [Vimcasts] by [Drew Neil] - Drew produced a long series of tutorial videos
  for vim back in the day. Some information may may be less relevant today. But
  many are just as relevant today as when they were recorder, and few does a
  better job at explaining core vim concepts.
- [Learn vimscript the Hard Way] by [Steve Losh] - Like VimCasts this is
  somewhat dated, but still a valuable source of information about core vim
  concepts. The series ends with building a plugin. While there may be better
  sources for plugin development today; the series still introduces you to
  almost all concepts you need to know about.
- [TJ DeVries' YouTube Channel] - TJ is a maintainer of neovim, and on his
  channel he regularly explains advanced setup. But TJ does an extremely good
  job of explaining things.
- [Josean Martinez' YouTube Channel] - Josean regularly rebuilds his vim
  configuration, but his channel includes a lot of other related content for
  setting up a developer machine, such as TMUX, terminal configuration, window
  managers.
- [Typecraft's YouTube Channel] - "Typecraft" also have videos where he
  configures neovim from scratch. His resources were the trigger for me to stop
  using the training wheels (lsp-zero) and configure the tools myself (today,
  I'd say LSP configuration is so easy that training wheels are hardly required)

[Vimcasts]: http://vimcasts.org/
[Drew Neil]: http://drewneil.com/
[Learn vimscript the Hard Way]: https://learnvimscriptthehardway.stevelosh.com/
[Steve Losh]: https://stevelosh.com/
[TJ DeVries' YouTube Channel]: https://www.youtube.com/@teej_dv
[Josean Martinez' YouTube Channel]: https://www.youtube.com/@joseanmartinez
[Typecraft's YouTube Channel]: https://www.youtube.com/@typecraft_dev
