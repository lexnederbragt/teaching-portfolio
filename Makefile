# destination for DocOnce export for Jupyterbook
DEST=/Users/alexajo/github/teaching-portfolio/book

.PHONY: all book build clean

all: pub/mappe.docx pub/soeknad.docx

book: build

# From Zotero, export collection 'pedagogisk_mappe' to pedagogisk_mappe.bib
# then fix and import (replacing original)
src/papers.pub: src/pedagogisk_mappe.bib
	cd src && \
	rm papers.pub && \
	doconce fix_bibtex4publish pedagogisk_mappe.bib && \
	publish import pedagogisk_mappe.bib

# convert to papers.bib
src/papers.bib : src/papers.pub
	cd src && publish export papers.bib

# markdown, needed for docx
src/main.md: src/*.do.txt src/papers.bib
	doconce format pandoc src/main

# Microsoft word
pub/mappe.docx: src/main.md
	echo Converting to docx && \
	pandoc src/main.md src/settings-docx.yaml \
	-t docx -o $@ --toc --toc-depth=2 -s \
	--reference-doc src/word_template.docx \
	--citeproc --csl src/plos-computational-biology.csl \
    --bibliography src/papers.bib

# DocOnce export for Jupyterbook
pub/book: src/*.do.txt
	doconce jupyterbook src/main \
	--dest=${DEST} --dest_toc=${DEST} \
	--allow_refs_to_external_docs \
	--titles=titles.txt \
	--show_titles sep=section

# build the Jupyterbook
build: pub/book book/*.md
	jupyter-book build book --all

# proposal merittert underiviser 2021
pub/soeknad.docx: src/soeknad.do.txt
	doconce format pandoc src/soeknad && \
	echo Converting to docx && \
	pandoc -t docx --reference-doc src/word_template.docx \
	src/soeknad.md -o $@

# remove files doconce can recreate
clean:
	cd src && \
	doconce clean
