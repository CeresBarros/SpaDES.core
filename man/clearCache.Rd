% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cache.R
\name{clearCache,simList-method}
\alias{clearCache,simList-method}
\alias{showCache,simList-method}
\alias{keepCache,simList-method}
\title{\code{clearCache} for \code{simList} objects}
\usage{
\S4method{clearCache}{simList}(
  x,
  userTags = character(),
  after,
  before,
  ask = getOption("reproducible.ask"),
  useCloud = FALSE,
  cloudFolderID = getOption("reproducible.cloudFolderID", NULL),
  ...
)

\S4method{showCache}{simList}(x, userTags = character(), after, before, ...)

\S4method{keepCache}{simList}(
  x,
  userTags = character(),
  after,
  before,
  ask = getOption("reproducible.ask"),
  ...
)
}
\arguments{
\item{x}{A simList or a directory containing a valid archivist repository. Note:
For compatibility with \code{Cache} argument, \code{cacheRepo} can also be
used instead of \code{x}, though \code{x} will take precedence.}

\item{userTags}{Character vector. If used, this will be used in place of the
\code{after} and \code{before}.
Specifying one or more \code{userTag} here will clear all
objects that match those tags.
Matching is via regular expression, meaning partial matches
will work unless strict beginning (^) and end ($) of string
characters are used.
Matching will be against any of the 3 columns returned by \code{showCache()},
i.e., \code{artifact}, \code{tagValue} or \code{tagName}.
Also, length \code{userTags} > 1, then matching is by `and`.
For `or` matching, use \code{|} in a single character string.
See examples.}

\item{after}{A time (POSIX, character understandable by data.table).
Objects cached after this time will be shown or deleted.}

\item{before}{A time (POSIX, character understandable by data.table).
Objects cached before this time will be shown or deleted.}

\item{ask}{Logical. If \code{FALSE}, then it will not ask to confirm deletions using
\code{clearCache} or \code{keepCache}. Default is \code{TRUE}}

\item{useCloud}{Logical. If \code{TRUE}, then every object that is deleted locally will
also be deleted in the \code{cloudFolderID}, if it is non-\code{NULL}}

\item{cloudFolderID}{A googledrive id of a folder, e.g., using \code{drive_mkdir()}.
If left as \code{NULL}, the function will create a cloud folder with a warning.
The warning will have the \code{cloudFolderID} that should be used in subsequent calls.
It will also be added to \code{options("reproducible.cloudFolderID")},
but this will not persist across sessions.}

\item{...}{Other arguments. Currently, \code{regexp}, a logical, can be provided.
This must be \code{TRUE} if the use is passing a regular expression.
Otherwise, \code{userTags} will need to be exact matches. Default is
missing, which is the same as \code{TRUE}. If there are errors due
to regular expression problem, try \code{FALSE}. For \code{cc}, it is
passed to \code{clearCache}, e.g., \code{ask}, \code{userTags}}
}
\description{
This will take the \code{cachePath(object)} and pass

This will take the \code{cachePath(object)} and pass

This will take the \code{cachePath(object)} and pass
}
