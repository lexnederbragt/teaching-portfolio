# destination for DocOnce export for Jupyterbook
DEST=/Users/alexajo/github/teaching-portfolio/book

.PHONY: all book build clean

all: pub/mappe.docx pub/mappe.md pub/soeknad.docx

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
# --sections_up - move headers up to heading 1 level
src/mappe.md: src/*.do.txt src/papers.bib src/word_template.docx
	doconce format pandoc src/mappe \
	-DDOCX --language=Norwegian \
	--sections_up

# Microsoft word
# --lua-filter=src/pagebreak.lua - enable page breaks between chapters
pub/mappe.docx: src/mappe.md
	echo Converting to docx && \
	pandoc src/mappe.md src/settings-docx.yaml \
	-t docx -o $@ --toc --toc-depth=1 -s \
	--reference-doc src/word_template.docx \
	--citeproc --csl src/plos-computational-biology.csl \
	--lua-filter=src/pagebreak.lua \
    --bibliography src/papers.bib

# markdown
pub/mappe.md: src/mappe.md
	pandoc -s --toc src/mappe.md -o pub/mappe.md

# DocOnce export for Jupyterbook
pub/book: src/*.do.txt
	doconce jupyterbook src/mappe \
	--dest=${DEST} \
	--dest_toc=${DEST} \
	--allow_refs_to_external_docs \
	--titles=titles.txt \
	--show_titles sep=section \
	--language=Norwegian

# build the Jupyterbook
build: pub/book book/*.md
	jupyter-book build book --all

# proposal merittert underiviser 2021
pub/soeknad.docx: src/soeknad.do.txt src/word_template_soeknad.docx
	doconce format pandoc src/soeknad && \
	echo Converting to docx && \
	pandoc -t docx --reference-doc src/word_template_soeknad.docx \
	src/soeknad.md -o $@

# remove files doconce can recreate
clean:
	cd src && \
	doconce clean
