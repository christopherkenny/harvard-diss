# `harvard-diss` Format

This template provides a Typst-powered Quarto template to comply with Harvard's dissertation guidelines.

## Installing

```bash
quarto use template christopherkenny/harvard-diss
```

This will install the format extension and create an example qmd file
that you can use as a starting place for your document.

## Using the `harvard-diss` template

This template has many custom options to help fully meet all of Harvard's possible dissertation sections.
Some options you can set:

- `title`: Your thesis's title
- `subtitle`: Your thesis's subtitle
- `abstract`: The abstract for your thesis
- `toc`: Whether to show a Table of Contents (default: `true`)
- `copyright-text`: Copyright information to include after the title page, typically "© [year] [Author’s Name]. All rights reserved."
- `dissertation-advisor`: Name of the dissertation committee chair or co-chairs
- `degree-subject`: Subject of the PhD to include (e.g., "Government")
- `thanks`: Acknowledgements to include at the start of the thesis
- `previous-work`: Citations to previous work, with about one sentence of detail and an inline `@citekey` style citation.
- `dedication`: Dedication of the thesis
- `epigraph`: A quote to include at the start of the thesis
- `epigraph-author`: The author of the quote
- `list-figures`: Should a list of figures be provided at the start?
- `list-tables`: Should a list of tables be provided at the start?
- `biblio-title`: Title of the bibliography (default: "References")



### Fonts

To properly format the dissertation, install [EB Garamond](https://fonts.google.com/specimen/EB+Garamond).

There are other options, listed [here], which can be used. To change the font, use the `mainfont` and `fontsize` parameters in the Quarto YAML.


## License
