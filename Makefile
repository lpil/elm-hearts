SHELL:=/bin/bash

#
# Phony goals
#

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

deploy: dist/main.js dist/index.html ## Push the compiled site to gh-pages
	rm -rf /tmp/elm-hearts-deploy
	mv dist /tmp/elm-hearts-deploy
	cd /tmp/elm-hearts-deploy && \
		git init && \
		git remote add origin git@github.com:lpil/elm-hearts.git && \
		git checkout -b gh-pages && \
		git add --all && \
		git commit -m 'deploy' && \
		git push origin HEAD --force
	rm -rf /tmp/elm-hearts-deploy

clean: ## Delete compiled files
	rm -rf dist

#
# Files
#

dist/index.html: dist
	cp src/index.html dist/index.html

dist/main.js: dist
	elm make src/Main.elm --warn --output dist/main.js

dist:
	mkdir dist

.PHONY: help deploy clean
