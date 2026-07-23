use warnings;
use strict;

# Self-contained latexmk config for this template.
# Deliberately does NOT rely on any user-wide or machine-wide .latexmkrc --
# every setting a fresh compile needs (shell-escape for minted, the
# makeglossaries hook, biber via bibtex_use) is declared here so this folder
# builds correctly on its own, on any machine, even one with no other LaTeX
# config at all.

$pdf_mode = 1;
$pdflatex = 'pdflatex -shell-escape -interaction=nonstopmode -synctex=1 %O %S';
$bibtex_use = 2;

# Run makeglossaries automatically whenever a .glo/.acn file changes
# (no-op if a project variant drops the glossaries/acronym packages).
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
sub run_makeglossaries {
    my ($base_name, $path) = fileparse($_[0]);
    my $ret = system("makeglossaries", "-d", $path, $base_name);
    return $ret;
}
push @generated_exts, 'glo', 'gls', 'glg', 'acn', 'acr', 'alg';
