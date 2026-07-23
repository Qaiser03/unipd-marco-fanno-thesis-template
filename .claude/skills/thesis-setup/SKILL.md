---
name: thesis-setup
description: This skill should be used when the user asks to "set up a new thesis from this template", "replicate this thesis template", "start my thesis using the Marco Fanno template", "personalize this thesis template", "fill in my thesis details", or has just used/cloned the `unipd-marco-fanno-thesis-template` GitHub template repository and wants it turned into their own working thesis project.
---

# Overview

This skill turns a fresh copy of the UniPD "Marco Fanno" thesis template
(`github.com/Qaiser03/unipd-marco-fanno-thesis-template`) into a personalized,
working thesis project: title-page metadata filled in, optionally a brand-new
GitHub repository with its own git history, and a confirmed working
`latexmk` build.

## When to use this

- The user has clicked "Use this template" on GitHub, or cloned/downloaded
  the template, and wants their own thesis details filled in.
- The user asks to start, set up, personalize, or replicate this thesis
  template.
- The user is sitting in a copy of this template folder and asks to fill in
  their title, author, supervisor, etc.

## Required inputs

Ask only for what's missing — infer nothing that changes meaning, like the
degree program title or supervisor's name.

| Placeholder | Maps to (`main.tex`) | Example |
|---|---|---|
| Thesis title | `\ThesisTitleMain` | Solar Grid Parity in Italy: Where Do We Stand |
| Subtitle | `\ThesisTitleSubtitle` | A Dynamic Stochastic Model |
| Author's full name | `\ThesisAuthor` | Qaiser Aziz |
| Matricola number | `\ThesisMatricola` | Matricola No. 1234567 |
| Supervisor (with title) | `\ThesisSupervisor` | Prof.\ Michele Moretto |
| Degree program | `\ThesisDegreeProgram` | Master Degree in Economics and Finance |
| Academic year | `\ThesisAcademicYear` | 2025--2026 |

If starting fresh from GitHub (see below), also collect: the new repository
name, and whether it should be public or private.

## Starting point: determine how the user got the template

### (a) Fresh start from GitHub

If the user hasn't created their own repo yet, use GitHub's template
mechanism so the new repo gets a clean history with no link back to the
template:

```
gh repo create <new-repo-name> --template Qaiser03/unipd-marco-fanno-thesis-template --public --clone
```

(swap `--public` for `--private` per the user's choice). Creating a new
repository is a consequential, visible action — confirm the exact repo name
and visibility with the user before running this command. `cd` into the
cloned folder afterward and continue with the steps below there.

### (b) Already have a local copy

If the user is already sitting in a copy of the template (zip download,
manual `git clone`, or this very folder), skip repo creation and personalize
in place. If it was a manual `git clone` (not created via the template
mechanism above) and the user wants a repo history independent of the
original template, offer to run `rm -rf .git && git init` before the first
commit — ask first, since discarding `.git` is irreversible.

## Personalize the title page

Edit the seven placeholder `\newcommand`s near the top of `main.tex`, under
the `THESIS DETAILS` comment block, using the collected inputs:

```latex
\newcommand{\ThesisTitleMain}{...}
\newcommand{\ThesisTitleSubtitle}{...}
\newcommand{\ThesisAuthor}{...}
\newcommand{\ThesisMatricola}{...}
\newcommand{\ThesisSupervisor}{...}
\newcommand{\ThesisDegreeProgram}{...}
\newcommand{\ThesisAcademicYear}{...}
```

`Acknowledgements.tex` names the supervisor separately, in prose (not via
the `\ThesisSupervisor` macro) — update that mention too if the supervisor
differs from the template's sample text ("Prof.\ Michele Moretto").

## Verify prerequisites and compile

Don't duplicate the full compile/troubleshooting instructions — point the
user to this repo's own `README.md` ("Prerequisites" and "How to compile"
sections) for TeX distribution and `minted`/Pygments setup.

The one rule worth repeating here, because it's the most common failure
mode: always build with `latexmk -pdf main.tex` (or the editor's build
button, which already calls `latexmk` via `.vscode/settings.json`) — never a
bare `pdflatex main.tex` call, or the Table of Contents, bibliography, and
acronym list will look empty or stale.

## Non-goals

This skill does not rewrite chapter content, does not redesign the
title-page layout itself (that's the separate `thesis-titlepage` skill's
job if the user wants a different visual design), and does not touch
bibliography/citation content in `references.bib`.

## Verification checklist

Before considering the thesis "set up":
- `git grep` for leftover placeholder text — none of `XXXXXXX`,
  `20XX--20XX`, `Your Full Name`, `Supervisor Name` should remain.
- `latexmk -pdf main.tex` completes without errors and `main.pdf`
  regenerates with the new title page.
- If a fresh repo was created in step (a), `git remote -v` points to the
  new repo, not `Qaiser03/unipd-marco-fanno-thesis-template`.
