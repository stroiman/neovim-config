.PHONY: install
install: install/pull install/luasnip

install/pull:
	git submodule update --init

install/luasnip:
	make -C pack/vendor/opt/luasnip install_jsregexp
