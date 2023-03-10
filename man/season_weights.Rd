% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/quickstats.R
\name{season_weights}
\alias{season_weights}
\title{Computes weights for seasonal weighted means}
\usage{
season_weights(time, groups = metR::seasonally(time))
}
\arguments{
\item{time, }{a vector of times}

\item{groups}{vector of the same length as \code{time} that
defines the grouping.}
}
\value{
a vector of the same length as \code{time} that when used as
weights in \code{mean(x*w)} returns the same as
\code{weighted.mean(x, w)} computed for each group in \code{groups}.
}
\description{
\code{\link[=weighted.mean]{weighted.mean()}} is not GForce-optimised in data.table and
therefore, using it to compute weighted means is much slower
than computing the weights first and the computing \code{mean(x*w)}
}
