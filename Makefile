.PHONY: tests
tests:
	busted --pattern ".*.test.lua" --helper Mocks/Globals.lua .

.PHONY: typecheck
typecheck:
	@if [ -f check.json ]; then echo 'Removing old check.json'; rm check.json; fi
	lua-language-server --check_format=json --configpath=.vscode/settings.json --logpath . --check . --check_out_path=check.json
	node .github/scripts/parse-lls-output check.json

.PHONY: lint
lint:
	luacheck .
	stylua . --check

.PHONY: format-files
format-files:
	stylua .
