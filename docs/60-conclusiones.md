---
knit: purrr::partial(bookdown::render_book, output_format = 'all', preview = TRUE)
---

# Conclusiones



Esta tesis se propuso mejorar el entendimiento de las asimetrías zonales de la circulación extratropical del hemisferio sur.

Se comenzó evaluando las formas tradicionales de describir estas asimetrías, que son principalmente a través del análisis del patrón de onda 3 como lo propuso @raphael2004 o a través de un análisis de Fourier.
Sin embargo, se encontró que estos métodos no son capaces de caracterizar propiedades importantes de la circulación asimétrica, como su dispersión meridional, la amplitud variable de los centros que la caracterizan a lo largo de cada círculo de latitud y la variación de su fase a lo largo del año.

Considerando estas limitaciones, esta tesis propuso una forma alternativa para la caracterización de la circulación zonalmente asimétrica del hemisferio sur a partir del uso de Funciones Empíricas Ortogonales Complejas (cEOF), metodología que permite capturar oscilaciones con amplitud y fase variables.
Dada la alta correlación temporal entre los modos observados en la tropósfera y estratósfera y la similitud de sus patrones espaciales al aplicar la metodología cEOF en distintos niveles atmosféricos, se consideró que pueden tratarse como modos de variabilidad conjunta.
Por lo tanto, los cEOF se calcularon utilizando la altura geopotencial de los niveles de 200 hPa y 50 hPa en conjunto.
Se hizo foco en la estación de primavera, ya que durante ésta se maximizan las teleconexiones entre los trópicos y extratrópicos.

El primer modo obtenido a partir del análisis cEOF (cEOF1) representa un patrón de onda 1 y es principalmente un modo estratosférico con fuerte asociación con la dinámica del vórtice polar.
La regresión de las anomalías temporales de altura geopotencial con este modo tanto en su fase 0 como en su fase 90 muestran su influencia significativa en modular la ubicación e intensidad del centro de anomalía sobre la región antártica en asociación con un centro y banda de anomalías de signo opuesto en latitudes medias.
Acorde, este modo presenta una correlación significativa con la actividad del SAM como se discute más abajo.
En especial se encontró que presenta una asociación significativa con las anomalías de Columna Total de Ozono, lo cual es también otra evidencia de la influencia de la dinámica estratosférica en el comportamiento de este modo.
Por otra parte, no presenta asociación significativa con fuentes de variabilidad tropical.
En superficie, no presenta influencia significativa en la precipitación.
Sí, en cambio, influye significativamente en las anomalías de la temperatura del aire en superficie en Antártida Occidental y en especial en la Península Antártica, así como en algunas regiones oceánicas en la vecindad de Australia, Sudamérica y África.
Esto es coherente con trabajos previos que confirman la influencia del SAM sobre las anomalías de temperatura regionales en el hemisferio sur.

El segundo modo obtenido a partir del análisis cEOF (cEOF2) representa una estructura espacial de onda 3 que está localizado principalmente en el sector del océano Pacífico.
Se encontró que está fuertemente asociado con trenes de onda del tipo PSA.
Además, es una forma alternativa de representar a los modos PSA1 y PSA2 (que surgen del tradicional análisis de EOF) como un único modo conjunto con una amplitud y una fase continua.
Al igual que el cEOF1, este segundo modo presenta vinculación con el SAM, pero a diferencia del primer modo, la variabilidad del cEOF2 está fuertemente influenciada por la variabilidad tropical.
Además se mostró que el cEOF2 surge como un modo de variabilidad interna de la atmósfera extratropical, aunque en ausencia del forzante tropical carece de una fase preferencial.
El forzante tropical no influye significativamente en su intensidad, pero sí tiende a determinar una fase estacionaria.
Esto es consistente con @cai2002, quienes encontraron a partir de simulaciones con un modelo de circulación general acoplado que se puede desarrollar actividad tipo PSA aún con condiciones medias climatológicas en el océano superficial, removiendo la variabilidad de tipo ENSO, pero que la actividad de uno de los modos PSA se incrementa al incluirla.

Consistente con su relación con el ENSO, los impactos del cEOF2 en la superficie son significativos y dependientes de su fase.
En los extratrópicos, la fase de 90º se asocia con anomalías positivas de precipitación en el SESA y negativas en Australia en patrones consistentes con la señal del ENSO en la precipitación.
También se observaron anomalías significativas de temperatura en estos continentes y en la Antártida Occidental.

Se concluye entonces que el cEOF2 describe a la onda 3 de una manera matemática y físicamente más completa que la descripción que se obtiene con otros métodos previamente descritos.
Recientemente, @goyal2022 propuso un índice alternativo para la onda 3 basado en los primeros dos EOF del viento meridional en 500 hPa.
Aunque este método tiene similitudes con el cEOF2, depende de la inspección visual, por lo que no garantiza que la construcción de la fase y la amplitud sea realmente válida.
En cambio, el cEOF2 tiene la ventaja de construirse como un patrón de ondas con amplitud y fase por construcción.

Los resultados obtenidos tanto con el cEOF1 como con el cEOF2 muestran en suma que ambos modos a través de sus fases y amplitudes variables proporcionan una descripción más profunda y compleja de las principales estructuras asociadas con la variabilidad de la circulación del hemisferio sur como son la estructura anular polar, la onda 3 extratropical y los trenes de onda extendidos desde el Indico-Pacífico tropical hacia Sudamérica, que aquella proporcionada por el método de EOF tradicional.
Esto abre nuevas oportunidades para estudiar desde un abordaje diferente la influencia, tanto de la variabilidad tropical como de la variabilidad estratosférica, en la circulación del hemisferio sur y en sus porciones continentales.

El análisis del comportamiento asimétrico de la circulación del hemisferio sur se completó con el estudio de las características simétricas y asimétricas del SAM, por ser el patrón principal que explica su variabilidad temporal.
Para esto se desarrollaron índices para describir la componente simétrica del SAM (S-SAM) y la componente asimétrica del SAM (A-SAM), a partir de la media zonal y de las anomalías espaciales del SAM completo .

Tanto en la estratosfera como en la tropósfera, la estructura de las anomalías temporales de la altura geopotencial asociados al S-SAM es mucho más anular que aquella asociada con el SAM completo.
Por otro lado, el índice A-SAM está asociado en la estratosfera a un patrón de onda 1 y en la troposfera a un patrón de onda 3 con amplitud máxima en el pacífico muy similar a la fase de 90º del cEOF2.

La correlación significativa entre el índice SAM y el ENSO es capturada en su totalidad por el A-SAM, lo que sugiere que el ENSO y el SAM están conectados únicamente por la variabilidad zonalmente asimétrica.
El A-SAM es, por lo tanto, una medida muy útil para estudiar la relación entre estos dos modos de variabilidad.
Por otro lado, este resultado abre la pregunta sobre si la componente asimétrica del SAM forma parte intrínsicamente de este modo interno de variabilidad, o es en cambio un reflejo de la influencia del ENSO en la circulación extratropical que por construcción queda embebido en el primer EOF aplicado a las anomalías temporales.
Evidencias de esta posibilidad se encuentran en el antiguo trabajo de @kidson1988 donde, aplicando rotación a las EOFs, obtiene modos rotados que separan una estructura anular similar a la obtenida con el S-SAM de un patrón de onda 3 similar al obtenido con el A-SAM.
Otro trabajo relevante es @ding2012a, quienes computaron el primer EOF a la altura geopotencial en 700 hPa filtrar la variabilidad asociada al modo PSA. 
Estudios futuros deberían abordar esta cuestión con mayor profundidad.

El análisis de las tendencias positivas del SAM de verano y otoño en la troposfera entre 1940 y 2020, que fueron identificadas como significativas por estudios previos [p.ej. @fogt2020 y sus referencias] son únicamente explicadas por la tendencia del S-SAM.
También se dedectó una tendencia positiva estadísticamente significativa en el S-SAM en la estratósfera en otoño que no es evidente en el índice SAM.
Hay evidencia de que el SAM está evolucionando hacia ser más asimétrico en verano, aunque el período es corto y la señal no es muy robusta.
Esto es contrario a lo observado por @fogt2012, aunque la discrepancia puede deberse a las diferencias metodológicas o al período analizado.

La fase positiva del SAM está asociado, a grandes rasgos, con anomalías de temperatura negativas en latitudes polares rodeadas de anomalías de temperatura positivas en latitudes más bajas.
Entre otoño y primavera el S-SAM está principalmente asociado con anomalías de temperatura negativas sobre el continente antártico (principalmente en Antártida oriental) y positivas sobre la Península Antártica, y con anomalías negativas en el Pacífico Sur.
El índice A-SAM describe principalmente en el sector del Pacífico Sur hasta la costa antártica una alternancia de anomalías de temperatura de signos contrapuestos que son coherentes con la onda 3 que describe las anomalías de altura geopotencial.

Asimismo, tanto en Sudamérica como en Australia, las anomalías de precipitación asociadas al SAM mezclan las contribuciones del S-SAM y del A-SAM, las cuales responden a distintos procesos físicos.
En el sur de Chile, las anomalías negativas de precipitación asociadas al SAM se explican por el desplazamiento de los oestes hacia el Sur asociado al S-SAM.
En el SESA, en cambio, las anomalías negativas de precipitación asociadas al SAM se explican por el efecto del anticiclón en el Atlántico Sur asociado al A-SAM. 

En relación a la vinculación de la componentes del SAM con los cEOFs se encontró que la relación entre el SAM y el cEOF1 está explicada en su totalidad por la componente S-SAM mientras que la relación entre el SAM y la fase de 90º del cEOF2 es explicada principalmente por el A-SAM.
Esto nuevamente confirma que la descripción de la circulación en términos de su componente simétrica y asimétrica proporciona un mayor detalle de los procesos que caracterizan su asociación con el SAM.
Asimismo, la fuerte correlación entre el A-SAM y la fase 90 del cEOF2 es otra evidencia de la importante influencia del ENSO en la estructura de onda 3 a través de las teleconexiones del tipo PSA.,

Al evaluar la capacidad de los modelos del CMIP6 para describir los patrones cEOF, se encontró que los 19 modelos analizados capturan correctamente la estructura espacial de los cEOFs, pero no todos consiguen capturar su variabilidad temporal y relaciones con otras variables climáticas.
Por otra parte, la relación entre la fase de 90º del cEOF2 y el SAM no está presente en la mayoría de los modelos, pero sí la relación con el A-SAM, aunque en menor medida.

Se detectó una leve tendencia positiva en la fase de 0º del cEOF1 en ERA5 en el período 1940--2022.
Ésta no es simulada consistentemente por los modelos de CMIP6; la media multimodelo presenta una tendencia positiva pero de baja magnitud.
Por otro lado, aparece en los modelos una tendencia negativa mucho más intensa en la fase de 90º que no está presente en las observaciones.
Los experimentos que consideran por separado los forzantes naturales y los distintos forzantes antropogénicos (gases de efecto invernadero, ozono estratosférico, aerosoles) sugieren que los gases de efecto invernadero contribuyen a una tendencia negativa en ambas fases, mientras que la variación del ozono estratosférico aporta a una tendencia positiva en la fase de 0º de modo que compensa el efecto de los gases de efecto invernadero y generan una tendencia neta positiva.

Entre las causas que explican las diferencias entre las tendencias observadas y simuladas se puede mencionar una incorrecta sensibilidad a los forzantes en los modelos, problemas de la capacidad de los modelos para resolver procesos clave en la dinámica de la circulación asimétrica zonal del hemisferio sur como la variabilidad del vórtice polar, el agujero en la capa de ozono, o a diferencias en los campos medios de anomalías zonales de geopotencial.
Finalmente, dado que ERA5 es sólo una realización del sistema climático, no se puede descartar que las tendencias representadas por la media multimodelo de los modelos de CMIP6 sean una mejor representación de los efectos de los forzantes.

En resumen, este trabajo de tesis aporta nuevas herramientas para mejorar el entendimiento de la circulación zonalmente asimétrica del hemisferio sur al analizar los principales patrones de circulación mediante cEOFs y al estudiar por separado las componentes zonalmente asimétricas y simétricas del SAM.

El cEOF principal es un patrón de onda 1 vinculado al vórtice polar, al SAM y a las anomalías de ozono que tiene impacto sobre la temperatura en la Antártida.
Por otro lado, el segundo cEOF está asociado a la onda zonal 3 y describe el patrón de teleconexiones entre los trópicos y los extratrópicos.
Los modelos de CMIP6 se mostraron adecuados para representar estos modos pero no todos consiguen simular su relación con el ENSO o el SAM ni sus tendencias correctamente.

Tomados en su conjunto, estos patrones permiten representar las características principales de la variabilidad del hemisferio sur.
La variabilidad anular con el S-SAM, el vórtice polar con el cEOF1 y los trenes de onda de Rossby con el cEOF2.

Estos resultados abren la puerta a muchas investigaciones futuras.
Es necesario extender el estudio a otros trimestres además de SON, así como adentrar en el impacto de estos modos en otras variables del sistema climático.
Queda pendiente estudiar en más detalle cómo se comporta el cEOF2 en ausencia de variabilidad tropical y cuál es su relación con la variabilidad del vórtice polar.
A su vez, quedan sin dilucidar los mecanismos que establecen la relación entre el S-SAM y el A-SAM/cEOF2, los cuales pueden ser estudiados mediante simulaciones de sensibilidad.
En cuanto a los modelos de CMIP6, un estudio más detallado de las propiedades de cada modelo podría permitir entender qué procesos son importantes para una correcta caracterización de la circulación asimétrica y sus tendencias.
