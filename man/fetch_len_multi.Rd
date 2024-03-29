% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fetch_len.R
\name{fetch_len_multi}
\alias{fetch_len_multi}
\title{Calculate the fetch length for multiple points}
\usage{
fetch_len_multi(
  pts,
  bearings,
  shoreline,
  dmax,
  spread = 0,
  method = "btree",
  projected = FALSE
)
}
\arguments{
\item{pts}{Simple features (sf or sfc) object containing point data.}

\item{bearings}{Vector of bearings, in degrees.}

\item{shoreline}{Simple feature (sf or sfc) object representing the
shoreline, in either line or polygon format.}

\item{dmax}{Maximum value of fetch length, returned if there is no land
within a distance of \code{dmax} from a given bearing.}

\item{spread}{Vector of relative bearings (in degrees) for which
to calculate fetch around each main bearing.}

\item{method}{Whether to use the "btree" (default) or "clip" method.
See below for more details.}

\item{projected}{Deprecated argument, kept for backwards compatibility.}
}
\value{
A matrix of fetch lengths, with one row by point in \code{pts} and
 one column by bearing in \code{bearings}.
}
\description{
\code{fetch_len_multi} provides two methods to efficiently compute fetch length
for multiple points.
}
\details{
With \code{method = "btree"} (default), the fetch calculation for each point only uses
the geometries within the \code{shoreline} layer that intersect with a rectangular
buffer of size \code{dmax} around that point. (The name is based on a previous version
of the function that implemented this method using the \code{gBinarySTRtreeQuery} function
from the rgeos package.)

With \code{method = "clip"}, the \code{shoreline} is clipped to its intersection
with a polygon formed by the union of all the individual points' rectangular buffers.

In both cases, \code{\link{fetch_len}} is then applied to each point,
using only the necessary portion of the shoreline.

Generally, the "clip" method will produce the biggest time savings when
points are clustered within distances less than \code{dmax} (so their
clipping rectangles overlap), whereas the "btree" method will be more
efficient when the shoreline is composed of multiple geometrical objects
and points are distant from each other.
}
\seealso{
\code{\link{fetch_len}} for details on the fetch length computation.
}
