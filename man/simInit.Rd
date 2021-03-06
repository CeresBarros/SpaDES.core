% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simulation-simInit.R
\name{simInit}
\alias{simInit}
\alias{simInit,list,list,list,list,list,data.frame,data.frame,character-method}
\alias{simInit,ANY,ANY,ANY,character,ANY,ANY,ANY,ANY-method}
\alias{simInit,ANY,ANY,character,ANY,ANY,ANY,ANY,ANY-method}
\alias{simInit,ANY,ANY,ANY,ANY,ANY,ANY,ANY,ANY-method}
\title{Initialize a new simulation}
\usage{
simInit(
  times,
  params,
  modules,
  objects,
  paths,
  inputs,
  outputs,
  loadOrder,
  notOlderThan = NULL
)

\S4method{simInit}{list,list,list,list,list,data.frame,data.frame,character}(
  times,
  params,
  modules,
  objects,
  paths,
  inputs,
  outputs,
  loadOrder,
  notOlderThan = NULL
)

\S4method{simInit}{ANY,ANY,ANY,character,ANY,ANY,ANY,ANY}(
  times,
  params,
  modules,
  objects,
  paths,
  inputs,
  outputs,
  loadOrder,
  notOlderThan = NULL
)

\S4method{simInit}{ANY,ANY,character,ANY,ANY,ANY,ANY,ANY}(
  times,
  params,
  modules,
  objects,
  paths,
  inputs,
  outputs,
  loadOrder,
  notOlderThan = NULL
)

\S4method{simInit}{ANY,ANY,ANY,ANY,ANY,ANY,ANY,ANY}(
  times,
  params,
  modules,
  objects,
  paths,
  inputs,
  outputs,
  loadOrder,
  notOlderThan = NULL
)
}
\arguments{
\item{times}{A named list of numeric simulation start and end times
(e.g., \code{times = list(start = 0.0, end = 10.0)}).}

\item{params}{A list of lists of the form \code{list(moduleName=list(param1=value, param2=value))}.
See details.}

\item{modules}{A named list of character strings specifying the names
of modules to be loaded for the simulation. Note: the module name
should correspond to the R source file from which the module is loaded.
Example: a module named "caribou" will be sourced form the file
\file{caribou.R}, located at the specified \code{modulePath(simList)} (see below).}

\item{objects}{(optional) A vector of object names (naming objects
that are in the calling environment of
the \code{simInit}, which is often the
\code{.GlobalEnv} unless used programmatically
-- NOTE: this mechanism will
fail if object name is in a package dependency), or
a named list of data objects to be
passed into the simList (more reliable).
These objects will be accessible
from the simList as a normal list, e.g,. \code{mySim$obj}.}

\item{paths}{An optional named list with up to 4 named elements,
\code{modulePath}, \code{inputPath}, \code{outputPath}, and \code{cachePath}.
See details. NOTE: Experimental feature now allows for multiple \code{modulePath}s
to be specified in a character vector. The modules will be searched for sequentially
in the first \code{modulePath}, then if it doesn't find it, in the second etc.}

\item{inputs}{A \code{data.frame}. Can specify from 1 to 6
columns with following column names: \code{objectName} (character, required),
\code{file} (character), \code{fun} (character), \code{package} (character),
\code{interval} (numeric), \code{loadTime} (numeric).
See \code{\link{inputs}} and vignette("ii-modules") section about inputs.}

\item{outputs}{A \code{data.frame}. Can specify from 1 to 5
columns with following column names: \code{objectName} (character, required),
\code{file} (character), \code{fun} (character), \code{package} (character),
\code{saveTime} (numeric) and \code{eventPriority} (numeric). If
\code{eventPriority} is not set, it defaults to \code{.last()}. If \code{eventPriority}
is set to a low value, e.g., 0, 1, 2 and \code{saveTime} is \code{start(sim)},
it should give "initial conditions".

See \code{\link{outputs}} and
\code{vignette("ii-modules")} section about outputs.}

\item{loadOrder}{An optional list of module names specifying the order in
which to load the modules. If not specified, the module
load order will be determined automatically.}

\item{notOlderThan}{A time, as in from \code{Sys.time()}. This is passed into
the \code{Cache} function that wraps \code{.inputObjects}.
If the module uses the \code{.useCache} parameter and it is
set to \code{TRUE} or \code{".inputObjects"},
then the \code{.inputObjects} will be cached.
Setting \code{notOlderThan = Sys.time()} will cause the
cached versions of \code{.inputObjects} to be refreshed,
i.e., rerun.}
}
\value{
A \code{simList} simulation object, pre-initialized from values
specified in the arguments supplied.
}
\description{
Create a new simulation object, the "sim" object. This object is implemented
using an \code{environment} where all objects and functions are placed.
Since environments in \code{R} are pass by reference, "putting" objects in
the sim object does no actual copy.
The \code{simList} also stores all parameters, and other important simulation
information, such as times, paths, modules, and module load order.
See more details below.
}
\details{
\subsection{Calling this \code{simInit} function does the following:}{
  \tabular{lll}{
  \bold{What} \tab \bold{Details} \tab \bold{Argument(s) to use} \cr
  fills \code{simList} slots \tab places the arguments \code{times},
    \code{params}, \code{modules}, \code{paths} into equivalently named
    \code{simList} slots \tab \code{times},
    \code{params}, \code{modules}, \code{paths}\cr
  sources all module files \tab places all function definitions in the
    \code{simList}, specifically, into a sub-environment of the main
    \code{simList} environment: e.g., \code{sim$<moduleName>$function1}
    (see section on \bold{Scoping}) \tab \code{modules} \cr
  copies objects \tab from the global environment to the
    \code{simList} environment \tab \code{objects} \cr
  loads objects \tab from disk into the \code{simList} \tab \code{inputs} \cr
  schedule object loading/copying \tab Objects can be loaded into the
    \code{simList} at any time during a simulation  \tab \code{inputs} \cr
  schedule object saving \tab Objects can be saved to disk at any arbitrary
    time during the simulation. If specified here, this will be in addition
    to any saving due code inside a module (i.e., a module may manually
    run \code{write.table(...)} \tab \code{outputs} \cr
  schedules "init" events \tab from all modules (see \code{\link{events}})
       \tab automatic  \cr
  assesses module dependencies \tab via the inputs and outputs identified in their
    metadata. This gives the order of the \code{.inputObjects} and \code{init}
    events. This can be overridden by \code{loadOrder}. \tab automatic \cr
  determines time unit \tab takes time units of modules
      and how they fit together \tab \code{times} or automatic \cr
  runs \code{.inputObjects} functions \tab from every module
    \emph{in the module order as determined above} \tab automatic \cr
  }
}

\code{params} can only contain updates to any parameters that are defined in
the metadata of modules. Take the example of a module named, \code{Fire}, which
has a parameter named \code{.plotInitialTime}. In the metadata of that module,
it says \code{TRUE}. Here we can override that default with:
\code{list(Fire=list(.plotInitialTime=NA))}, effectively turning off plotting.
Since this is a list of lists, one can override the module defaults for multiple
parameters from multiple modules all at once, with say:
\code{list(Fire = list(.plotInitialTime = NA, .plotInterval = 2),
           caribouModule = list(N = 1000))}.

We implement a discrete event simulation in a more modular fashion so it is
easier to add modules to the simulation. We use S4 classes and methods,
and fast lists to manage the event queue.

\code{paths} specifies the location of the module source files,
the data input files, and the saving output files. If no paths are specified
the defaults are as follows:

\itemize{
  \item \code{cachePath}: \code{getOption("reproducible.cachePath")};

  \item \code{inputPath}: \code{getOption("spades.modulePath")};

  \item \code{modulePath}: \code{getOption("spades.inputPath")};

  \item \code{inputPath}: \code{getOption("spades.outputPath")}.
}
}
\note{
Since the objects in the \code{simList} are passed-by-reference, it is useful
to create a copy of the initialized \code{simList} object prior to running
the simulation (e.g., \code{mySimOut <- spades(Copy(mySim))}).
This ensures you retain access to the original objects, which would otherwise
be overwritten/modified during the simulation.

The user can opt to run a simpler \code{simInit} call without inputs, outputs, and times.
These can be added later with the accessor methods (See example).
These are not required for initializing the simulation via simInit.
All of \code{modules}, \code{paths}, \code{params}, and \code{objects} are needed
for successful initialization.
}
\section{Parsing and Checking Code}{


The \code{simInit} function will attempt to find usage of sim$xxx
or sim[['xxx']] on either side of the assignment "<-" operator.
It will compare these to the module metadata, specifically
\code{inputObjects} for cases where objects or "gotten" from the
simList and \code{outputObjects} for cases where objects are
assigned to the simList.

It will also attempt to find potential, common function name conflicts
with things like scale and stack (both in base and raster), and
Plot (in quickPlot and some modules).

\emph{This code checking is young and may get false positives and
false negatives -- i.e., miss things}. It also takes computational
time, which may be undesirable in operational code.
To turn off checking (i.e.,
if there are too many false positives and negatives), set
the option \code{spades.moduleCodeChecks} to \code{FALSE},
e.g., \code{options(spades.moduleCodeChecks = FALSE)}
}

\section{Caching}{


Using caching with \code{SpaDES} is vital when building re-usable and reproducible content.
Please see the vignette dedicated to this topic.
}

\examples{
\dontrun{
mySim <- simInit(
 times = list(start = 0.0, end = 2.0, timeunit = "year"),
 params = list(
   .globals = list(stackName = "landscape", burnStats = "nPixelsBurned")
 ),
 modules = list("randomLandscapes", "fireSpread", "caribouMovement"),
 paths = list(modulePath = system.file("sampleModules", package = "SpaDES.core"))
)
spades(mySim) # shows plotting

# Change more parameters, removing plotting
mySim <- simInit(
 times = list(start = 0.0, end = 2.0, timeunit = "year"),
 params = list(
   .globals = list(stackName = "landscape", burnStats = "nPixelsBurned"),
   fireSpread = list(.plotInitialTime = NA)
 ),
 modules = list("randomLandscapes", "fireSpread", "caribouMovement"),
 paths = list(modulePath = system.file("sampleModules", package = "SpaDES.core"))
)
outSim <- spades(mySim)

# A little more complicated with inputs and outputs
if (require(rgdal)) {
 mapPath <- system.file("maps", package = "quickPlot")
 mySim <- simInit(
   times = list(start = 0.0, end = 2.0, timeunit = "year"),
   params = list(
     .globals = list(stackName = "landscape", burnStats = "nPixelsBurned")
   ),
   modules = list("randomLandscapes", "fireSpread", "caribouMovement"),
   paths = list(modulePath = system.file("sampleModules", package = "SpaDES.core"),
                outputPath = tempdir()),
   inputs = data.frame(
     files = dir(file.path(mapPath), full.names = TRUE, pattern = "tif")[1:2],
     functions = "raster",
     package = "raster",
     loadTime = 1,
     stringsAsFactors = FALSE),
   outputs = data.frame(
     expand.grid(objectName = c("caribou","landscape"),
     saveTime = 1:2,
     stringsAsFactors = FALSE))
 )

 # Use accessors for inputs, outputs
 mySim2 <- simInit(
   times = list(current = 0, start = 0.0, end = 2.0, timeunit = "year"),
   modules = list("randomLandscapes", "fireSpread", "caribouMovement"),
   params = list(.globals = list(stackName = "landscape", burnStats = "nPixelsBurned")),
   paths = list(
     modulePath = system.file("sampleModules", package = "SpaDES.core"),
     outputPath = tempdir()
   )
 )

 # add by accessor is equivalent
 inputs(mySim2) <- data.frame(
     files = dir(file.path(mapPath), full.names = TRUE, pattern = "tif")[1:2],
     functions = "raster",
     package = "raster",
     loadTime = 1,
     stringsAsFactors = FALSE)
 outputs(mySim2) <- data.frame(
     expand.grid(objectName = c("caribou", "landscape"),
     saveTime = 1:2,
     stringsAsFactors = FALSE))
 all.equal(mySim, mySim2) # TRUE

 # Use accessors for times -- does not work as desired because times are
 #   adjusted to the input timeunit during simInit
 mySim2 <- simInit(
   params = list(
     .globals = list(stackName = "landscape", burnStats = "nPixelsBurned")
   ),
   modules = list("randomLandscapes", "fireSpread", "caribouMovement"),
   paths = list(modulePath = system.file("sampleModules", package = "SpaDES.core"),
                outputPath = tempdir()),
   inputs = data.frame(
     files = dir(file.path(mapPath), full.names = TRUE, pattern = "tif")[1:2],
     functions = "raster",
     package = "raster",
     loadTime = 1,
     stringsAsFactors = FALSE),
   outputs = data.frame(
     expand.grid(objectName = c("caribou","landscape"),
     saveTime = 1:2,
     eventPriority = c(0,10), # eventPriority 0 may give "initial" conditions
     stringsAsFactors = FALSE))
 )

 # add times by accessor fails all.equal test because "year" was not
 #   declared during module loading, so month became the default
 times(mySim2) <- list(current = 0, start = 0.0, end = 2.0, timeunit = "year")
 all.equal(mySim, mySim2) # fails because time units are all different, so
                          # several parameters that have time units in
                          # "months" because they were loaded that way
 params(mySim)$fireSpread$.plotInitialTime
 params(mySim2)$fireSpread$.plotInitialTime
 events(mySim) # load event is at time 1 year
 events(mySim2) # load event is at time 1 month, reported in years because of
                #   update to times above
}
}

}
\references{
Matloff, N. (2011). The Art of R Programming (ch. 7.8.3).
            San Francisco, CA: No Starch Press, Inc..
            Retrieved from \url{https://www.nostarch.com/artofr.htm}
}
\seealso{
\code{\link{spades}},
\code{\link{times}}, \code{\link{params}}, \code{\link{objs}}, \code{\link{paths}},
\code{\link{modules}}, \code{\link{inputs}}, \code{\link{outputs}}
}
\author{
Alex Chubaty and Eliot McIntire
}
