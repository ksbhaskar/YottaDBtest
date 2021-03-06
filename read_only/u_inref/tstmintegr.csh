#!/usr/local/bin/tcsh -f
# Integ test /file
echo ""
echo "*** TSTMINTEGR.CSH ***"
echo ""
set verbose


echo ""
echo "First with no journal"
echo ""
$gtm_tst/com/dbcreate.csh mumps $1
$GTM << bbb
w "Do in0^sfill(""set"",1,$1)",!
d in0^sfill("set",1,$1)
h
bbb
chmod 666 b.dat
$MUPIP integ -FAST -reg "*" >& integr.out1
egrep "GTM-E|No errors" integr.out1
mipcmanage
$MUPIP integ -reg "*" >& integr.out2
egrep "GTM-E|No errors" integr.out2
mipcmanage

echo "***** b.dat R/O *****"
chmod 444 b.dat
$MUPIP integ -FAST -reg "*" >& integr.out3
egrep "GTM-E|No errors" integr.out3
mipcmanage
$MUPIP integ -reg "*" >& integr.out4
egrep "GTM-E|No errors" integr.out4
mipcmanage
\rm -f *.dat

echo ""
echo "Now with journal"
echo ""
$gtm_tst/$tst/u_inref/create_multi_jnl_db.csh $1
$GTM << bbb
w "Do in0^sfill(""set"",1,$1)",!
d in0^sfill("set",1,$1)
h
bbb
chmod 666 b.dat b.mjl

echo "***** *.dat R/W *.mjl R/W *****"
$MUPIP integ -FAST -reg "*" >& integr.out5
egrep "GTM-E|No errors" integr.out5
mipcmanage
$MUPIP integ -reg "*" >& integr.out6
egrep "GTM-E|No errors" integr.out6
mipcmanage

echo "***** b.dat R/W b.mjl R/O *****"
chmod 666 b.dat
chmod 444 b.mjl
$MUPIP integ -FAST -reg "*" >& integr.out7
egrep "GTM-E|No errors" integr.out7
mipcmanage
$MUPIP integ -reg "*" >& integr.out8
egrep "GTM-E|No errors" integr.out8
mipcmanage

echo "***** b.dat R/O b.mjl R/W *****"
chmod 444 b.dat
chmod 666 b.mjl
$MUPIP integ -FAST -reg "*" >& integr.out9
egrep "GTM-E|No errors" integr.out9
mipcmanage
$MUPIP integ -reg "*" >& integr.out10
egrep "GTM-E|No errors" integr.out10
mipcmanage

echo "***** b.dat R/O b.mjl R/O *****"
chmod 444 b.dat
chmod 444 b.mjl
$MUPIP integ -FAST -reg "*" >& integr.out11
egrep "GTM-E|No errors" integr.out11
mipcmanage
$MUPIP integ -reg "*" >& integr.out12
egrep "GTM-E|No errors" integr.out12
mipcmanage
chmod 666 *.dat *.mjl
$gtm_tst/com/dbcheck.csh
\rm -f *.dat *.mjl mumps.gld
