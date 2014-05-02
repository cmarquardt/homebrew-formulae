Homebrew formulae
=================

These formulae provide software tailored to my homebrew installation. Right now, they bundle some packages for R and python for easier installation.

Note that these formulae are *not* consistent with Homebrew's best practices as they download additional software (R and python packages) and provide scripts which can be used to update the latter.

How to install these formulae?
------------------------------

Just `brew tap cmarquardt/formulae` and then `brew install <formula>`.

If the formula conflicts with one from mxcl/master or another tap, one can `brew install cmarquardt/formula/<formula>`.

One can also install via a URL:

    brew install https://raw.github.com/cmarquardt/homebrew-formulae/master/<formula>.rb


Docs
----
`brew help`, `man brew`, and the Homebrew [wiki][].

[wiki]:http://wiki.github.com/mxcl/homebrew

