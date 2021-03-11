## Pedagogisk Mappe (Teaching Portfolio) Lex Nederbragt

Mesteparten av denne **Pedagogiske Mappen** er skrevet på norsk, og kan leses
på/Most of this **Teaching Portfolio** is written in Norwegian,
and can be read at <https://lexnederbragt.github.io/teaching-portfolio>.

Min **undervisningsfilosofi** er skrevet på engelsk/
My **Teaching Philosophy** is written in English:
<https://lexnederbragt.github.io/teaching-portfolio/03_mappe.html>.

Tekstene er skrevet i DocOnce format, som er en markup språk, se URL: "https://doconce.github.io/doconce/doc/pub/manual/manual.html".
Dette formatet kan kompileres til forskjellige
andre formater.


### Word docx format

For å kompilere til Word `.docx` formatet kreves det også
"pandoc": "https://pandoc.org" installert.

Kjør:

```
make pub/mappe.docx
```

(eller bare `make`). Dette lager filen `mappe.docx` i mappen `pub`

### Jupyter Book

For å kompilere til og Jupyter Book kreves det også
"Jupyter Book": "https://jupyterbook.org/intro.html#install-jupyter-book"
installert.

Kjør:

```
make book
```

For å lese boken, åpne filen `book/_build/html/index.html`.

### Markdown

En markdown versjon av teksten, som har noe elementer som ikke vises riktig,
finnes som filen `mappe.md` i `pub` mappen.
