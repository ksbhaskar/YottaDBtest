# circalname.csh
# 
setenv GTMCI errors.tab
cat >> $GTMCI << errtab
    :  void ^bldrecs()
errtab

$gt_cc_compiler $gt_cc_options_common $gtm_tst/$tst/inref/gtmci_tberrs.c -I$gtm_dist
$gt_ld_linker $gt_ld_option_output cclerr $gt_ld_options_common gtmci_tberrs.o $gt_ld_sysrtns $ci_ldpath$gtm_dist -L$gtm_dist $tst_ld_gtmshr $gt_ld_syslibs >& link.map

if( $status != 0 ) then
    cat link.map
endif
rm -f  link.map



