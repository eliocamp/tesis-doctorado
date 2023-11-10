# Métodos

Acá van a ir los métodos.

## Datos

Utilizamos datos mensuales de altura geopotencial, temperatura del aire, relación de mezcla de ozono y columna total de ozono (CTO) del European Centre for Medium-Range Weather Forecasts Reanalysis versión 5 (ERA5) [@era5].
Estos datos se utilizaron a una resolución espacial de 2,5° de longitud por 2,5° de latitud y 37 niveles verticales de presión entre 1000 hPa y 1 hPa.
La mayor parte del análisis utiliza datos del período post-satelital (1979 a 2019) para minimizar posibles problemas causados por cambios en la cobertura de datos, pero nos extendemos hacia 1940 para examinar las tendencias a largo plazo.

La función de corriente a 200 hPa se derivó a partir de la vorticidad de ERA5 utilizando la subrutina de FORTRAN FISHPACK [@fishpack], y los flujos de actividad de ondas horizontales se calcularon siguiendo el método descrito por [@plumb1985].

Utilizamos datos mensuales de Temperatura de la Superficie del Mar (TSM) de Extended Reconstructed Sea Surface Temperature (ERSST) v5 [@huang2017] y precipitación mensual del CPC Merged Analysis of Precipitation [CMAP, @cmap], con una resolución de 2º y 2,5º, respectivamente.
Este conjunto de datos de lluvia integra información de diversas fuentes, incluyendo observaciones de pluviómetros, estimaciones inferidas por satélite y el reanálisis NCEP-NCAR.
Cubre el período desde 1979 hasta la actualidad.

Además, incorporamos índices climáticos en nuestro análisis.
El Índice del ENSO Oceánico [ONI, @bamston1997] del Climate Prediction Center de la NOAA y el Índice del Dipolo del Índico [DMI, @saji2003] del Global Climate Observing System Working Group on Surface Pressure.

### Regresiones

Tanto en el Capítulo [ceofs] como en el Capítulo [asymsam] se derivaron índices multivariados.
Para cuantificar la asociación entre éstos y otras variables meteorológicas usamos regresión lineal múltiple.
Para obtener los coeficientes lineales de una variable $Z$ (altura geopotencial, temperatura, precipitación, etc.) con un índice de variables X e Y ajustamos la ecuación

```{=tex}
\begin{equation}
Z(\lambda, \phi, t) = \alpha(\lambda, \phi) \operatorname{X} + \beta(\lambda, \phi) \operatorname{Y} + X_0(\lambda, \phi) + \epsilon(\lambda, \phi, t)
(\#eq:multiple-regression-sam)
\end{equation}
```

donde $\lambda$ y $\phi$ son la longitud y la latitud, $t$ es el tiempo, $\alpha$ y $\beta$ son los coeficientes de regresión lineal, $X_0$ y $\epsilon$ son la constante y los términos de error.
A partir de esta ecuación, $\alpha$ representa la asociación (lineal) de $Z$ con la variabilidad de $X$ que no se explica por la variabilidad de $Y$; es decir, es proporcional a la correlación parcial de $Z$ y $X$, controlando el efecto de $Y$, y viceversa para $\beta$.

Para las regresiones estacionales, promediamos la variables para cada año y trimestre (DJF, MAM, JJA, SON) antes de calcular la regresión.

La significancia estadística de los campos de regresión se evaluó ajustando los p-valores mediante el control de la Tasa de Falso Descubrimiento [@benjamini1995; @wilks2016] para evitar resultados engañosos derivados del elevado número de regresiones [@walker1914; @katz1991].

Calculamos las tendencias lineales mediante mínimos cuadrados ordinarios y el intervalo de confianza del 95% se calculó asumiendo una distribución t con los grados de libertad de los residuos apropiados.

Calculamos las estimaciones de probabilidad de densidad utilizando un kernel gaussiano de anchura óptima según @sheather1991.


## EOF

Calculamos los EOFs haciendo la descomposición en valores singulares de la matriz de datos.
Ponderamos los valores por la raíz cuadrada del coseno de la latitud para tener en cuenta que el área representada por cada punto de grilla [@chung1999].