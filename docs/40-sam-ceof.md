




# Relación con otros patrones

Acá seguiría parte [del paper de cEOF](https://github.com/eliocamp/shceof).

## Datos y métodos

## SAM

(ref:sam-eof-vertical-cap) Coefficient of determination ($r^2$) between each component of cEOFs and the SAM, Asymmetric SAM (A-SAM) and Symmetric SAM (S-SAM) indices computed at each level for the 1979 -- 2019 period. Thick lines represent estimates with p-value \< 0.01 corrected for False Detection Rate [@benjamini1995].

<div class="figure" style="text-align: center">
<img src="40-sam-ceof_files/figure-epub3/sam-eof-vertical-1.png" alt="(ref:sam-eof-vertical-cap)"  />
<p class="caption">(\#fig:sam-eof-vertical)(ref:sam-eof-vertical-cap)</p>
</div>

Ahora exploramos la relación entre SAM y los cEOFs motivados por el parecido entre los mapas de regresión de los cEOFs y los patrones de SAM mostrados en la Sección \@ref(regresiones).
Calculamos el coeficiente de determinación entre las series temporales de los cEOFs y los tres índices SAM (SAM, A-SAM y S-SAM) definidos por @campitelli2022 en cada nivel vertical (Fig. \@ref(fig:sam-eof-vertical)).
El índice SAM está correlacionado de forma estadísticamente significativa con el 0º cEOF1 en todos los niveles, y con los 90º cEOF1 y 90º cEOF2 en la troposfera.
Por otro lado, las correlaciones entre SAM y el 0º cEOF2 no son significativas.

La relación entre la SAM y el cEOF1 en la troposfera se explica en su totalidad por el componente zonalmente simétrico de la SAM, como muestran la alta correlación con la S-SAM por debajo de 100 hPa y las correlaciones bajas y estadísticamente no significativas entre la A-SAM y el 0º o el 90º cEOF1.
En la estratosfera, la CEOF1 de 0º está correlacionada tanto con la A-SAM como con la S-SAM, mientras que la CEOF1 de 90º está altamente correlacionada sólo con la A-SAM.
Estas correlaciones son consistentes con los mapas de regresión de la altura geopotencial en la Figura \@ref(fig:eof1-regr-gh) y su comparación con los obtenidos para SAM, A-SAM y S-SAM por @campitelli2022.

En el caso de 90º cEOF2, su correlación con la SAM para la troposfera está asociada a la variabilidad asimétrica de la SAM.
De hecho, el 90º cEOF2 comparte hasta 50%, 72%, 68%, 78% varianza con el A-SAM y sólo 18%, 32%, 18%, 22% como máximo con el S-SAM (Figura \@ref(fig:sam-eof-vertical).
b2).
Esta altísima correlación entre A-SAM y 90º cEOF2 sugiere que los modos obtenidos en este trabajo son capaces de caracterizar la componente zonalmente asimétrica de la SAM descrita previamente por @campitelli2022.

## PSA

(ref:psa-eof2-cap) Correlation coefficients (r) between cEOF2 components and the PSA1 and PSA2 modes computed as @mo2001 for the 1979 -- 2019 period. 95% confidence intervals in parenthesis. p-values lower than 0.01 in bold.

<table class=" lightable-classic" style='font-family: "Arial Narrow", "Source Sans Pro", sans-serif; margin-left: auto; margin-right: auto;'>
<caption>(\#tab:psa-eof2)(ref:psa-eof2-cap)</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> PC </th>
   <th style="text-align:left;"> season </th>
   <th style="text-align:left;"> Real </th>
   <th style="text-align:left;"> Imaginario </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> PSA1 </td>
   <td style="text-align:left;"> DJF </td>
   <td style="text-align:left;"> 0.37 (CI: 0.08 -- 0.6) </td>
   <td style="text-align:left;font-weight: bold;"> 0.72 (CI: 0.54 -- 0.84) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PSA2 </td>
   <td style="text-align:left;"> DJF </td>
   <td style="text-align:left;font-weight: bold;"> 0.58 (CI: 0.33 -- 0.75) </td>
   <td style="text-align:left;"> 0.16 (CI: -0.15 -- 0.44) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PSA1 </td>
   <td style="text-align:left;"> MAM </td>
   <td style="text-align:left;"> -0.17 (CI: -0.44 -- 0.14) </td>
   <td style="text-align:left;"> 0.38 (CI: 0.09 -- 0.61) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PSA2 </td>
   <td style="text-align:left;"> MAM </td>
   <td style="text-align:left;font-weight: bold;"> 0.8 (CI: 0.65 -- 0.88) </td>
   <td style="text-align:left;font-weight: bold;"> 0.42 (CI: 0.14 -- 0.64) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PSA1 </td>
   <td style="text-align:left;"> JJA </td>
   <td style="text-align:left;"> 0.22 (CI: -0.08 -- 0.48) </td>
   <td style="text-align:left;font-weight: bold;"> 0.49 (CI: 0.23 -- 0.69) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PSA2 </td>
   <td style="text-align:left;"> JJA </td>
   <td style="text-align:left;font-weight: bold;"> 0.71 (CI: 0.52 -- 0.83) </td>
   <td style="text-align:left;font-weight: bold;"> -0.44 (CI: -0.65 -- -0.17) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PSA1 </td>
   <td style="text-align:left;"> SON </td>
   <td style="text-align:left;"> 0.13 (CI: -0.17 -- 0.41) </td>
   <td style="text-align:left;font-weight: bold;"> 0.78 (CI: 0.63 -- 0.87) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PSA2 </td>
   <td style="text-align:left;"> SON </td>
   <td style="text-align:left;font-weight: bold;"> 0.78 (CI: 0.63 -- 0.87) </td>
   <td style="text-align:left;"> 0.18 (CI: -0.12 -- 0.45) </td>
  </tr>
</tbody>
</table>

Dada la similitud entre las estructuras asociadas al cEOF2 (Fig. \@ref(fig:eof2-regr-gh)) y los patrones de PSA documentados, estudiamos la relación entre ellos.
La tabla \@ref(tab:psa-eof2) muestra las correlaciones entre los dos índices PSA y las series temporales para las fases 0º y 90º de CEOF2.
Como anticipaba visualmente la figura \@ref(fig:eof2-regr-gh), existe una gran correlación positiva entre PSA1 y 90º cEOF2, y entre PSA2 y 0º cEOF2.
Por otro lado, no existe una relación significativa entre PSA1 y 0º cEOF2, y entre PSA2 y 90º cEOF2.
En consecuencia, cEOF2 representa bien tanto la estructura espacial como la evolución temporal de los modos PSA, por lo que es posible establecer una asociación entre sus dos fases y los dos modos PSA.
Es decir, la elección de fase para cEOF2 que maximiza la relación entre ENSO y 90º cEOF2, también maximiza la asociación entre los componentes de cEOF2 y los modos PSA (no mostrado).

(ref:phase-histogram-cap) Histograma de distribución de fase de cEOF2 para el periodo 1979 -- 2019. Los intervalos están centrados en 90º, 0º, -90º, -180º con un ancho de intervalo de 90º. Las pequeñas líneas verticales cerca del eje horizontal marcan las observaciones.

<div class="figure" style="text-align: center">
<img src="40-sam-ceof_files/figure-epub3/phase-histogram-1.png" alt="(ref:phase-histogram-cap)"  />
<p class="caption">(\#fig:phase-histogram)(ref:phase-histogram-cap)</p>
</div>

La figura \@ref(fig:histograma-fase) muestra un histograma que cuenta el número de estaciones SON en las que la fase cEOF2 estaba cerca de cada una de las cuatro fases particulares (positiva/negativa de las fases 0º y 90º), con las observaciones para cada estación marcadas como alfombras en el eje horizontal.
En 66% de las estaciones cEOF2 tiene una fase similar a la fase negativa o positiva de 90º, haciendo que la fase de 90º sea la fase más común.
Esta es también la fase más correlacionada con ENSO según la definición de la fase de 0º descrita en la Sección \@ref(métodos).

Por lo tanto, en virtud de ser la fase más común, la cEOF2 de 90º explica más varianza que la cEOF2 de 0º.
Por lo tanto, el análisis EOF convencional tenderá a separarlos de forma relativamente limpia, con el EOF que representa el 90º cEOF2 siempre por delante del que representa el 0º cEOF2.
Esta preferencia de fase está de acuerdo con @irving2016, que encontró una distribución bimodal a la variabilidad tipo PSA (compare nuestra Figura \@ref(fig:histograma-fase) con su Figura 6).

## ENSO
