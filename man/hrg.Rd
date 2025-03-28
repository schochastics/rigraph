% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hrg.R
\name{hrg}
\alias{hrg}
\title{Create a hierarchical random graph from an igraph graph}
\usage{
hrg(graph, prob)
}
\arguments{
\item{graph}{The igraph graph to create the HRG from.}

\item{prob}{A vector of probabilities, one for each vertex, in the order of
vertex ids.}
}
\value{
\code{hrg()} returns an \code{igraphHRG} object.
}
\description{
\code{hrg()} creates a HRG from an igraph graph. The igraph graph must be
a directed binary tree, with \eqn{n-1} internal and \eqn{n} leaf
vertices. The \code{prob} argument contains the HRG probability labels
for each vertex; these are ignored for leaf vertices.
}
\seealso{
Other hierarchical random graph functions: 
\code{\link{consensus_tree}()},
\code{\link{fit_hrg}()},
\code{\link{hrg-methods}},
\code{\link{hrg_tree}()},
\code{\link{predict_edges}()},
\code{\link{print.igraphHRG}()},
\code{\link{print.igraphHRGConsensus}()},
\code{\link{sample_hrg}()}
}
\concept{hierarchical random graph functions}
\section{Related documentation in the C library}{\href{https://igraph.org/c/html/latest/igraph-HRG.html#igraph_hrg_create}{\code{hrg_create()}}.}

