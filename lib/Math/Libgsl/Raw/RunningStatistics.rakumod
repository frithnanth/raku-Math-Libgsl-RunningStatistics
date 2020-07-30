use v6;

unit module Math::Libgsl::Raw::RunningStatistics:ver<0.0.1>:auth<cpan:FRITH>;

use NativeCall;

sub LIB {
  run('/sbin/ldconfig', '-p', :chomp, :out)
    .out
    .slurp(:close)
    .split("\n")
    .grep(/^ \s+ libgsl\.so\. \d+ /)
    .sort
    .head
    .comb(/\S+/)
    .head;
}

class gsl_rstat_quantile_workspace is repr('CStruct') is export {
  has num64   $.p;
  HAS num64   @.q[5] is CArray;
  HAS int32   @.npos[5] is CArray;
  HAS num64   @.np[5] is CArray;
  HAS num64   @.dnp[5] is CArray;
  has size_t  $.n;
}

class gsl_rstat_workspace is repr('CStruct') is export {
  has num64   $.min;
  has num64   $.max;
  has num64   $.mean;
  has num64   $.M2;
  has num64   $.M3;
  has num64   $.M4;
  has size_t  $.n;
  has gsl_rstat_quantile_workspace $.median_workspace_p;
}

sub gsl_rstat_alloc(--> gsl_rstat_workspace) is native(LIB) is export { * }
sub gsl_rstat_free(gsl_rstat_workspace $w) is native(LIB) is export { * }
sub gsl_rstat_reset(gsl_rstat_workspace $w --> int32) is native(LIB) is export { * }
sub gsl_rstat_add(num64 $x, gsl_rstat_workspace $w --> int32) is native(LIB) is export { * }
sub gsl_rstat_n(gsl_rstat_workspace $w --> size_t) is native(LIB) is export { * }
sub gsl_rstat_min(gsl_rstat_workspace $w --> num64) is native(LIB) is export { * }
sub gsl_rstat_max(gsl_rstat_workspace $w --> num64) is native(LIB) is export { * }
sub gsl_rstat_mean(gsl_rstat_workspace $w --> num64) is native(LIB) is export { * }
sub gsl_rstat_variance(gsl_rstat_workspace $w --> num64) is native(LIB) is export { * }
sub gsl_rstat_sd(gsl_rstat_workspace $w --> num64) is native(LIB) is export { * }
sub gsl_rstat_sd_mean(gsl_rstat_workspace $w --> num64) is native(LIB) is export { * }
sub gsl_rstat_rms(gsl_rstat_workspace $w --> num64) is native(LIB) is export { * }
sub gsl_rstat_skew(gsl_rstat_workspace $w --> num64) is native(LIB) is export { * }
sub gsl_rstat_kurtosis(gsl_rstat_workspace $w --> num64) is native(LIB) is export { * }
sub gsl_rstat_median(gsl_rstat_workspace $w --> num64) is native(LIB) is export { * }
sub gsl_rstat_quantile_alloc(num64 $p --> gsl_rstat_quantile_workspace) is native(LIB) is export { * }
sub gsl_rstat_quantile_free(gsl_rstat_quantile_workspace $w) is native(LIB) is export { * }
sub gsl_rstat_quantile_reset(gsl_rstat_quantile_workspace $w --> int32) is native(LIB) is export { * }
sub gsl_rstat_quantile_add(num64 $x, gsl_rstat_quantile_workspace $w --> int32) is native(LIB) is export { * }
sub gsl_rstat_quantile_get(gsl_rstat_quantile_workspace $w --> num64) is native(LIB) is export { * }
