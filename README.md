Homebrew formulae
=================

These formulae provide software tailored to my homebrew installation. The currently available formulae are:

 - `sofa.rb`: Standards of Fundamental Astronomy (SOFA) library - C version
 - `sofa-fortran.rb`: Standards of Fundamental Astronomy (SOFA) library - Fortran version
 - `eugene.rb`: EUMETSAT Polar System (EPS) data format library and python interface
 - `eccodes-cm.rb`: Decode and encode messages in the GRIB 1/2 and BUFR 3/4 formats, with netcdf, static libraries and Python 2 interfaces
 - `python@2.rb`: Python legacy version v2.7
 - `python-packages.rb`: 

Note that several of these formulae are *not* consistent with Homebrew's best practices.

How to install these formulae?
------------------------------

Just `brew tap cmarquardt/formulae` and then `brew install <formula>`.

If the formula conflicts with one from another tap, one can `brew install cmarquardt/formulae/<formula>`.

One can also install via a URL:

    brew install https://raw.github.com/cmarquardt/homebrew-formulae/master/<formula>.rb


Docs
----
`brew help`, `man brew`, and the [Homebrew web page][].

[Homebrew web page]:https://brew.sh/
