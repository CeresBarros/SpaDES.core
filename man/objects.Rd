% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simList-accessors.R
\name{objs}
\alias{objs}
\alias{simList-accessors-objects}
\alias{objs,simList-method}
\alias{objs<-}
\alias{objs<-,simList-method}
\title{Extract or replace an object from the simulation environment}
\usage{
objs(sim, ...)

\S4method{objs}{simList}(sim, ...)

objs(sim) <- value

\S4method{objs}{simList}(sim) <- value
}
\arguments{
\item{sim}{A \code{simList} object from which to extract element(s) or
in which to replace element(s).}

\item{...}{passed to \code{ls}}

\item{value}{objects to assign to the \code{simList}}
}
\value{
Returns or sets a list of objects in the \code{simList} environment.
}
\description{
The \code{[[} and \code{$} operators provide "shortcuts" for accessing
objects in the simulation environment.
I.e., instead of using \code{envir(sim)$object} or \code{envir(sim)[["object"]]},
one can simply use \code{sim$object} or \code{sim[["object"]]}.
}
\details{
\code{objs} can take \code{...} arguments passed to \code{ls},
allowing, e.g. \code{all.names=TRUE}
\code{objs<-} requires takes a named list of values to be assigned in
the simulation environment.
}
\seealso{
\code{\link{SpaDES.core-package}}, specifically the section 1.2.1 on Simulation Parameters.

Other functions to access elements of a 'simList' object: 
\code{\link{.addDepends}()},
\code{\link{doEvent.checkpoint}()},
\code{\link{envir}()},
\code{\link{events}()},
\code{\link{globals}()},
\code{\link{inputs}()},
\code{\link{modules}()},
\code{\link{packages}()},
\code{\link{params}()},
\code{\link{paths}()},
\code{\link{progressInterval}()},
\code{\link{times}()}
}
\concept{functions to access elements of a 'simList' object}
