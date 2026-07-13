all: pdf

pdf:
	uv run jb build --all --builder=pdflatex -W .
	cp _build/latex/asyncio.pdf asyncio.pdf

html:
	uv run jb build --all -W .

publish: html
	ghp-import -npf _build/html -c asyncio.mathspp.com
