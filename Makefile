DEST=/Users/alexajo/github/teaching-portfolio/book

.PHONY: book build clean

all: pub/mappe.docx pub/soeknad.docx

book: pub/book

src/papers.bib : src/papers.pub
	cd src && publish export papers.bib

pub/mappe.docx: src/*.do.txt src/papers.bib
	doconce format pandoc src/main && \
	pandoc -t docx -o $@ --toc --toc-depth=2 -s \
	--citeproc --csl src/plos-computational-biology.csl \
    --bibliography src/papers.bib \
	src/main.md

pub/soeknad.docx: src/soeknad.do.txt
	doconce format pandoc src/soeknad && \
	pandoc -t docx -o $@ src/soeknad.md

pub/book: src/*.do.txt
	doconce jupyterbook src/main \
	--dest=${DEST} --dest_toc=${DEST} \
	--allow_refs_to_external_docs \
	--show_titles sep=section && \
	cat book/01_main.md | python scripts/fix_landing.py > book/01_main.md.new && \
	mv book/01_main.md.new book/01_main.md

build: book book/*.md
	jupyter-book build book --all

clean:
	cd src && \
	doconce clean
