---
title: 'Ondas de Rossby planetarias en la circulación atmosférica del hemisferio sur y su influencia en Sudamérica'
author: 'Lic. Elio Campitelli'
date: 'BUENOS AIRES, 2023'
institution: 'Universidad de Buenos Aires'
division: 'Facultad de Ciencias Exactas y Naturales'
advisor: 'Carolina Vera'

altadvisor: 'Leandro Diaz'
consejere: 'Claudio Menendez'
department: 'Departamento de Ciencias de la Atmósfera y los Océanos'
degree: 'Tesis presentada para optar al título de Doctore de la Universidad de Buenos Aires en el Área de Ciencias de la Atmósfera y los Océanos'
place: 'Centro de Investigaciones del Mar y la Atmósfera. CONICET-UBA'
knit: purrr::partial(bookdown::render_book, output_format = 'all')

site: bookdown::bookdown_site

# The next two lines allow you to change the spacing in your thesis. You can 
# switch out \onehalfspacing with \singlespacing or \doublespacing, if desired.
header-includes:
    - \usepackage{setspace}\onehalfspacing
    - \usepackage[spanish,es-tabla]{babel}

language:
  label:
    fig: 'Figura '
    tab: 'Tabla '
chapter: 'Capítulo'

output:
  thesisdown::thesis_pdf:
        pandoc_args:
          - "--lua-filter=resumen-to-meta.lua"
          - "--lua-filter=abstract-to-meta.lua"
  bookdown::gitbook: default
  thesisdown::thesis_epub: default
  thesisdown::thesis_word: default


# always_allow_html: true

acknowledgements: |
  I want to thank a few people.
dedication: |
  You can have a dedication here if you wish. 


# Specify the location of the bibliography below
bibliography:
  - bib/tesis-doctorado.bib
#   - bib/era.bib
#   - bib/packages.bib
# Download your specific csl file and refer to it in the line below.
csl: csl/meteorologica.csl
link-citation: yes
lot: true
lof: true
---

