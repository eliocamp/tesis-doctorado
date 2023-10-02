---
knit: purrr::partial(bookdown::render_book, output_format = 'all', preview = TRUE)
---



# Exploración de la onda 3

## Introducción

Existen múltiples índices utilizados para caracterizar a la onda 3 estacionaria del hemisferio Sur.
....

## Raphael

Uno de los pocos índices establecidos en la literatura para medir la onda zonal 3 del hemisferio sur fue propuesto por @raphael2004. 
Consiste en el promedio de las anomalías zonales estandarizadas del promedio corrido de tres meses de altura geopotencial en 500 hPa en tres puntos, elegidos para coincidir aproximadamente con los máximos climatológicos de la onda 3 según @vanloon1972. 
El promedio corrido de tres meses se aplica para evitar que el índice sea sensible al ciclo estacional de la localización de la onda 3 climatológica. 








![(\#fig:raphael-regr)(ref:raphael-regr-cap)](figures/15-onda3/raphael-regr-1.png)

La Figura \@ref(fig:raphael-regr) muestra los puntos definidos por @raphael2004 y el mapa de regresión entre el índice propuesto y la anomalía zonal de altura geopotencial en 500 hPa.
Se observa que representa una onda 3 relativamente pura con una amplitud ligeramente más alta en la región del Pacífico. 
Sin embargo, notar que los máximos al sur de Nueva Zelanda y sobre el pasaje de Drake se encuentran más al sur que los puntos usados de referencia. 

La onda 3 descripta por el índice de @raphael2004 coincide bien con la onda 3 climatológica (contornos negtros en la Fig \@ref(fig:raphael-regr)). 
Esto es por construcción, ya que al usar puntos fijos, el índice de @raphael busca medir la similitud del campo de anomalías zonales de altura geopotencial con la onda 3 climatológica. 

![(\#fig:pseudo-raphael)(ref:pseudo-raphael-cap)](figures/15-onda3/pseudo-raphael-1.png)

La Figura \@ref(fig:pseudo-raphael) muestra la relación entre la anomalía zonal de altura geopotencial promediada en los tres puntos (índice de @raphael2004 agrega promedio de 3 meses y estandarización) y la  amplitud de la proyección del campo de anomalías de geopotencial en la dirección de la onda 3 climatológica.  
La correlación entre ambas series es 0.97 (CI: 0.96 -- 0.97). 
Esto es importante al comparar el índice con otros índices que miden cosas distintas, como la amplitud de la onda 3 o la amplitud de las anomalías de la onda 3. 

No es del todo sorprendente que un índice basado en el promedio de 3 puntos esté altamente correlacionado con regiones cercanas a esos puntos.
Esto no demuestra que éste sea un patrón físicamente coherente.

La Tabla \@ref(tab:raphael-correlation) muestra la matriz de correlación entre la anomalía zonal de altura geopotencial en los puntos en el índice de @raphael2004, indicados por su longitud. 
Se observa que los puntos no son covariantes. 
Esto sugiere que no representan un patrón coherente. 


Table: (\#tab:raphael-correlation)Correlación entre la anomalía zonal de geopotential en los tres puntos considerados por Raphael.

|item1 |     50|   165|    285|
|:-----|------:|-----:|------:|
|50    |  1.000| 0.157| -0.133|
|165   |  0.157| 1.000|  0.033|
|285   | -0.133| 0.033|  1.000|




![(\#fig:cor-puntos)(ref:cor-puntos-cap)](figures/15-onda3/cor-puntos-1.png)

La Figura \@ref(fig:cor-puntos) muestra los campos de regresión de anomalía zonal de altura geopotencial con las anomalías zonales de altura geopotencial en los puntos individuales y las combinaciones de dos puntos. 
No hay un patrón coherente asociado a los puntos individuales.
Sólo el punto en 165ºE pareciera asociado a un patrón de onda emergente, aunque no muy claro. 
Las combinaciones de dos puntos se asocian a anomalías positivas en los dos puntos relevantes y negativas en el resto del dominio (esperable ya que se tratan de anomalías zonales) pero, crucialmente, no hay una asociación positiva con el tercer punto no incluido en el índice. 


![(\#fig:raphael-top8-1)(ref:raphael-top8-cap)](figures/15-onda3/raphael-top8-1.png)![(\#fig:raphael-top8-2)(ref:raphael-top8-cap)](figures/15-onda3/raphael-top8-2.png)

Finalmente, las Figuras \@ref(fig:raphael-top8-1) y \@ref(fig:raphael-top8-2) muestran la anomalía zonal y la anomalía mensual de la anomalía zonal de altura geopotencial en los los 8 meses con mayor y menor valor del índice, respectivamente.
En pocos casos se observa un patrón de onda 3 bien marcado; en muchos casos no hay siquiera anomalías positivas en los tres puntos.
En los casos negativos, parece haber un patrón de onda tipo PSA algo más definido, sin embargo, tampoco en estos casos hay buena consistencia entre los puntos. 

De este análisis se desprende que el índice propuesto por @raphael2004 no parece representar un fenómeno distintivo de onda 3. 

## Fourier

Otra forma de medir la onda 3 es computando la amplitud de fourier de esta onda a lo largo de un circulo de latitud. 
Esta medida no mide exactamente lo mismo que el índice de @raphael2004, ya que es sensible a la amplitud de la onda 3 sin importar dónde este localizada. 
Esto puede observarse en la Figura \@ref(fig:fase-histogram), donde se observa que la localización de la onda 3 varía considerablemente. 



![(\#fig:fase-histogram)(ref:fase-histogram-cap)](figures/15-onda3/fase-histogram-1.png)


Por otro lado, la onda 3 de la altura geopotencial no es idéntica a la onda 3 de las anomalías mensuales de altura geopotencial. 
Dado que la variable relevante para estudiar la variabilidad, los impactos, los forzantes y las tendencias son las anomalías con respecto a la media, desde ahora vamos a analizar las anomalías mensuales.



![(\#fig:zw3-top8)(ref:zw3-top8-cap)](figures/15-onda3/zw3-top8-1.png)


El modelo de fourier también asume que las onda 3 tiene una amplitud constante a lo largo de todo el círculo de latitud y que no presenta propagación meridional. 
La Figura \@ref(fig:zw3-top8) es equivalente a la Figura \@ref(fig:raphael-top8). 
Se observa que amplitud alta se asocia a una onda 3 relativamente clara, aunque su amplitud no es constante en todo el hemisferio. 
Aún cuando hay 3 máximos claros, éstos no están en la misma latitud, sugiriendo un nivel de propagación meridional 


![(\#fig:envelope-regr)(ref:envelope-regr-cap)](figures/15-onda3/envelope-regr-1.png)

La Figura \@ref(fig:envelope-regr) muestra la regresión entre la amplitud de las ondas 1 a 4 y la envolvente de todas las ondas zonales (una medida de la actividad local de las ondas; ver @virving2015) de las anomalías de altura geopotencial. 
Se observa que la amplitud de la onda 1 se asocia a mayor actividad de onda en una banda aproximadamente zonalmente simétrica, indicando que la onda 1 contribuye con las anomalías zonales aproximadamente en todas las longitudes. 
Las ondas 2 y 3, en cambio, contribuyen a las anomalías mensuales de altura geopotencial principalmente en el Pacífico sur. 

De este análisis concluimos que ni el modelo de @raphael2004 ni el modelo de Fourier son adecuados para estudiar la onda 3 en el hemisferio sur.
Es necesario un modelo que permita detectar cambios en la fase, modulación zonal de la amplitud y propagación meridional. 
