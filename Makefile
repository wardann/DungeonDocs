.PHONY: typecheck
typecheck:
	lua-language-server --configpath=.vscode/settings.json --logpath . --check .
	node .github/scripts/parse-lls-output check.json
