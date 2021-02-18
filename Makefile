DEST=/Users/alexajo/github/teaching-portfolio/book

.PHONY: book build clean

all: pub/mappe.docx pub/soeknad.docx

book: build

src/papers.bib : src/papers.pub
	cd src && publish export papers.bib

src/main.md: src/*.do.txt src/papers.bib
	doconce format pandoc src/main

pub/mappe.docx: src/main.md
	pandoc src/main.md src/settings-docx.yaml \
	-t docx -o $@ --toc --toc-depth=2 -s \
	--citeproc --csl src/plos-computational-biology.csl \
    --bibliography src/papers.bib \

pub/soeknad.docx: src/soeknad.do.txt
	doconce format pandoc src/soeknad && \
	pandoc -t docx -o $@ src/soeknad.md

pub/book: src/*.do.txt
	doconce jupyterbook src/main \
	--dest=${DEST} --dest_toc=${DEST} \
	--allow_refs_to_external_docs \
	--titles=titles.txt \
	--show_titles sep=section

build: pub/book book/*.md
	jupyter-book build book --all

clean:
	cd src && \
	doconce clean
