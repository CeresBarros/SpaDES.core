% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/copy.R
\name{Copy,simList-method}
\alias{Copy,simList-method}
\title{Copy for simList class objects}
\usage{
\S4method{Copy}{simList}(object, filebackedDir, objects, queues)
}
\arguments{
\item{object}{An R object (likely containing environments) or an environment.}

\item{filebackedDir}{A directory to copy any files that are backing R objects,
currently only valid for \code{Raster} classes. Defaults
to \code{tempdir()}, which is unlikely to be very useful.
Can be \code{NULL}, which means that the file will not be
copied and could therefore cause a collision as the
pre-copied object and post-copied object would have the same
file backing them.}

\item{objects}{Whether the objects contained within the simList environment
should be copied. Default \code{TRUE}, which may be slow.}

\item{queues}{Logical. Should the events queues (\code{events},
\code{current}, \code{completed}) be deep copied via
\code{data.table::copy}}
}
\description{
Because a simList works with an environment to hold all objects,
all objects within that slot are pass-by-reference. That means
it is not possible to simply copy an object with an assignment operator:
the two objects will share the same objects. As one simList object changes
so will the other. when this is not the desired behaviour, use this function.
NOTE: use capital C, to limit confusion with \code{data.table::copy()}
See \code{\link[reproducible]{Copy}}.
}
\details{
\code{simList} objects can contain a lot of information, much of which could be
in pass-by-reference objects (e.g., \code{data.table} class), and objects that are
file-backed, such as some \code{Raster*}-class objects. For all the objects that
are file-backed, it is likely \emph{very} important to give unique file-backed
directories. This should be passed here, which gets passed on to the many methods
of \code{Copy} in \code{reproducible}.
}
\seealso{
\code{\link[reproducible]{Copy}}
}
\author{
Eliot McIntire
}
