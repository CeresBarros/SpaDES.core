% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc-methods.R
\docType{data}
\name{setPaths}
\alias{setPaths}
\alias{.paths}
\alias{getPaths}
\alias{Paths}
\title{Get and set default working directories}
\format{An object of class \code{list} of length 5.}
\usage{
.paths()

getPaths()

Paths

setPaths(
  cachePath,
  inputPath,
  modulePath,
  outputPath,
  rasterPath,
  silent = FALSE
)
}
\arguments{
\item{cachePath}{The default local directory in which to cache simulation outputs.
If not specified, defaults to \code{getOption("reproducible.cachePath")}.}

\item{inputPath}{The default local directory in which to look for simulation inputs
If not specified, defaults to \code{getOption("spades.inputPath")}.}

\item{modulePath}{The default local directory where modules and data will be
downloaded and stored.
If not specified, defaults to \code{getOption("spades.modulePath")}.}

\item{outputPath}{The default local directory in which to save simulation outputs.
If not specified, defaults to \code{getOption("spades.outputPath")}.}

\item{rasterPath}{The default local directory in which to save transient raster files.
If not specified, defaults to \code{\link[raster]{tmpDir}}.
\emph{Important note:} this location may not be cleaned up automatically,
so be sure to monitor this directory and remove unnecessary temp files
that may contribute to excessive disk usage.}

\item{silent}{Logical. Should the messaging occur.}
}
\value{
Returns a named list of the user's default working directories.
\code{setPaths} is invoked for the side effect of setting these directories.
}
\description{
Wrapper functions to access the packages options for default working directories.
Note: there is an active binding made to \code{Paths}, so a user can use
\code{Paths$cachePath} for example instead of \code{getPaths()$cachePath}
}
\examples{
\dontrun{
getPaths()                       ## returns the current default working paths
setPaths(cachePath = tempdir())  ## sets custom cachePath with other paths default
setPaths(inputPath = tempdir())  ## sets custom inputPath with other paths default
setPaths(modulePath = tempdir()) ## sets custom modulePath with other paths default
setPaths(outputPath = tempdir()) ## sets custom outputPath with other paths default

# NOTE: on loading and attaching SpaDES.core,
# an active binding is made to "Paths"

getPaths()
Paths # same
setPaths(outputPath = tempdir())
Paths # shows change
}

}
\author{
Alex Chubaty
}
\keyword{datasets}
\keyword{internal}
