Homebrew formulae
=================

These formulae provide software tailored to my homebrew installation. The currently available formulae are:

 - `sofa.rb`:
 - `sofa-fortran.rb`:
 - `eugene.rb`:
 - `eccodes-cm.rb`:
 - `python@2.rb`:
 - `python-packages.rb`:
 - `r-packages.rb`:

All python packages are installed via pip(2) - yes, I'm still on Python 2. That's why I'm maintaining the `python@2.rb` formula. Right now, it's simply the last available version before it was removed from Homebrew core. Note that even numpy and scipy for python 2 are supposed to be maintained via pip - there are no formula for them.

Note that several of these formulae are *not* consistent with Homebrew's best practices: They download additional software (e.g., R and python packages) and provide scripts which can be used to update existing installations of these packages or modules.

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
