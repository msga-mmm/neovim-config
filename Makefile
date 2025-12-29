format:
	@stylua .
.PHONY: format

lint:
	@git ls-files '*.lua' | xargs luacheck
.PHONY: lint
