
VERSION?=

publish:
	@bash ./scripts/publish.sh

require-version:
ifndef VERSION
	$(error 'VERSION' is undefined)
else
	@echo "configured for ${VERSION}"
endif

