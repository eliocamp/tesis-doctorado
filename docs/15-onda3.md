---
knit: purrr::partial(bookdown::render_book, output_format = 'bookdown::pdf_book', preview = FALSE)
always_allow_html: true
---



# Exploración de las formas de descripción de la onda 3 {#onda3}

En el [capítulo anterior](#intro) se introdujeron conceptualmente algunos aspectos problemáticos de las metodologías e índices normalmente utilizados en la literatura para estudiar la circulación zonalmente asimétrica en el hemisferio sur.
Este capítulo realiza una primera evaluación de la descripción de la onda zonal 3 a través del del índice propuesto por @raphael2004 y de la descomposición de Fourier.

## Métodos

### Datos

Se utilizaron datos mensuales de altura geopotencial, del European Centre for Medium-Range Weather Forecasts Reanalysis versión 5 (ERA5) [@hersbach2020] a una resolución espacial de 2,5° de longitud por 2,5° de latitud.
Se utilizaron datos del período post-satelital (1979--2020) para garantizar la mayor cobertura posible de datos en el hemisferio sur que hayan alimentado al sistema de reanálisis.

### Índice R04








El índice definido por @raphael2004 (de acá en adelante denominado "R04") se basa en un índice similar definido por @mo1985 y es el índice más utilizado en la literatura para cuantificar la actividad de la onda zonal 3 del hemisferio sur.
Se calcula como el promedio de las anomalías zonales estandarizadas del promedio móvil de tres meses de altura geopotencial en 49ºS y en 500 hPa en tres ubicaciones elegidas para coincidir aproximadamente con los máximos climatológicos de la onda 3 según @vanloon1972: 50ºE, 166ºE y 76ºO.
Valores positivos y negativos indican, por lo tanto, anomalías positivas y negativas  alrededor de estas ubicaciones, respectivamente.
El promedio móvil de tres meses se aplica para evitar que el índice sea sensible al ciclo estacional de la localización de la onda 3 climatológica.
Dado que se utilizaron datos de reanálisis con una resolución de 2,5º, se calculó el índice con los puntos más cercanos: 50°E, 165°E, y 75°O en 50°S.

### Envolvente

Para cuantificar la actividad de las ondas zonales, se calculó la envolvente de las ondas siguiendo a @irving2015.
Primero se calcula la transformada de Fourier de las anomalías de geopotencial en un círculo de latitud determinado, luego se le aplica la transformada inversa sólo al espectro positivo y finalmente se toma el doble de la amplitud de este resultado complejo.



(ref:envolvente-ejemplo-cap) Anomalías zonales de altura geopotencial (m) en 500 hPa en septiembre de 1989 (contornos, líneas sólidas indican valores positivos y líneas punteadas indican valores negativos) y envolvente de ondas zonales (sombreado).

La Figura \@ref(fig:envolvente-ejemplo) muestra un ejemplo de la envolvente de la ondas zonales para la altura geopotencial en 500 hPa en septiembre de 1989 junto con las anomalías zonales correspondientes.
Estas anomalías son intensas al sur de Australia y Nueva Zelanda y la envolvente captura esa región.

### Software

El análisis de datos se realizó utilizando el lenguaje de programación R [@rcoreteam2020], con los paquetes data.table [@dowle2020] y metR [@campitelli2020].
Los gráficos se hicieron con ggplot2 [@wickham2009].

Los datos de reanálisis fueron descargados con el paquete ecmwfr [@hufkens2020], los datos de CMIP y DAMIP se descargaron con el paquete rcmip6 [@rcmip6] y los índices de El Niño-Oscilación del Sur (ENSO, por sus siglas en inglés) y el dipolo del Índico, con el paquete rsoi [@albers2020].

La tesis se compiló utilizando knitr y rmarkdown [@xie2015; @allaire2020].

## Resultados

### Índice R04

La Figura \@ref(fig:raphael-regr) presenta la regresión lineal entre R04 y la anomalía zonal de altura geopotencial en 500 hPa junto con la onda 3 obtenida de la descomposición de Fourier del campo medio climatológico de la altura geopotencial en 500 hPa para el período 1979--2020.
La figura incluye además las ubicaciones definidas por @raphael2004 para calcular el índice.
Se observa que R04 representa una onda 3 relativamente pura con una amplitud ligeramente más alta en la región del Pacífico Sur.
Sin embargo, se puede notar que los máximos al sur de Nueva Zelanda y sobre el pasaje de Drake se encuentran más al sur que los puntos usados de referencia.



(ref:raphael-regr-cap) Regresión lineal entre R04 y la anomalía zonal de altura geopotencial (m) en 500 hPa (sombreado). La onda 3 obtenida de la descomposición de Fourier del campo medio climatológico de la altura geopotencial en 500 hPa se muestra en contornos; (valores positivos en línea llena y negativos en línea punteada). En azul se indican la ubicación de los puntos usado para calcular R04.

La onda 3 descrita por R04 coincide bien con la onda 3 climatológica, lo cual es esperable por construcción.
Al usar puntos fijos cercanos a estos máximos climatológicos, el índice R04 busca medir la similitud del campo de anomalías zonales de altura geopotencial con la onda 3 climatológica.



(ref:pseudo-raphael-cap) Relación entre la anomalía zonal de altura geopotencial en los tres puntos utilizados para construir R04 y la amplitud de la proyección de la geopotencial en 50ºS, 500 hPa con la onda 3 climatológica.

La Figura \@ref(fig:pseudo-raphael) muestra la relación entre la proyección de la altura geopotencial en 50ºS con la onda 3 climatológica en esa latitud y la anomalía zonal de altura geopotencial promediada en las tres ubicaciones de R04 (que no es exactamente el índice R04 ya que éste se calcula a partir de un promedio móvil de 3 meses y una estandarización previa al promediado).
Ambas series son casi idénticas, con una correlación de 0,97 (CI: 0,96 -- 0,97).
Esto ilustra que el R04 no es un índice de la amplitud de la onda 3, sino un índice de cuánto se parecen la altura geopotencial en 50ºS a la onda 3 media en 50ºS.

Si bien la Figura \@ref(fig:raphael-regr) muestra que R04 está asociado con una onda 3 relativamente pura, no es sorprendente que un índice basado en el promedio de 3 puntos esté altamente correlacionado con regiones cercanas a esos puntos.
Por lo que esto no garantiza que esta estructura así como está definida sea un patrón físicamente coherente.

<table class=" lightable-classic-2" style='font-family: "Arial Narrow", "Source Sans Pro", sans-serif; width: auto !important; margin-left: auto; margin-right: auto;'>
<caption>(\#tab:raphael-correlation)Correlación temporal entre la anomalía zonal de geopotential para cada posible par de ubicaciones (indicadas por su longitud) de los tres puntos utilizados para construir R04.</caption>
 <thead>
  <tr>
   <th style="text-align:center;">  </th>
   <th style="text-align:center;"> 50°E </th>
   <th style="text-align:center;"> 165°E </th>
   <th style="text-align:center;"> 75°O </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 50°E </td>
   <td style="text-align:center;"> 1,00 </td>
   <td style="text-align:center;"> 0,15 </td>
   <td style="text-align:center;"> -0,13 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 165°E </td>
   <td style="text-align:center;"> 0,15 </td>
   <td style="text-align:center;"> 1,00 </td>
   <td style="text-align:center;"> 0,04 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 75°O </td>
   <td style="text-align:center;"> -0,13 </td>
   <td style="text-align:center;"> 0,04 </td>
   <td style="text-align:center;"> 1,00 </td>
  </tr>
</tbody>
</table>

Para explorar la consistencia física de la aplicación de R04 se presenta la Tabla \@ref(tab:raphael-correlation), que muestra la matriz de correlación entre la anomalía zonal de altura geopotencial en las ubicaciones utilizadas para calcular R04, indicadas por su longitud.
Las correlaciones son muy cercanas a cero, e incluso la correlación entre el punto de 75ºO y 50ºE es negativa.
Esto indica que los puntos no son covariantes, lo que implica que no serían parte de un mismo patrón de onda coherente.





(ref:cor-puntos-cap) Regresión entre las anomalías zonales de altura geopotencial en 500 hPa e índices R04 usando combinaciones de 1 y 2 puntos (m). En cada panel, los puntos azules son los puntos usados para calcular el índice y los negros, los excluidos.

La Figura \@ref(fig:cor-puntos) muestra los campos de regresión entre la anomalía zonal de altura geopotencial e índices similares a R04 pero computados considerado o bien solo un punto (Fig. \@ref(fig:cor-puntos), fila a) o promedios de combinaciones de dos puntos (Fig.\@ref(fig:cor-puntos), fila b) de los tres utilizados para computar R04.
La figura muestra que no se encuentra un patrón coherente de onda 3 asociado a los puntos individuales.
Por otra parte, los campos obtenidos a partir de las combinaciones de dos puntos se asocian a anomalías positivas en los dos puntos relevantes y negativas entre los mismos --esperable ya que se trata de anomalías zonales-- pero, crucialmente, no hay una asociación positiva con el tercer punto no incluido en el índice.

![(\#fig:raphael-top8)(ref:raphael-top8-cap)](figures/15-onda3/raphael-top8-1.png)![(\#fig:raphael-top8)(ref:raphael-top8-cap)](figures/15-onda3/raphael-top8-2.png)

(ref:raphael-top8-cap) Anomalía zonal de altura geopotencial (m, sombreado) y anomalía mensual de la anomalía zonal de altura geopotencial (m, contornos, valores positivos en línea sólida y valores negativos en línea punteada) en 500 hPa para los 8 meses con mayor y menor valor del índice R04. Los puntos azules indican las ubicaciones usadas en el índice R04.

Finalmente, las Figuras \@ref(fig:raphael-top8-1) y \@ref(fig:raphael-top8-2) muestran  las anomalías mensuales  zonales de la altura geopotencial para los 8 meses con mayor y menor valor del índice R04, respectivamente.
En pocos casos se observa un patrón de onda 3 bien marcado; por ejemplo, en abril de 2003 y noviembre de 1985 (paneles f y g) se observan tres zonas de anomalías positivas cercanas a las ubicaciones utilizadas para calcular R04 y tres zonas de anomalías negativas entre las mismas.
En octubre de 2009 (panel m) se observa lo contrario.
En casos para los cuales el índice es grande y positivo no hay siquiera anomalías positivas en los tres puntos, como en noviembre de 2018 (panel b) diciembre de 1998 (panel e).
En los meses con menores valores del índice R04, parece haber un patrón de onda tipo PSA algo más definido, sin embargo, tampoco en estos casos hay buena consistencia entre los puntos.

De este análisis se desprende que el índice propuesto por @raphael2004 no sería capaz de representar las características espacio-temporales de la onda 3.

### Descomposición de Fourier

Otra forma de cuantificar la actividad de la onda 3 es, como se mencionó previamente, computando la amplitud obtenida a través de una descomposición de Fourier para este número de onda a lo largo de un círculo de latitud.
Este método también asume que la onda 3 tiene una amplitud constante a lo largo de todo el círculo de latitud y que no presenta dispersión meridional.
Esta metodología no mide exactamente lo mismo que R04, ya que en este caso es sensible a la amplitud de la onda 3 sin importar dónde esté localizada.
Esto puede observarse en la Figura \@ref(fig:fase-histogram), que presenta un histograma de la fase de la onda 3 obtenida a partir de la descomposición de Fourier de la altura geopotencial y que muestra que la localización de la onda varía considerablemente.
También se puede observar el ciclo anual de la fase.





(ref:fase-histogram-cap) Histograma de la fase de la onda 3 de altura geopotencial en 500 hPa para cada trimestre.

Por otro lado, cabe mencionar que la onda 3 que se obtiene de la descomposición de Fourier aplicada directamente a las medias mensuales de la altura geopotencial no es idéntica a la onda 3 que surge de la descomposición de Fourier aplicada a las anomalías mensuales de altura geopotencial mensual.
Por lo que dado que la variable relevante para estudiar la variabilidad, los impactos, los forzantes y las tendencias son las anomalías con respecto a la media, desde ahora se analizarán las anomalías mensuales.





(ref:zw3-top8-cap) Anomalía zonal de altura geopotencial (m, ombreado) y anomalía mensual de la anomalía zonal de altura geopotencial (m, contornos, valores positivos en línea sólida y valores negativos en línea punteada) en 500 hPa para los 8 meses con mayor y menor valor de la amplitud de la onda 3 de la anomalía mensual de altura geopotencial en 500 hPa.

La Figura \@ref(fig:zw3-top8) presenta, para los 8 meses con mayor amplitud de la onda 3 de la anomalía mensual de altura geopotencial, las anomalía zonales de altura geopotencial en 500 hPa y las correspondientes anomalías mensuales.
Algunos meses, como septiembre de 1997, abril de 1995 y octubre de 2009 (Fig. \@ref(fig:zw3-top8), paneles c, d y h) tienen máximos y mínimos de intensidad relativamente constante.
En la mayoría aún cuando se puede observar una onda 3 relativamente clara, su amplitud no es constante a lo largo de todo el hemisferio.
Por ejemplo, en septiembre de 2008 (Fig. \@ref(fig:zw3-top8), panel a), las anomalías zonales tienen mayor intensidad y se encuentran más al sur en la zona del Pacífico y al este de Sudamérica que en el Índico y al sur de Australia.
En cambio, en junio de 1986 (Fig. \@ref(fig:zw3-top8), panel f) las anomalías tienen mayor intensidad en la zona del Pacífico y al sur de Australia y son casi nulas en el Atlántico.



(ref:envelope-regr-cap) Regresión entre la amplitud de las ondas 1 a 4 y la envolvente de todas las ondas zonales de las anomalías de altura geopotencial (sin unidades).

Esta diferencia longitudinal en la amplitud de las ondas puede capturarse a partir de la envolvente de las ondas.
La Figura \@ref(fig:envelope-regr) muestra la regresión entre la amplitud de las ondas 1 a 4 y la envolvente de todas las ondas zonales de las anomalías de altura geopotencial.
Se observa que la amplitud de la onda 1 se asocia a mayor actividad de onda en una banda aproximadamente zonalmente simétrica, indicando que la onda 1 contribuye con las anomalías zonales aproximadamente en todas las longitudes.
Las ondas 2 y 3, en cambio, contribuyen a las anomalías mensuales de altura geopotencial principalmente en el Pacífico sur.
Esto es consistente con lo observado en los casos particulares en la Figura \@ref(fig:zw3-top8) y sugiere que la onda 3 puede presentar variaciones longitudinales que no son capturadas por un modelo sinusoidal puro.

## Conclusiones del capítulo \@ref(onda3)

De este análisis se concluye que ni el modelo de @raphael2004 ni el modelo de Fourier son adecuados para describir las variaciones espacio-temporales de la onda 3 en el hemisferio sur.
Es necesario entonces una metodología que permita describir cambios en la fase, modulación zonal de la amplitud y propagación meridional.
En el próximo capítulo se presenta un índice basado en cEOF que apunta a resolver estos problemas.
