# UniPD "Marco Fanno" Thesis Template

A LaTeX thesis template for the Department of Economics and Management "Marco Fanno", University of Padova. This folder is **fully self-contained** — it does not depend on any other project, and does not require any machine-wide LaTeX configuration beyond a standard TeX distribution.

## Prerequisites

- A TeX distribution: [MiKTeX](https://miktex.org/) (Windows) or [TeX Live](https://www.tug.org/texlive/) (macOS/Linux), with `latexmk` and `biber` (both ship with either distribution).
- **Python 3 + [Pygments](https://pygments.org/)** (`pip install Pygments`), required only because this template uses the `minted` package for syntax-highlighted code listings (see `Chapters/Chapter_4_Results.tex`). If you don't need code listings, you can remove `\usepackage{minted}` from `preamble.tex` and drop this requirement (and the `-shell-escape` flag) entirely.
- Recommended editor: [VS Code](https://code.visualstudio.com/) with the [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) extension — this folder's `.vscode/settings.json` configures it automatically.

## How to compile

**VS Code (recommended):** open this folder in VS Code, open `main.tex`, and save — LaTeX Workshop auto-builds on save via `latexmk`, using the recipe already configured in `.vscode/settings.json`.

**Command line:**
```
latexmk -pdf main.tex
```
`latexmk` reads this folder's own `.latexmkrc`, which handles everything a full build needs automatically: `pdflatex` → `biber` (bibliography) → `makeglossaries` (acronym list, if used) → `pdflatex` again, as many times as needed until the Table of Contents, List of Tables/Figures, bibliography, and acronym list are all fully resolved.

To clean generated build files: `latexmk -c` (keeps the PDF) or `latexmk -C` (also removes the PDF).

### Why you should never just run `pdflatex main.tex` once
A single `pdflatex` pass leaves the Table of Contents, List of Tables, List of Figures, bibliography, and acronym list empty or stale — they all depend on auxiliary files written by a *previous* pass, or on external tools (`biber`, `makeglossaries`) that a single `pdflatex` call doesn't invoke. Always compile via `latexmk` (directly, or through your editor's build button), never a single manual `pdflatex` run.

## Folder structure

```
main.tex                 -- entry point: edit the placeholder fields at the top, then \include your chapters
preamble.tex              -- all package loading and styling (generally you shouldn't need to touch this)
Chapters/                 -- one file per chapter, \include'd from main.tex
appendix/                 -- one file per appendix, \include'd from main.tex after \appendix
references.bib            -- your bibliography (BibTeX/biblatex format)
Acronym_Glossary.tex       -- acronym list (edit the \acro{...}{...} entries)
Acknowledgements.tex       -- acknowledgments page
abstract.tex               -- abstract page
Authenticity_Declaration.tex -- standard UniPD anti-plagiarism declaration (do not remove; sign before submission)
unipd-logo.png             -- official UniPD seal, used on the title page
.latexmkrc, .vscode/       -- build configuration (see "How to compile" above)
```

## Customizing the title page

Edit only the placeholder fields near the top of `main.tex`, under `THESIS DETAILS`:

```latex
\newcommand{\ThesisTitleMain}{Your Thesis Title Goes Here}
\newcommand{\ThesisTitleSubtitle}{Your Descriptive Subtitle}
\newcommand{\ThesisAuthor}{Your Full Name}
\newcommand{\ThesisMatricola}{Matricola No. XXXXXXX}
\newcommand{\ThesisSupervisor}{Prof.\ Supervisor Name}
\newcommand{\ThesisDegreeProgram}{Master Degree in Economics and Finance}
\newcommand{\ThesisAcademicYear}{20XX--20XX}
```
The title page layout itself (seal, watermark, two-column author/supervisor block) does not need to change.

## Adding chapters and appendices

1. Create a new file in `Chapters/` (or `appendix/`, after the `\appendix` line).
2. Add `\include{Chapters/Your_New_Chapter}` to `main.tex` in the right place.
3. Recompile.

## Feature guide — where each LaTeX feature is demonstrated

| Feature | Where |
|---|---|
| Citations (`\citep`, `\citet`) | `Chapters/Chapter_1_Introduction.tex`, `Chapters/Chapter_2_LiteratureReview.tex` |
| Cross-references (`\cref`, `\Cref`) | Used throughout — chapters, equations, figures, tables, theorems |
| Footnote with inline math | `Chapters/Chapter_1_Introduction.tex` |
| `booktabs` table | `Chapters/Chapter_2_LiteratureReview.tex` |
| `tabularx` + `threeparttable` table with notes | `Chapters/Chapter_2_LiteratureReview.tex` |
| Equations + `siunitx` units (`\si`, `\SI`) | `Chapters/Chapter_3_Methodology.tex` |
| Custom theorem box (`theo` environment) | `Chapters/Chapter_3_Methodology.tex`, `appendix/Appendix_A.tex` |
| `tikz` diagram | `Chapters/Chapter_3_Methodology.tex` |
| `pgfplots` chart from inline data | `Chapters/Chapter_4_Results.tex` |
| `minted` syntax-highlighted code | `Chapters/Chapter_4_Results.tex` |
| `\includegraphics` (external image file) | `Chapters/Chapter_4_Results.tex` |
| Acronym list | `Acronym_Glossary.tex` |
| Appendix structure | `appendix/Appendix_A.tex` |

## Notes on packages loaded but not exercised by the sample chapters

`preamble.tex` also loads `glossaries` (an alternative to the `acronym` package used here, if you want linked in-text `\gls{}` references instead of a static list), `longtable` (for tables spanning multiple pages), and `listings` (a lighter-weight code-listing alternative to `minted` that needs no Python/shell-escape). These are ready to use if your thesis needs them — just follow each package's standard usage.

## Troubleshooting

- **"minted v3+ executable is not installed..."** — install Python + Pygments (`pip install Pygments`) and make sure `-shell-escape` is enabled (it already is, in both `.latexmkrc` and `.vscode/settings.json` in this folder).
- **ToC / List of Tables / bibliography looks empty or stale** — you likely ran `pdflatex` directly instead of `latexmk`. Always build via `latexmk -pdf main.tex` (see above).
- **Filenames with spaces** — if you add figure files with spaces in their names, wrap the path in curly braces as usual: `\includegraphics{Figures/My Figure.png}`.
