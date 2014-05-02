# configure.ac for R-packages
# ===========================

# 1. Initialisation
# -----------------

AC_INIT(R-packages, 0.1, christian@marquardt.sc)
AC_CONFIG_SRCDIR(R-packages-update)

AM_INIT_AUTOMAKE(foreign)

AC_CANONICAL_HOST

# 2. Check for programs
# ---------------------

AC_PATH_PROG(SHELL, bash)
if test -z "$BASH"; then
   AC_MSG_ERROR([bash not found])
fi

AC_PATH_PROG(RSCRIPT, Rscript)
if test -z "$RSCRIPT"; then
   AC_MSG_ERROR([Rscript not found])
fi

# 3. Finish
# ---------

AC_CONFIG_FILES(Makefile)

AC_OUTPUT
