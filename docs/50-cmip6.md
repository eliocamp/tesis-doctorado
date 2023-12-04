---
knit: purrr::partial(bookdown::render_book, output_format = 'all', preview = TRUE)
---






# Análisis de los modos de variabilidad de la circulación zonalmente asimétrica en los modelos del CMIP6

El análisis previo estudió la circulación zonalmente asimétrica en los datos de reanálisis.
Sin embargo, el estudio de tendencias y variabilidad de estos modelos se ve limitada por la corta longitud de los datos observacionales y la posible inhomogeneidad del reanálisis al cambiar la densidad y tipo de observaciones; un problema que afecta particularmente al hemisferio sur.
Además, es imposible abordar la atribución de las tendencias observadas utilizando únicamente observaciones.

Estas limitaciones motivan la inclusión de datos de modelos climáticos.
En este capítulo se analiza la habilidad de los modelos del sexto Proyecto de Intercomparación de Modelos Acoplados (CMIP6) y del Proyecto de Intercomparación de Modelos de Detección y Atribución (DAMIP) de capturar estos modos y sus principales características.
Al contar con corridas mucho más largas y múltiples miembros por modelo, es posible evaluar las tendencias a largo plazo con mayor robustez.
Utilizando los modelos incluidos en DAMPI, además podemos avanzar en la atribución de las tendencias observadas.

## Métodos

### Datos

El CMIP6 es un proyecto que organiza numerosos centros de modelado climático para establecer protocolos comunes para realizar experimentos de modelado.
DAMIP es una componente del CMIP6 que cuenta con experimentos particularmente diseñados para realizar estudios de atribución.






Table: (\#tab:modelos)Modelos analizados y la cantidad de miembros para cada experimento.

|Modelo                                                                                 | historical| hist-GHG| hist-nat| hist-aer| hist-stratO3|
|:--------------------------------------------------------------------------------------|----------:|--------:|--------:|--------:|------------:|
|AWI-CM-1-1-MR [@CMIP6.CMIP.AWI.AWI-CM-1-1-MR]                                          |         10|        0|        0|        0|            0|
|FGOALS-g3 [@CMIP6.CMIP.CAS.FGOALS-g3; @CMIP6.DAMIP.CAS.FGOALS-g3]                      |         12|        3|        3|        0|            0|
|CanESM5 [@CMIP6.CMIP.CCCma.CanESM5; @CMIP6.DAMIP.CCCma.CanESM5]                        |         50|       50|       50|       10|           10|
|CNRM-CM6-1 [@CMIP6.CMIP.CNRM-CERFACS.CNRM-CM6-1; @CMIP6.DAMIP.CNRM-CERFACS.CNRM-CM6-1] |         60|       10|       10|       10|            0|
|CNRM-ESM2-1 [@CMIP6.CMIP.CNRM-CERFACS.CNRM-ESM2-1]                                     |         21|        0|        0|        0|            0|
|ACCESS-ESM1-5 [@CMIP6.CMIP.CSIRO.ACCESS-ESM1-5; @CMIP6.DAMIP.CSIRO.ACCESS-ESM1-5]      |         80|        3|        3|        0|            0|
|ACCESS-CM2 [@CMIP6.CMIP.CSIRO-ARCCSS.ACCESS-CM2; @CMIP6.DAMIP.CSIRO-ARCCSS.ACCESS-CM2] |         10|        3|        3|        0|            0|
|IPSL-CM6A-LR [@CMIP6.CMIP.IPSL.IPSL-CM6A-LR; @CMIP6.DAMIP.IPSL.IPSL-CM6A-LR]           |         66|       10|       10|       10|           10|
|MIROC6 [@CMIP6.CMIP.MIROC.MIROC6; @CMIP6.DAMIP.MIROC.MIROC6]                           |        100|       50|       50|        3|           10|
|HadGEM3-GC31-LL [@CMIP6.CMIP.MOHC.HadGEM3-GC31-LL; @CMIP6.DAMIP.MOHC.HadGEM3-GC31-LL]  |         10|        5|       10|        4|            0|
|UKESM1-0-LL [@CMIP6.CMIP.MOHC.UKESM1-0-LL; @CMIP6.CMIP.NIMS-KMA.UKESM1-0-LL]           |         30|        0|        0|        0|            0|
|MPI-ESM1-2-HR [@CMIP6.CMIP.MPI-M.MPI-ESM1-2-HR]                                        |         20|        0|        0|        0|            0|
|MPI-ESM1-2-LR [@CMIP6.CMIP.MPI-M.MPI-ESM1-2-LR]                                        |         60|        0|        0|        0|            0|
|GISS-E2-1-G [@CMIP6.CMIP.NASA-GISS.GISS-E2-1-G; @CMIP6.DAMIP.NASA-GISS.GISS-E2-1-G]    |         24|       10|       20|        0|            5|
|CESM2 [@CMIP6.CMIP.NCAR.CESM2; @CMIP6.DAMIP.NCAR.CESM2]                                |         22|        3|        3|        0|            0|
|NorCPM1 [@CMIP6.CMIP.NCC.NorCPM1]                                                      |         60|        0|        0|        0|            0|
|NESM3 [@CMIP6.CMIP.NUIST.NESM3]                                                        |         10|        0|        0|        0|            0|
|E3SM-1-0 [@CMIP6.CMIP.E3SM-Project.E3SM-1-0; @CMIP6.DAMIP.E3SM-Project.E3SM-1-0]       |         10|        3|        0|        0|            0|
|INM-CM5-0 [@CMIP6.CMIP.INM.INM-CM5-0]                                                  |         20|        0|        0|        0|            0|
|BCC-CSM2-MR [@CMIP6.DAMIP.BCC.BCC-CSM2-MR]                                             |          0|        3|        3|        3|            0|
|MRI-ESM2-0 [@CMIP6.DAMIP.MRI.MRI-ESM2-0]                                               |         20|        5|        5|        2|            3|
|NorESM2-LM [@CMIP6.DAMIP.NCC.NorESM2-LM]                                               |          0|        3|        3|        0|            0|
|GFDL-CM4 [@CMIP6.DAMIP.NOAA-GFDL.GFDL-CM4]                                             |          0|        0|        3|        0|            0|
|GFDL-ESM4 [@CMIP6.DAMIP.NOAA-GFDL.GFDL-ESM4]                                           |          0|        1|        3|        0|            0|

Los modelos usados se listan en la Tabla \@ref(tab:modelos) se listan todos los modelos y la cantidad de miembros de cada uno.
Usamos todos los modelos del CMIP6 con 5 o más miembros en las corridas históricas ("historical") y todos los modelos en los experimentos que contienen únicamente el efecto de los gases de efecto invernadero ("hist-GHG"), variabilidad natural sin forzantes antropogénicos ("hist-nat"), forznates de aerosoles antropogénicos ("hist-aer") o sólo el efecto de el ozono estratosférico ("hist-stratO3").

Para calcular los cEOFs y evaluar su desempeño, concatenamos todos los miembros para computar un único set de cEOFs para cada modelo y experimento.
Este método trata $k$ simulaciones de $n$ años como una única simulación de $k\times n$ años.
Luego, calculamos los cEOFs siguiendo la metodología de la Sección \@ref(ceof-metodo).
El resultado es que cada modelo y experimento tiene un único patrón espacial (complejo) por cEOF pero una serie temporal (compleja) por miembro.

Para que sea comparable al ERA5, computamos los cEOFs para el período moderno, entre 1979 y 2014 (el último año disponible para todos los miembros).

Como se explicó anteriormente, los cEOFs no están definidos unívocamente ya que aceptan cualquier rotación en el plano complejo análogamente a como los EOFs aceptan cambios de signo.
Los cEOFs computados en ERA5 fueron rotados para maximizar la correlación con el ozono estatosférico o el ENSO como se describe en la Sección \@ref(ceof-metodo).
Para los modelos de CMIP, rotamos los cEOFs para maximizar la correlación espacial de los patrones con el correspondiente cEOF de ERA5.
Esto busca que la localización del patrón sea parecido al observado.













## Comparación con los modos observados

Previo a otros análisis, es encesario evaluar la capacidad de los modelos de capturar las propiedades del los cEOFs observados.
Para esto estudiamos los modelos de las corridas históricas.

(ref:comparacion-r2-cap) $r^2$ de los patrones espaciales de cada modelo con ERA5 para cada cEOF.

![(\#fig:comparacion-r2)(ref:comparacion-r2-cap)](figures/50-cmip6/comparacion-r2-1.png)

La Figura \@ref(fig:comparacion-r2) muestra el $r^2$ de los modelos para los dos cEOFs.
Los modelos individuales tienen un $r^2$ entre 57% y 92%. 
En todos los casos, la correlación con el cEOF1 observado es mayor que con el cEOF2 observado.
Aunque se pueden identificar modelos con menor correlación con los modos observados, como CNRM-ESM2-1 y MIROC-ES2L, aún éstos tienen similitudes mayores al 50%. 
El patrón medio multimodelo de cada cEOF se muestra en la Figura \@ref(fig:mmm), junto con el $r^2$ de estos patrones con los observados. 
Los $r^2$ de 94% y 89% para el cEOF1 y el cEOF2 respectivamente son mayores que cualquier $r^2$ de modelos individuales. 


![(\#fig:mmm)(ref:mmm-cap)](figures/50-cmip6/mmm-1.png)

(ref:mmm-cap) Media multimodelo (sombreado, valores positivos en rojo, negativos en azul) de los campos espaciales de cada cEOF, fase y nivel. Los contornos marcan los patrones de ERA5 (valores positivos en líneas llenas, valores negativos en línea punteada). El $r^2$ entre ERA5 y la media multimodelo está entre paréntesis. 
Los modelos del CMIP6 capturan satisfactoriamente los patrones espaciales de los cEOFs, tanto en la media multimodelo como los modelos individuales. 
Lo siguiente es explorar si los modelos logran capturar características de segundo órden, como su variabilidad y relación con otras partes del sistema climático.





### Relación con la variabilidad tropical





Como se mostró en la Sección \@ref(fuentes-ceof), el cEOF2 está relacionado con la variabilidad tropical.
Una primera aproximación para explorar esta relación en los modelos del CMIP6 es calcular la correlación el cEOF2 y el ONI de cada modelo (Figura \@ref(fig:cor-enso-plot)).
Casi todos los modelos tienen una correlación alta entre el ONI y la fase de 90º del cEOF2 y casi nula correlación entre el ONI y la fase de 0º del cEOF2, lo cual es consistente con las observaciones. 
Sin embargo, existe una gran variabilidad en la capacidad de los modelos de capturar esta relación. 
Algunos, como MIROC6 y CESM2 tienen una correlación cercana a la observada, pero en la mayoría es mucho menor. 
IPSL-CM6A-LR y INM-CM5-0 virtualmente no muestran relación entre el cEOF2 y el ONI. 

(ref:cor-enso-plot-cap) $r^2$ entre el índice ONI y el cEOF2 para cada modelo del CMIP6 y ERA5.  

![(\#fig:cor-enso-plot)(ref:cor-enso-plot-cap)](figures/50-cmip6/cor-enso-plot-1.png)



![(\#fig:enso-phase-cmip)(ref:enso-phase-cmip-cap)](figures/50-cmip6/enso-phase-cmip-1.png)

(ref:enso-phase-cmip-cap) Igual que la Figura \@ref(fig:enso-phase) pero para los modelos del CMIP6. El ajuste sinusoidal para cada modelo se realiza utilizando todos los miembros. 


![(\#fig:arg-enso-density)(ref:arg-enso-density-cap)](figures/50-cmip6/arg-enso-density-1.png)

(ref:arg-enso-density-cap) Estimación de densidad por núcleos de la fase del cEOF2 para primaveras con ONI menor a -0.5, entre -0.5 y 0.5, y mayor a 0.5. 

La relación entre el cEOF2 y el ENSO se explica por una preferencia de fase cuando el forzante tropical está activo. 
Para evaluar esto en los modelos del CMIP6, las Figuras \@ref(fig:enso-phase-cmip) muestra la relación entre el ENSO y la fase del cEOF2 para los modelos del CMIP6 y la Figura \@ref(fig:arg-enso-density) la distribución de fases del cEOF2 para primaveras con ONI menor a -0.5, mayor a 0.5 y valores intermedios. 
Los modelos con una correlación alta entre el cEOF2 y el ENSO muestran una relación sinusoidal fuerte, mientras que en los modelos con baja correlación la relación es más chata. 
La distribución de las fases según categorías de índice ONI (Fig. \@ref(fig:arg-enso-density)) se ven bien separadas en las observaciones y en los modelos con alta correlación entre el cEOF2 y el ONI.
En estos modelos (p.e. MIROC6, CESM2), cuando el ENSO está activo (definido como ONI > 0.5 o ONI < -0.5), la fase del cEOF2 se concentra cerca de $\pm$ 90º (dependiendo del signo del ONI) mientras que cuando el ENSO no está tan activo (definido como ONI entre -0.5 y 0.5), la distribución de la fase es más uniforme. 
En los modelos con baja correlación entre cEOF2 y ONI (p.e. IPSL-CM6A-LR, INM-CM5-0) la distribución de fase es uniforme independientemente de la actividad del ENSO. 





![(\#fig:fft-ceof2)(ref:fft-ceof2-cap)](figures/50-cmip6/fft-ceof2-1.png)

(ref:fft-ceof2-cap) Espectros de Fourier para las fases del cEOF2 y del ONI de cada modelo. En línea obscura es el espectro promedio de todos los miembros, que se muestran en líneas translúcidas. El espectro del ONI es el espectro promedio de todos los miembros de cada modelo. Los paneles están ordenados de mayor a menor según el $r^2$ entre la fase de 90º del cEOF2 y el ONI, el cual se muestra entre paréntesis en el título de cada panel.

La relación entre el cEOF2 y el ENSO también se evidencia en la similitud del periodograma de las series. 
La Figura \@ref(fig:fft-ceof2) muestra el periodograma para el cEOF2 con una línea por miembro y una línea gruesa marcando el periodograma promedio, así como el peridiograma promedio del ONI de cada modelo.
La mayoría de los modelos tiene una periodicidad del ONI de \~3 años similar a la observada en ERA5, aunque la intensidad y período máximo varía significativamente.

Todos los los modelos que tienen una periodicidad clara en \~3 años en la fase de 90º del cEOF2 también tienen una periodicidad del ENSO muy clara y además tienden a tener una correlación entre la fase de 90º del cEOF2 y el ENSO más alta.
Por otro lado, ninguno de los modelos con muy baja correlación con el ENSO pero periodicidad del ENSO clara presenta periodicidad clara en el cEOF2.

Sin embargo existen modelos con periodicidad del ENSO clara y correlación relativamente alta que no tienen periodicidad del cEOF2 clara.
MRI-ENSM2-0, UKESM1-0-LL, MPI-ESM1-2-LR son algunos ejemplos.

Estas observaciones sugieren que el ENSO es la fuente de periodicidad del cEOF2 en los modelos del CMIP6 pero que su capacidad para representar la periodicidad observada no sólo depende de la periodicidad del ENSO y del grado de correlación entre los índices.









(ref:sst-mmm-cap) Media multimodelo de regresión de TSM con los cEOFs. El área sombreada muestra las zonas donde más de la mitad de los modelos tienen p-valor menor a 0.01. Los contornos negros muestran la regresión de TSM observada en ERA5.

![(\#fig:sst-mmm)(ref:sst-mmm-cap)](figures/50-cmip6/sst-mmm-1.png)

Para estudiar más en detalle esa relación, evaluamos la relación entre los cEOF y las anomalías de TSM.
La Figura \@ref(fig:sst-mmm) muestra la media multimodelo de la regresión entre TSM y las dos fases de cada cEOF, marcando las zonas donde más de la mitad de los modelos tienen p-valores menores a 0.01.
La señal Los modelos del CMIP6 reproducen los patrones de regresión de la fase de 90º del cEOF2 relativamente bien.
Se observa un exceso de señal en el Pacífico ecuatorial en la fase de 0º del cEOF2 que probablemente se deba a que estos modos no están alineados para minimizar esta relación.
Por otro lado, la señal asociada a la fase de 90º del cEOF1 sí muestra valores excesivamente altos no observados en ERA5.


(ref:cor-sst-regr-cap) R\^2 entre los patrones de regresión de TSM cada modelo y el patrón de regresión de TSM en ERA5.

![(\#fig:cor-sst-regr)(ref:cor-sst-regr-cap)](figures/50-cmip6/cor-sst-regr-1.png)

Para una visión global y quantitativa de esta comparación, la Figura \@ref(fig:cor-sst-regr) muestra el $r^2$ los campos de regresión de cada modelo y el campo de regresión de ERA5.
En la mayoría de los modelos el patrón de regresión de la fase de 90º del cEOF2 es similar al observado, excepto por INM-CM5-0. 
El patrón de regresión de la fase de 0º, en cambio, tiene baja similitud con el observado en casi todos los modelos. 
Posiblemente esto se deba a el exceso de señal presente en la región del ENSO. 
Para ambas fases del cEOF1, las similitudes con el patrón de regresión observado son muy bajas.
Esto es esperable dado la falta de señal en las observaciones y el exceso de señal en los modelos. 

### Relación con el SAM



![(\#fig:cor-sam-cmip6)(ref:cor-sam-cmip6-cap)](figures/50-cmip6/cor-sam-cmip6-1.png)

(ref:cor-sam-cmip6-cap) Igual que la Figura \@ref(fig:sam-eof-vertical) pero para los modelos del CMIP6.

En la Sección \@ref(sam-ceof) se mostró que existía una relación importante entre las distintas fase de los cEOFs y las distintas componentes del SAM. 
La Figura \@ref(fig:cor-sam-cmip6) muestra el $r^2$ entre las componentes del SAM y las fases de los cEOFs para los modelos del CMIP6. 
Las líneas translúcidas son los valores promedio de cada modelo y las áreas llenas representan el promedio multimodelo y su intervalo de confianza del 95%; la línea gruesa es el valor de ERA5.

La relación entre el cEOF1 y el SAM en los modelos del CMIP6 es similar a la observada, aunque con diferencias en la magnitud. 

En cuanto al cEOF2, los modelos del CMIP6 capturan correctamente la falta de correlación entre fase de 0º del cEOF2 y el SAM y el S-SAM (paneles XX y XX), pero tienen un nivel de correlación más alto de lo esperado con el A-SAM en la tropósfera (panel XX).
La fase de 90º, en cambio, no muestra la relación observada con el SAM en la tropósfera (panel XX). 
A pesar de esto, sí tiene una relación alta con el A-SAM (panel XX). 
Esto sugiere que los modelos CMIP6 no capturan correctamente la relación entre el PSA2 el SAM, pero esta relación sí aparece si se filtra sólo la variabilidad de la parte asimétrica del SAM. 

## Tendencias

De la sección anterior surge que los modelos del CMIP6 logran capturar la estructura espacial de los cEOFs correctamente y que algunos modelos capturan también su variabilidad y relación con otras componentes del sistema climático.

En esta sección, aprovechamos las corridas largas de estos modelos y los experimentos de DAMIP para estudiar las tendencias a largo plazo y sus posibles forzantes. 
Para extender las series temporales para todo el período disponible en CMIP6 y DAMIP, proyectamos los campos espaciales del período moderno en los campos desde 1850 hasta 2014.

![(\#fig:series-largas)(ref:series-largas-cap)](figures/50-cmip6/series-largas-1.png)

(ref:series-largas-cap) Series temporales de anomalías estandarizadas de los cEOFs computados usando el período 1850 -- 2014. Las anomalías están computadas sobre el período 1850 -- 1900. En líneas translúcidas, las series promedio de cada modelo. En línea oscura, la media multimodelo. 

La Figura \@ref(fig:series-largas) muestra las series temporales durante todo el período. 
La fase de 0º del cEOF1 tiene una pequeña tendencia positiva comenzando al rededor de 1950, consistente con la tendencia observada en ERA5 (Fig. \@ref(fig:extended-series)). 
Sin embargo, la fase de 90º del cEOF1 tiene una tendencia negativa mucho mayor, la cual no está está presente en ERA5. 




![(\#fig:trends-ceof1)(ref:trends-ceof1-cap)](figures/50-cmip6/trends-ceof1-1.png)

(ref:trends-ceof1-cap) Tendencias lineales de cada fase del cEOF1 desde 1950. Cada punto representa un miembro, donde los miembros con tendencias significativas (p-valor < 0.01) se marcan con una cruz. La línea vertical punteada representa la tendencia media de todos los modelos. 

Las tendencias de cada fase del cEOF1 para cada modelo desde 1950 se muestra en la Figura \@ref(fig:tendencias-ceof1) junto con la tendencia promedio de todos los modelos. 
La tendencia media de la fase de 0º es positiva pero muy pequeña.
Además, los modelos no son consistentes en sus tendencias y sólo algunos modelos tienen una tendencia promedio positiva.
Por otro lado, las tendencias de la fase de 90º son más consistentes. 

Estas tendencias son incompatibles con la variabilidad del cEOF1 observado, el cual tiene una tendencia positiva de su fase de 0º y ninguna tendencia en su fase de 90º. 
Es posible que esto se deba a un problema fundamental de los modelos de CMIP6, a las limitaciones de 



sugieren que los modelos de CMIP6 no capturan una tendencia positiva robusta en la fase de 0º del cEOF1 pero parecen simular una tendencia negativa en la fase de 90º del cEOF2




![(\#fig:series-largas-mod)(ref:series-largas-mod-cap)](figures/50-cmip6/series-largas-mod-1.png)

(ref:series-largas-mod-cap) Igual que \@ref(fig:series-largas) pero para la magnitud de los cEOFs. 






![(\#fig:ceof-damip)(ref:ceof-damip-cap)](figures/50-cmip6/ceof-damip-1.png)

Para tratar de atribuir esta tendencia, computamos los mismos cEOFs para experimentos de DAMIP.
La Figura \@ref(fig:ceof-damip) muestra las series temporales para los experimentos hist-GHG, hist-nat, hist-stratO3 e hist-aer junto a las corridas históricas.

Para la fase de 0º del cEOF1, ni hist-nat ni hist-aer mustran tendencias significativas, sugiriendo que la tendencia observada no se debe a variabilidad ni al forzante de los aerosoles antropogénicos. 
Por otro lado, hist-stratO3 muestra una tendencia mucho mayor a la observada e hist-GHG muestra una tendencia negativa de similar magnitud la de hist-stratO3. 
Esto sugiere que el ozono estatosférico y los gases de efecto invernadero tienen efectos contrarios sobre esta fase del cEOF1. 

Una compensación parcial similar también se observa en la fase de 90º del cEOF1, la cual presenta una tendencia negativa en hist-GHG y positiva en hist-aer. 

![(\#fig:ceof-damip-mod)(ref:ceof-damip-mod-cap)](figures/50-cmip6/ceof-damip-mod-1.png)


(ref:suma-cap) Media multimodelo de las dos fases del cEOF1 para las corridas históricas y para la suma de las corridas hist-GHG, hist-stratO3 e hist-aer.

![(\#fig:suma)(ref:suma-cap)](figures/50-cmip6/suma-1.png)

Como una aproximación, la Figura \@ref(fig:suma) muestra la media multimodelo de la corrida histórica junto con la suma de las medias multimodelo de las corridas hist-GHG, hist-stratO3 e hist-aer.
Sorpendentemente ambas series presentan una variabilidad a largo plazo virtualmente idéntica, sugiriendo que el efecto de los forzantes es aproximadamente lineal.









## Conclusiones

Los modelos del CMIP6 consiguen caracterizar la estructura espacial de los cEOFs satisfactoriamente, con una buena correlación entre los patrones espaciales, particularmente la media multimodelo. 
La habilidad de los modelos de capturar sus características de segundo orden, como la relación con el ENSO y el SAM no es tan buena ni homogénea entre modelos. 
Sólo algunos modelos, como MIROC6 y CESM2 consiguen capturar la influencia del ENSO en la fase del cEOF2 y la relación de la mayoría de los modelos con el SAM es menor a la observada. 

La tendencia positiva de la fase de 0º del cEOF1 es capturada por la media multimodelo y el análisis de las corridas de DAMIP indican que ésta es forzada principalmente por el forzarte del ozono estratosférico parcialmente compensado por el forzante de los gases de efecto invernadero. 
Los modelos del CMIP6 también presentan una tendencia negativa en la fase de 90º del cEOF1 no presente en las observaciones que también es ifluenciada por el forznate antropogénico. 
