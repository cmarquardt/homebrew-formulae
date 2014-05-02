#! /usr/bin/env Rscript

# Updating R packages
# ===================
#
# C. Marquardt, Darmstadt
#
# 02 February 2014
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

update.packages(ask = FALSE, repos = "http://ftp5.gwdg.de/pub/misc/cran/")
# update.packages(repos = c("http://ftp5.gwdg.de/pub/misc/cran/", "http://R-Forge.R-project.org"))


# 5. Reset environment variables
# ------------------------------

# Note: As before, the following lines are commented out as there is no Oracle C-API

#Sys.setenv(ORACLE_HOME = oracle_home)
#Sys.unsetenv("OCI_LIB")
