DEST=/Users/alexajo/github/teaching-portfolio/book


.PHONY: book

all: mappe.docx soeknad.docx

mappe.docx:
	doconce format pandoc main && \
	pandoc -t docx -o $@ main.md

soeknad.docx:
	doconce format pandoc soeknad && \
	pandoc -t docx -o $@ soeknad.md

book: *.do.txt
	doconce jupyterbook main \
	--dest=${DEST} --dest_toc=${DEST} \
	--show_titles sep=section && \
	cat book/01_main.md | python scripts/fix_landing.py > book/01_main.md.new && \
	mv book/01_main.md.new book/01_main.md

build:
	jupyter-book build book --all
