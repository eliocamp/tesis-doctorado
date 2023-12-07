---
knit: purrr::partial(bookdown::render_book, output_format = 'all', preview = TRUE)
---

# Conclusiones

Esta tesis trató de mejorar el entendimiento de la circulación extratropical del hemisferio sur....

## Resumen

Al analizar los índices utilizados en la literatura para caracterizar la onda 3 se observó que éstos no eran capaces de caracterizar propiedades importantes de la misma, como su propagación meridional, amplitud variable a lo largo de cada círculo de latitud y variación de la fase a lo largo del año.
Ni el índice propuesto por @raphael2004 ni la amplitud de la onda 3 computada por Fourier permiten describir estas características.

Se propuso usar Funciones Empíricas Ortogonales Complejas (cEOF) para caracterizar la circulación zonalmente asimétrica del hemisferio sur.
Dada la alta correlación entre los modos observados en la tropósfera y estratósfera y la similitud de sus patrones espaciales, consideramos que pueden tratarse como modos de variabilidad conjunta.
Por lo tanto, éstos se calcularon utilizando los niveles de 200 hPa y 50 hPa en conjunto.
También nos restringimos al trimestre SON dado que este trimestre es el que maximiza las teleconexiones entre trópicos y extratrópicos.

El cEOF1 representa un patrón de onda 1 y es principalmente un modo estratosférico asociado a las anomalías de Columna Total de Ozono y el vórtice polar.
Además, su fase de 0º presenta una tendencia positiva estadísticamente significativa en el período 1940\--2020, aunque dicha tendencia parece haber desaparecido luego de 2000, lo cual sería consistente con la dinámica del agujero en la capa de ozono.
Este modo no presenta asociación significativa con la Temperatura de la Superficie del Mar (TSM), la temperatura a 2 metros o la precipitación y no presenta asociación con fuentes de variabilidad tropical.
Se trata de un modo interno de la atmósfera extratropical y de limitado interés en cuanto a impactos directos.

El cEOF2 representa un patrón de onda 3 con propagación meridional y localizado principalmente en el sector del océano Pacífico.
Es una forma alternativa de representar a los modos PSA1 y PSA2 (Patrón del Pacífico-Sudamérica) que los considera como un único modo conjunto con una amplitud y una fase continua.
Éste está asociado a anomalías significativas de TSM tropicales y a flujos de actividad de onda, indicando que está influenciado por la variabilidad tropical.

Al considerar la fase continua, este método permite mostrar no sólo que el cEOF2 tiende a estar en la fase de $\pm$ 90º cuando hay anomalías positivas o negativas en la región del ENSO, respectivamente, sino que la localización de las anomalías influyen en la fase.
Anomalías de TSM en el Pacífico central tienden a mover el cEOF2 hacia la fase de 180º y anomalías de TSM en el Pacífico oriental tienen a moverlo hacia la fase de 0º.
Cuando no hay anomalías significativas de TSM en el Pacífico tropical, el cEOF2 no tiene una fase preferencial pero su actividad no disminuye.

El cEOF2 surge como un modo de variabilidad interno de la atmósfera extratropical que en ausencia de forzante tropical carece de una fase preferencial.
El forzante tropical no influye significativamente en su intensidad pero sí tiende a determinar una fase estacionaria.
Esto es consistente con resultados de @cai2002, quien encontró que el modelo CSIRO desarrolla actividad tipo PSA aún removiendo la variabilidad de tipo ENSO, pero que la actividad de uno de los modos PSA se incrementa al agregar variabilidad del ENSO.
La intransitividad de la fase a la ubicación de las anomalías tropicales de TSM también fue detectada por @ciasto2015 al observar ondas de Rossby similares asociadas a anomalías de TSM en el Pacífico tanto central como oriental pero con variación en la fase.

Consistente con su relación con el ENSO, los impactos del cEOF2 en la superficie son significativos y dependientes de su fase.
En los extratrópicos, la fase de 90º se asocia a anomalías positivas de precipitación en el SESA y negativas en Australia en patrones consistentes con la señal del ENSO en la precipitación.
También se observaron anomalías significativas de temperatura en estos continentes y en Antártida Occidental.

Recientemente, @goyal2022 propuso un índice alternativo basado en los primeros dos EOF del viento meridional en 500 hPa y combinándolos en una medida de la amplitud y la fase de la onda 3.
Este método tiene similitudes con el cEOF2 pero creemos que el cEOF2 es superior dado que construye un patrón de ondas donde las fases ortogonales son ortogonales por construcción.
El método de @goyal2022 depende de la inspección visual por lo tanto no garantiza que la construcción de la fase y la amplitud sea realmente válida.
De todas formas, futuros trabajos deberán explorar las ventajas y limitaciones de cada uno.

También estudiamos la componente zonalmente asimétrica del SAM.
Para lo cual desarrollamos un índice del SAM simétrico (S-SAM) y del SAM asimétrico (A-SAM) proyectando los patrones simétricos y asimétricos del SAM, respectivamente.

En la tropósfera, los patrones espaciales de altura geopotencial asociados al S-SAM son mucho más anulares que los patrones asociados al índice SAM.
Por otro lado, el índice A-SAM está asociado a un patrón de onda 3 con amplitud máxima en el pacífico muy similar a la fase de 90º del cEOF2 (y, por lo tanto, al PSA1).
Este patrón tiene su amplitud máxima en 250 hPa, sugiriendo que los índices del SAM basados en variables de superficie no son óptimos para capturar esta variabilidad.

Observamos las mismas tendencias positivas del SAM en verano y otoño documentadas por estudios previos [p.e. @fogt2020 y sus referencias] en niveles bajos.
Estas tendencias son máximas en 100 hPa, y son únicamente explicadas por el S-SAM.
También detectamos una tendencia positiva estadísticamente significativa en en el S-SAM en la estratósfera en otoño que no es evidente en el índice SAM.
Hay evidencia de que el SAM está evolucionando hacia ser más asimétrico en verano, conrario a lo observado por @fogt2012.
Esta discrepancia puede deberse a las diferencias metodológicas o al período analizado.

El SAM está asociado, a grandes rasgos, con muestran anomalías de temperatura negativas en latitudes polares rodeadas de anomalías de temperatura positivas en latitudes más bajas.
Las desviaciones de este patrón zonalmente simétrico son explicadas en gran medida por el A-SAM.
Por ejemplo, el A-SAM está asociado a temperaturas más frías en el sur de Brasil, sur de África y sur de Australia y en el Pacífico ecuatorial (consistente con la correlación negativa entre el A-SAM y el ENSO).
Estas anomalías son particularmente fuertes en verano y primavera, lo cual incluye los meses con mayor actividad de teleconexiones del ENSO [e.g. @cai2020a].

Tanto en Sudamérica como en Australia, las anomalías de precipitación asociadas al SAM pueden separarse casi linealmente entre contribuciones del S-SAM y del A-SAM.
Futuros trabajos deberán estudiar el impacto de estos índices a otra variables, como la concentración del hielo marino Antártico.

@silvestri2009 sugiere que los impactos de la precipitación asociados al SAM sufrieron un cambio importante antes y después de 1980.
En particular, la relación negativa con la precipitación en Sudamérica no existía en algunas zonas y cambió de signo en otras.
La correlación entre ENSO y SAM tampoco es estacionaria, y también cambió de signo antes de la década de 1980 [@fogt2006; @clem2013].
Dado que tanto la relación ENSO-SAM como la mayoría de los impactos de la precipitación en América del Sur son capturados por el A-SAM, la magnitud y el signo de estos impactos son muy probablemente dependientes del período y representan la señal media entre 1979 y 2018.
Las variaciones decenales del A-SAM deberían ser el foco de futuros estudios.
Esto es particularmente importante en el contexto del cambio climático, ya que el impacto del recuperación del ozono sobre el SAM se piensa como altamente zonalmente simétrico, mientras que el impacto del aumento de la concentración de gases de efecto invernadero tiene también un componente asimétrico zonal [@arblaster2006].

La correlación significativa entre el índice SAM y el ENSO es capturada en su totalidad por el A-SAM, lo que sugiere que el ENSO y el SAM están conectados únicamente por la variabilidad zonalmente asimétrica.
El A-SAM es, por lo tanto, una medida muy útil para estudiar la relación entre estos dos modos de variabilidad.

La relación entre el SAM y la fase de 90º del cEOF2 es significativa pero modesta en la tropósfera, lo cual es consistente con los patrones tipo SAM asociados a éste último.
Sin embargo, la correlación entre el A-SAM y esta fase del cEOF2 es extremadamente alta, sugiriendo que ambos índices están representando el mismo modo y permitiendo una identificación entre la parte asimétrica del SAM y la fase de 90º del cEOF2 (que es el PSA1).
Esto sugiere que la correlación entre el ENSO y el SAM se debe a la correlación entre el ENSO y el PSA1 (al menos en primavera).

Es necesario más investigación sobre la conexión entre el SAM y el PSA.
Es posible que la variabilidad zonalmente asimétrica del PSA fuerze una respuesta zonalmente simétrica (y viceversa) a través de interacciones entre el flujo zonal medio y las ondas [@kim2004].
También es posible que la correlación sea simplemente un artefacto estadístico resultante de la metodología utilizada para definir el SAM dado que la estructura espacial del PSA se proyecta sobre la estructura espacial de la parte simétrica del SAM.

CMIP6

Estudiar mejor los modelos CMIP6.
