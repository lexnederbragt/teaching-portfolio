all: mappe.docx soeknad.docx

mappe.docx:
	doconce format pandoc main && \
	pandoc -t docx -o $@ main.md

soeknad.docx:
	doconce format pandoc soeknad && \
	pandoc -t docx -o $@ soeknad.md

book:
	doconce jupyterbook main \
	--dest=$DEST --dest_toc=$DEST \
	--show_titles sep=section
