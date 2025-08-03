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

.PHONY: write-changelog
write-changelog:
	@version=$$(grep '## Version:' DungeonDocs.toc | sed 's/^.*: //'); \
	echo "Writing changelog for version: $$version\n"; \
	output=$$(.github/scripts/print-changelog "$$version" 2>&1); \
	ret=$$?; \
	echo "$$output"; \
	if [ $$ret -ne 0 ]; then exit $$ret; fi; \
	echo "$$output" > CHANGELOG.txt; \

.PHONY: write-changelog
generate-profiles:
	cat meta/profiles/DefaultFallback.txt | lua meta/extract-profile-docs/main.lua | node meta/sync-profile-files/index.js "Default Fallback*" > Profiles/DefaultFallback.lua
	stylua ./Profiles