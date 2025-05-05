# Stroiman's neovim config

This is my re-sourcable, plugin-manager free neovim configuration

## Installation

Git clone this to `$HOME/.config.nvim` and run the default make target in the
root. Alternatively, clone to another folder in `$HOME/.config`; see below.

```sh
> make
```

The make task will

- Fetch plugins that exist as git submodules
- Execute custom build steps for luasnip.

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

## Check out the code

There's some documentation in `init.lua` describing the reasoning behind the
choices. I will extend as I get more time.
