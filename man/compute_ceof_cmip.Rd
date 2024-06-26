% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compute-ceof-cmip6.R
\name{compute_ceof_cmip}
\alias{compute_ceof_cmip}
\title{Computa el cEOF de modelos de CMIP6}
\usage{
compute_ceof_cmip(
  files,
  members,
  time = c("1979-10-01", "2014-12-31"),
  ref = NULL
)
}
\arguments{
\item{files}{vector de archivos NetCDF con las corridas del modelo}

\item{members}{nombres de los miembros de la simulación}

\item{time}{vector que define el rango de fechas a usar}

\item{ref}{cEOF de referencia}
}
\value{
un objeto de clase EOF
}
\description{
Computa el cEOF de modelos de CMIP6
}
