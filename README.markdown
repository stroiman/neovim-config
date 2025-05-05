# Stroiman's neovim config

This is my re-sourcable, plugin-manager free neovim configuration

## Installation

Run the default make target in the root.

```sh
> make
```

The make task will

- Fetch plugins that exist as git submodules
- Execute custom build steps for luasnip.

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


