---
title: Dinámica de la circulación zonalmente asimétrica del hemisferio sur
title_en: Dynamics of the Southern Hemisphere zonally asymmetric circulation
author: 'Lic. Elio Campitelli'
# date: 'BUENOS AIRES, 2023'
date: "BUENOS AIRES, 2023"
institution: 'Universidad de Buenos Aires'
division: 'Facultad de Ciencias Exactas y Naturales'

advisor: 'Dra. Carolina Vera'
altadvisor: 'Dr. Leandro Diaz'
consejere: 'Dr. Claudio Menendez'
department: 'Departamento de Ciencias de la Atmósfera y los Océanos'
degree: 'Tesis presentada para optar al título de Doctor de la Universidad de Buenos Aires en el Área de Ciencias de la Atmósfera y los Océanos'
place: 'Centro de Investigaciones del Mar y la Atmósfera. CONICET-UBA'
knit: purrr::partial(bookdown::render_book, output_format = 'all')

site: bookdown::bookdown_site

# The next two lines allow you to change the spacing in your thesis. You can 
# switch out \onehalfspacing with \singlespacing or \doublespacing, if desired.
header-includes:
    - \usepackage{setspace}\onehalfspacing
    - \usepackage[spanish,es-tabla]{babel}
    - \usepackage[colorinlistoftodos]{todonotes}
    - \usepackage[inline]{showlabels}
    - \usepackage{subfig}

language:
  label:
    fig: 'Figura '
    tab: 'Tabla '
chapter: 'Capítulo'

output:
  bookdown::pdf_book:
      template: "template.tex"
      keep_tex: TRUE
      toc: TRUE
      toc_depth: 2
      citation_package: "default"
      pandoc_args:
        - "--lua-filter=resumen-to-meta.lua"
        - "--lua-filter=abstract-to-meta.lua"
        - "--top-level-division=chapter"
  bookdown::gitbook:
      split_by: "rmd"
      toc_depth: 2
      citation_package: "default"
      pandoc_args:
        - --wrap=none
  bookdown::epub_book:
      toc_depth: 2
      pandoc_args:
        - --wrap=none
  bookdown::word_document2:
      toc_depth: 2
      pandoc_args:
        - --wrap=none

always_allow_html: true

acknowledgements: |
  I want to thank a few people.
dedication: |
  You can have a dedication here if you wish. 


# Specify the location of the bibliography below
bibliography:
  - bib/cmip-models.bib
  - bib/tesis-doctorado.bib

#   - bib/era.bib
#   - bib/packages.bib
# Download your specific csl file and refer to it in the line below.
csl: "csl/iso690-author-date-es.csl"
link-citation: yes
lot: true
lof: true
---

<!-- Required to number equations in HTML files -->
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  TeX: { equationNumbers: { autoNumber: "AMS" } }
});
</script>
