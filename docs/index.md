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
    - \usepackage[spanish]{babel}

language:
  label:
    fig: 'Figura '
    tab: 'Tabla '
chapter: 'Capítulo'
# This will automatically install the {remotes} package and {thesisdown}
# Change this to FALSE if you'd like to install them manually on your own.
params:
  'Install needed packages for {thesisdown}': True
  
# Remove the hashtag to specify which version of output you would like.
# Can only choose one at a time.
output:
  thesisdown::thesis_pdf: 
        pandoc_args: 
          - "--lua-filter=resumen-to-meta.lua"
          - "--lua-filter=abstract-to-meta.lua"
  thesisdown::thesis_gitbook: default
  thesisdown::thesis_epub: default
  thesisdown::thesis_word: default

always_allow_html: true
# If you are creating a PDF you'll need to write your preliminary content 
# (e.g., abstract, acknowledgements) below or use code similar to line 25-26 
# for the .RMD files. If you are NOT producing a PDF, delete or silence
# lines 25-39 in this YAML header.
# If you'd rather include the preliminary content in files instead of inline
# like below, use a command like that for the abstract above.  Note that a tab 
# is needed on the line after the `|`.
acknowledgements: |
  I want to thank a few people.
dedication: |
  You can have a dedication here if you wish. 


# Specify the location of the bibliography below
bibliography:
  - bib/references.bib
#   - bib/era.bib
#   - bib/packages.bib
# Download your specific csl file and refer to it in the line below.
csl: csl/meteorologica.csl
link-citation: yes
lot: true
lof: true
---

