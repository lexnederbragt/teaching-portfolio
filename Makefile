DEST=/Users/alexajo/github/teaching-portfolio/book

.PHONY: book build

all: pub/mappe.docx pub/soeknad.docx

book: pub/book

pub/mappe.docx: src/*.do.txt
	doconce format pandoc src/main && \
	pandoc -t docx -o $@ --toc --toc-depth=2 -s src/main.md

pub/soeknad.docx: src/soeknad.do.txt
	doconce format pandoc src/soeknad && \
	pandoc -t docx -o $@ src/soeknad.md

pub/book: src/*.do.txt
	doconce jupyterbook src/main \
	--dest=${DEST} --dest_toc=${DEST} \
	--show_titles sep=section && \
	cat book/01_main.md | python scripts/fix_landing.py > book/01_main.md.new && \
	mv book/01_main.md.new book/01_main.md

build: book book/*.md
	jupyter-book build book --all
