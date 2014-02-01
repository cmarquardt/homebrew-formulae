#! /usr/bin/env Rscript

# Updating and installing R packages
# ==================================
#
# C. Marquardt, Darmstadt
#
# 07 July 2013
#
# Note: ROracle, if installed with Oracle Instant clients,
#       requires the following:
#
#          export OCI_LIB=$ORACLE_HOME
#          unset ORACLE_HOME
#
#            ...build the package ...
#
#          export ORACLE_HOME=OCI_LIB
#          unset OCI_LIB
#
#       on the shell prior to building. The code below
#       does the same manipulation of environment variables, 
#       assuming that ORACLE_HOME is pointing to the
#       installation place of an Oracle Instant client.


# 1. Environment variables (for the ROracle compilation)
# ------------------------------------------------------

# Note: The following lines are disabled as I don't have Oracle or it's C API installed.

#oracle_home <- Sys.getenv("ORACLE_HOME")
#Sys.setenv(OCI_LIB = oracle_home)
#Sys.unsetenv("ORACLE_HOME")


# 2. Update existing packages
# ---------------------------

update.packages(repos = "http://ftp5.gwdg.de/pub/misc/cran/")


# 3. Install packages from CRAN
# -----------------------------

# Note 1: In the following list, everything after "plyr" is due to dependencies.
# Note 2: The following packages are 'parked' as I currently have not installed
#         the required database backends or C APIs: RMySQL, ROracle

packages <- c("DBI",
              "RSQLite",
              "Hmisc",
              "akima",
              "ctv",
              "locfit",
              "mice",
              "mvoutlier",
              "mvtnorm",
              "robustbase",
              "robust",
              "rrcov",
              "rrcovNA",
              "rrcovHD",
              "Rwave",
              "ggplot2",
              "maps",
              "mapdata",
              "mapproj",
              "EMD",
              "KernSmooth",
              "RUnit",
              "testthat",
              "getopt",
              "optparse",
              "argparse",
              "multicore",
              "ncdf4",
              "knitr",
              "stringr",
              "roxygen2",
              "devtools",
              "lubridate",
              "plyr",
              "colorspace", 
              "rgl", 
              "tensorA", 
              "energy", 
              "car", 
              "RColorBrewer", 
              "dichromat", 
              "munsell", 
              "labeling", 
              "spam", 
              "bitops", 
              "compositions", 
              "robCompositions", 
              "sgeostat", 
              "fit.models", 
              "pcaPP", 
              "norm", 
              "pls", 
              "spls", 
              "digest", 
              "gtable", 
              "reshape2", 
              "scales", 
              "proto", 
              "fields", 
              "evaluate", 
              "formatR", 
              "markdown", 
              "brew", 
              "httr", 
              "RCurl", 
              "memoise", 
              "whisker"
)


install.packages(packages, repos = "http://ftp5.gwdg.de/pub/misc/cran/")


# 4. Install packages from R-forge
# --------------------------------

packages <- c("WRS")

install.packages(packages, repos="http://R-Forge.R-project.org") 


# 5. Reset environment variables
# ------------------------------

# Note: As before, the following lines are commented out as there is no Oracle C-API

#Sys.setenv(ORACLE_HOME = oracle_home)
#Sys.unsetenv("OCI_LIB")
