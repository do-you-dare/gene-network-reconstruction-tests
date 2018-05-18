source("iota/IOTA.R")
library("igraph")

# Reads the data
raw_data <- read.csv("data.csv", sep = ";")

data <- raw_data[, -1]
rownames(data) <- raw_data[, 1]

a <- IOTA(data, method = "sqrt")
diag(a) <- 0 # Self regulation isn't taken in account

# This is the actual network. By now, I'm treating all
# correlations equally
n <- graph_from_adjacency_matrix(a > .95 | a < -.95,
                                 mode = c("directed"))

clusters     <- components(n, mode = c("strong"))
connectivity <- vertex_connectivity(n, checks = FALSE)

# Which one should I use?
centrality <- centr_degree(n)$centralization
#centrality <- eigen_centrality(n)$value

puts <- function(...) cat(paste(..., "\n"))
#puts("Degree          : ", degree(n, mode=c("all")))
puts("Connectivity    : ", connectivity)
puts("Clusters        : ", clusters$no)
puts("Centralization  : ", centrality)
