[![Build Status](https://travis-ci.org/frithnanth/raku-Math-Libgsl-RunningStatistics.svg?branch=master)](https://travis-ci.org/frithnanth/raku-Math-Libgsl-RunningStatistics)
[![Actions Status](https://github.com/frithnanth/raku-Math-Libgsl-RunningStatistics/workflows/test/badge.svg)](https://github.com/frithnanth/raku-Math-Libgsl-RunningStatistics/actions)

NAME
====

Math::Libgsl::RunningStatistics - An interface to libgsl, the Gnu Scientific Library - Running Statistics

SYNOPSIS
========

```raku
use Math::Libgsl::RunningStatistics;

my Math::Libgsl::RunningStatistics $r .= new;
$r.add($_) for (^10);
say $r.mean;
say $r.variance;
say $r.sd;
```

DESCRIPTION
===========

Math::Libgsl::RunningStatistics is an interface to the Running Statistics functions of libgsl, the Gnu Scientific Library.

This class is suitable for handling large datasets for which it may be inconvenient or impractical to store in memory all at once.

### new(Num() :$percentile = 0.5)

The constructor accepts one optional parameter, the percentile, which defaults to 0.5 i.e. the median. The $percentile argument will be used only if one uses the percentile methods.

### add(Num() $x --> Int)

This method adds a value to the accumulator. It returns GSL_SUCCESS if successful.

### n(--> Int)

This method returns the number of data added so far to the accumulator.

### min(--> Num)

This method returns the minimum value added to the accumulator.

### max(--> Num)

This method returns the maximum value added to the accumulator.

### mean(--> Num)

This method returns the mean of all data added to the accumulator.

### variance(--> Num)

This method returns the variance of all data added to the accumulator.

### sd(--> Num)

This method returns the standard deviation of all data added to the accumulator.

### sd-mean(--> Num)

This method returns the standard deviation of the mean.

### rms(--> Num)

This method returns the root mean square of all data added to the accumulator.

### skew(--> Num)

This method returns the skewness of all data added to the accumulator.

### kurtosis(--> Num)

This method returns the kurtosis of all data added to the accumulator.

### median(--> Num)

This method returns the median of all data added to the accumulator.

### reset(--> Int)

This method resets the accumulator.

### qadd(Num() $x --> Int)

This method adds a value to the quantile accumulator. It returns GSL_SUCCESS if successful.

### qget(Num() $x --> Int)

This method returns the current estimate of the quantile specified when the object was created.

### qreset(--> Int)

This method resets the quantile accumulator.

C Library Documentation
=======================

For more details on libgsl see [https://www.gnu.org/software/gsl/](https://www.gnu.org/software/gsl/). The excellent C Library manual is available here [https://www.gnu.org/software/gsl/doc/html/index.html](https://www.gnu.org/software/gsl/doc/html/index.html), or here [https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf](https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf) in PDF format.

Prerequisites
=============

This module requires the libgsl library to be installed. Please follow the instructions below based on your platform:

Debian Linux and Ubuntu 20.04
-----------------------------

    sudo apt install libgsl23 libgsl-dev libgslcblas0

That command will install libgslcblas0 as well, since it's used by the GSL.

Ubuntu 18.04
------------

libgsl23 and libgslcblas0 have a missing symbol on Ubuntu 18.04. I solved the issue installing the Debian Buster version of those three libraries:

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb)

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb)

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb)

Installation
============

To install it using zef (a module management tool):

    $ zef install Math::Libgsl::RunningStatistics

AUTHOR
======

Fernando Santagata <nando.santagata@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2020 Fernando Santagata

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

