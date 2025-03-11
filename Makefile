.PHONY: tests
tests:
	busted --pattern ".*.test.lua" --helper Mocks/Globals.lua .

.PHONY: typecheck
typecheck:
	lua-language-server --configpath=.vscode/settings.json --logpath . --check .
	sleep 1
	node .github/scripts/parse-lls-output check.json

.PHONY: lint
lint:
	luacheck .
	stylua . --check

.PHONY: format-files
format-files:
	stylua .
