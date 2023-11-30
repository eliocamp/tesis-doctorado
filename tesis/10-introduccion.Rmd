# Introducción {#intro}

La circulación general del hemisferio sur es más zonalmente simétrica que la del hemisferio norte, pero las anomalías zonales de la circulación tienen impactos regionales importantes [p.e. @hoskins2005].
Modulan fuertemente los sistemas meteorológicos y el clima regional al influenciar el transporte meridional de calor, humedad y momento [@trenberth1980a; @raphael2007] e incluso podrían estar relacionados con la ocurrencia de extremos climáticos de alto impacto [@pezza2012].

A pesar de estos impactos, las anomalías zonales de circulación están poco estudiadas en el hemisferio sur.
Por ejemplo, el principal patrón de circulación en latitudes medias -- el Modo Anular del Sur (SAM, por sus siglas en inglés) -- es entendido como un patrón zonalmente simétrico [@fogt2020] a pesar de estar asoaciado a significativas anomalías zonales de altura geopotencial.
Estas asimetrías zonales no han sido ampliamente estudiadas, pero trabajos previos sugieren que tienen un rol importante en modular los impactos regionales del SAM [@fan2007; @silvestri2009; @fogt2012; @rosso2018].

La circulación zonalmente asimétrica suele describirse en base a la amplitud y la fase de las ondas zonales obtenidas por descomposición de Fourier de la altura geopotencial o la presión a nivel del mar en cada latitud [p.e., @vanloon1972; @trenberth1980a; @turner2017].
Bajo este enfoque, las ondas zonales 1 y 3 explican casi el 99% de la varianza total del campo medio anual de las anomalías zonales de altura geopotencial de 500 hPa en 50ºS [@vanloon1972].
@trenberth1985 concluyó que la onda 3 tiene un rol importante en el desarrollo de los fenómenos de bloqueo.
Además, trabajos previos identificaron patrones de onda con números de onda dominantes 3-4 en latitudes extratropicales y subpolares con impactos regionales distintivos, como en las anomalías en la concentración de hielo matino antártico [@raphael2007].

@quintanar1995a realizaron experimentos de sensibilidad tratando de identificar los factores importantes en el mantenimiento de la onda zonal 1 climatológica.
Encontraron que ni la temperatura ni la orografía de la Antártida eran suficientes para explicar la amplitud de esta onda en latitudes subpolares, por lo que concluyeron que los forzantes remotos debían jugar un papel importante.
Por otro lado @wang2013 encontraron que la destrucción y recuperación de la capa de ozono está asociada a un aumento y disminución de la actividad de las ondas planetarias, respectivamente, pero su análisis no distingue en la actividad de distintos números de onda.

En cuanto a la onda 3, experimentos de sensibilidad sugieren que los forzantes tropicales no son importanets para determinar la amplitud de la onda 3, sino que ayudan a fijarla en una fase preferencial y así se vea reflejada en el campo medio.
@campitelli2018b realizó simulaciones con el modelo SPEEDY eliminando la variabilidad de la temperatura de la superficie del mar (TSM) tropical, encontrando que la amplitud de la onda 3 era similar a la simulación control, pero que su fase era mucho más variable.
Estas conclusiones son consistentes con @goyal2021a quien realizó simulaciones con *aquaplanet* al que le agregó los continentes individualmente, sugiriendo que la distribución de los tres continentes del hemisferio sur no tiene un rol relevante en el establecimiento de la onda 3 ni su importancia en el campo medio.
Este trabajo además propone que la onda 3 representa un tren de onda con propagación meridional y amplitud relativamente localizada en vez de una onda planetaria con amplitud constante en todo el hemisferio.

Si la onda 3 es mejor entendida en término de trenes de onda con propagación meridional, el uso de la descomposición de Fourier no es válido, ya que ésta asume que la circulación puede describirse aproximadamente en términos de ondas zonales de amplitud constante a lo largo de un círculo de latitud.
Para abordar esta limitación, la técnica de Fourier puede generalizarse para integrar toda la amplitud de las ondas planetarias, independientemente del número de onda, calculando la envolvente de la onda [@irving2015].
La envolvente de onda puede representar ondas planetarias con diferente amplitud en diferentes longitudes, pero carece de información sobre la fase y el número de onda.
Utilizando este método, @irving2015 demostró que la amplitud de las ondas planetarias en general está asociada a anomalías de concentración de hielo marino antártico y temperatura, así como a las anomalías de precipitación en regiones de topografía significativa en latitudes medias del hemisferio sur y en la Antártida.

Otro enfoque ampliamente utilizado para caracterizar las anomalías de la circulación troposférica del hemisferio sur es el cálculo de las Funciones Ortogonales Empíricas (EOF, también conocidas como Análisis de Componentes Principales).
El SAM aparece como el EOF que explica la mayor parte de la varianza la circulación del hemisferio sur [@fogt2020], seguido por los EOF 2 y 3, normalmente conocidos como PSA1 y PSA2, respectivamente.
Éstos describen trenes de ondas con propagación meridional que se originan en el Pacífico ecuatorial oriental y en el sector australiano-océano Índico, y viajan hacia el Atlántico Sur siguiendo un arco de gran círculo a lo largo de la costa Antártida [@mo2001].
Estos patrones influyen en las anomalías de precipitación en Sudamérica [@mo2001].
Aunque estos patrones suelen derivarse aplicando EOF a anomalías temporales, @raphael2003 también aplicó métodos EOF específicamente a anomalías zonales.
@irving2016 propuso una metodología novedosa para identificar objetivamente el patrón PSA utilizando la descomposición de Fourier.
Más recientemente @goyal2022 creó un índice de amplitud y fase de la variabilidad zonal tipo onda 3 combinando los dos EOF principales de las anomalías del viento meridional.

Los patrones resultantes del análisis EOF son más flexibles que los modos derivados de la descomposición de Fourier, ya que pueden captar patrones de oscilación que no pueden caracterizarse por ondas puramente sinusoidales con amplitud constante.
No obstante, se limitan a los modos de oscilación estacionarios y no pueden representar correctamente la propagación meridional o la variación espacial de amplitud y fase.
Un único EOF también puede representar una mezcla de dos o más modos físicos.

Una tercera metodología comúnmente utilizada para describir anomalías de circulación consiste en identificar características particulares de interés y crear índices utilizando métodos simples como promedios y diferencias.
Ejemplos de esta metodología son el índice SAM de @gong1999, el índice de actividad de la onda 3 hemisferio sur definido por @raphael2004 y el índice de circulación zonalmente asimétrica hemisferio sur de @hobbs2010.
Estos métodos derivados se fundamentan en otros métodos, como la descomposición de Fourier o las EOF, para identificar los centros de acción de los fenómenos descritos y pueden ser útiles para caracterizar rasgos que no se aprecian fácilmente con estos métodos.
Este tipo de índices suelen ser fáciles de calcular, pero no suelen captar patrones no estacionarios.

En conclusión, las metodologías usadas en la literatura para estudiar la circulación atmosférica de gran escala no son apropiadas para el estudio de la onda3, la cual es un patrón ondulatorio no estacionario con propagación meridional y amplitud no constante a lo largo de un círculo de latitud.

Una metodología alternativa que se ha propuesto para estudiar las ondas propagantes y estacionarias son las funciones ortogonales empíricas complejas (cEOF) [@horel1984].
Este método amplía el análisis EOF para capturar oscilaciones con amplitud y fase variables y se ha aplicado al dominio temporal.
Por ejemplo, @krokhin2007 aplicó cEOF a las anomalías mensuales de precipitación basadas en estaciones y a las anomalías mensuales de temperatura en la región de Siberia Oriental y Extremo Oriente para caracterizar los principales modos de variabilidad y su relación con los índices de teleconexión.
Del mismo modo, @gelbrecht2018 aplicó cEOF a la precipitación diaria a partir de reanálisis para estudiar las características de propagación del Monzón Sudamericano.
Hasta donde sabemos, el análisis cEOF no se ha aplicado en el dominio espacial para capturar la naturaleza variable en fase de las ondas planetarias en la atmósfera.

El objetivo de esta tesis es mejorar la descripción y comprensión de la circulación extratropical hemisferio sur zonalmente asimétrica utilizando cEOF, que puede describir ondas planetarias de fase variable con amplitud variable a lo largo de un círculo de latitud.
Dada la falta de estudios sobre las asimetrías zonales del SAM, también proponemos desarrollar una metodología para caracterizar la variabilidad de las componentes simétricas y asimétricas del SAM, sus impactos y sus forzantes. 
Además, intentamos ampliar el conocimiento del comportamiento simultáneo de la circulación asimétrica hemisferio sur en la troposfera y la estratosfera.


