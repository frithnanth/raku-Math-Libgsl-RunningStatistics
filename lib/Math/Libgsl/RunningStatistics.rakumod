unit class Math::Libgsl::RunningStatistics:ver<0.0.2>:auth<zef:FRITH>;

use Math::Libgsl::Raw::RunningStatistics;
use Math::Libgsl::Constants;
use NativeCall;

has gsl_rstat_workspace           $.w;
has gsl_rstat_quantile_workspace  @.q;

submethod BUILD(:@quantile = 0.5,) {
  $!w = gsl_rstat_alloc;
  for @quantile -> $q {
    my num64 $quant = $q.Num;
    @!q.push: gsl_rstat_quantile_alloc($quant);
  }
}

submethod DESTROY {
  gsl_rstat_free($!w);
  for @!q -> $q {
    gsl_rstat_quantile_free($q);
  }
}

method reset(--> Int) { gsl_rstat_reset($!w) }
method add(Num() $x --> Int) { gsl_rstat_add($x, $!w) }
method n(--> Int) { gsl_rstat_n($!w) }
method min(--> Num) { gsl_rstat_min($!w) }
method max(--> Num) { gsl_rstat_max($!w) }
method mean(--> Num) { gsl_rstat_mean($!w) }
method variance(--> Num) { gsl_rstat_variance($!w) }
method sd(--> Num) { gsl_rstat_sd($!w) }
method sd-mean(--> Num) { gsl_rstat_sd_mean($!w) }
method rms(--> Num) { gsl_rstat_rms($!w) }
method skew(--> Num) { gsl_rstat_skew($!w) }
method kurtosis(--> Num) { gsl_rstat_kurtosis($!w) }
method median(--> Num) { gsl_rstat_median($!w) }
method qadd(Num() $x --> Int) {
  for @!q -> $q {
    my $res = gsl_rstat_quantile_add($x, $q);
    return $res if $res != GSL_SUCCESS;
  }
  return GSL_SUCCESS;
}
method qget(--> List) {
  my @res;
  for @!q -> $q {
    @res.push: gsl_rstat_quantile_get($q);
  }
  return @res;
}
method qreset(--> Int) {
  for @!q -> $q {
    my $res = gsl_rstat_quantile_reset($q);
    return $res if $res != GSL_SUCCESS;
  }
  return GSL_SUCCESS;
}

=begin pod

=head1 NAME

Math::Libgsl::RunningStatistics - An interface to libgsl, the Gnu Scientific Library - Running Statistics

=head1 SYNOPSIS

=begin code :lang<raku>

use Math::Libgsl::RunningStatistics;

my Math::Libgsl::RunningStatistics $r .= new;
$r.add($_) for (^10);
say $r.mean;
say $r.variance;
say $r.sd;

=end code

=head1 DESCRIPTION

Math::Libgsl::RunningStatistics is an interface to the Running Statistics functions of libgsl, the Gnu Scientific Library.

This class is suitable for handling large datasets for which it may be inconvenient or impractical to store in memory all at once.

=head3 new(:@quantile = 0.5,)

The constructor accepts one optional parameter, the quantile array, which defaults to just one value: 0.5 i.e. the median.
The @quantile argument will be used only if one uses the quantile methods.

=head3 add(Num() $x --> Int)

This method adds a value to the accumulator. It returns GSL_SUCCESS if successful.

=head3 n(--> Int)

This method returns the number of data added so far to the accumulator.

=head3 min(--> Num)

This method returns the minimum value added to the accumulator.

=head3 max(--> Num)

This method returns the maximum value added to the accumulator.

=head3 mean(--> Num)

This method returns the mean of all data added to the accumulator.

=head3 variance(--> Num)

This method returns the variance of all data added to the accumulator.

=head3 sd(--> Num)

This method returns the standard deviation of all data added to the accumulator.

=head3 sd-mean(--> Num)

This method returns the standard deviation of the mean.

=head3 rms(--> Num)

This method returns the root mean square of all data added to the accumulator.

=head3 skew(--> Num)

This method returns the skewness of all data added to the accumulator.

=head3 kurtosis(--> Num)

This method returns the kurtosis of all data added to the accumulator.

=head3 median(--> Num)

This method returns the median of all data added to the accumulator.

=head3 reset(--> Int)

This method resets the accumulator.

=head3 qadd(Num() $x --> Int)

This method adds a value to the quantile accumulators.
It returns GSL_SUCCESS if successful. If not successful it returns the first error found and the accumulators are left in an undefined state, so you're advised to .qreset() them.

=head3 qget(Num() $x --> List)

This method returns a List of all the current estimate of the quantiles specified when the object was created.

=head3 qreset(--> Int)

This method resets the quantile accumulators.
It returns GSL_SUCCESS if successful. If not successful it returns the first error found.

=head1 C Library Documentation

For more details on libgsl see L<https://www.gnu.org/software/gsl/>.
The excellent C Library manual is available here L<https://www.gnu.org/software/gsl/doc/html/index.html>, or here L<https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf> in PDF format.

=head1 Prerequisites

This module requires the libgsl library to be installed. Please follow the instructions below based on your platform:

=head2 Debian Linux and Ubuntu 20.04+

=begin code
sudo apt install libgsl23 libgsl-dev libgslcblas0
=end code

That command will install libgslcblas0 as well, since it's used by the GSL.

=head2 Ubuntu 18.04

libgsl23 and libgslcblas0 have a missing symbol on Ubuntu 18.04.
I solved the issue installing the Debian Buster version of those three libraries:

=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb>
=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb>
=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb>

=head1 Installation

To install it using zef (a module management tool):

=begin code
$ zef install Math::Libgsl::RunningStatistics
=end code

=head1 AUTHOR

Fernando Santagata <nando.santagata@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2020 Fernando Santagata

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
