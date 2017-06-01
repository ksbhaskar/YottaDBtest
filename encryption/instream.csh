#!/usr/local/bin/tcsh -f
#################################################################
#								#
# Copyright (c) 2013-2016 Fidelity National Information		#
# Services, Inc. and/or its subsidiaries. All rights reserved.	#
#								#
#	This source code contains the intellectual property	#
#	of its copyright holder(s), and is made available	#
#	under a license.  If you do not know the terms of	#
#	the license, please stop and do not read further.	#
#								#
#################################################################
#
#-------------------------------------------------------------------------------------
# C9A05-001476  Test cases for Encryption Changes
#-------------------------------------------------------------------------------------
# badpasswd			[s7rs]		Test all possible values for gtm_passwd environment variable ie; null value, bad passphrase, unset gtm_passwd env variable.
# badpasswd_manual		[s7rs]		To validate prompting of password by mumps when gtm_passwd is set to null.
# change_database_keys		[s7rs]		Verify that when the keys for database files are changed, the new keys are used to create the new databases.
# dse_enc			[s7rs]		Verify the dse functionality for restoring the hash for database using corresponding key file. Command : dse change -file -encryption_hash.
# encryption_check		[s7rs]		Test to verify whether the database has been encrypted or not.
# error_messages		[s7rs]		Test all the possible error messages from gtmcrypt library.
# extract_load			[s7rs]		Test whether encryption binaries can load database extracts generated by prior version of GTM.
# gde_enc			[s7rs]		Test to check GDE command for setting encryption status.
# gtmdbkeys_enc			[s7rs]		Verify that the db key file (via gtmdbkeys) can be found in all valid locations.
# gtmpasswd			[s7rs]		Verify that passwords can be used up to the maximum length of characters.
# hash_verification		[s7rs]		Validate the correctness of hash in database file by comparing it with one generated by GPG.
# header_verify			[s7rs]		Validate the encryption related fields added in jnl and database file header.
# key_file_enc			[s7rs]		To test all possible error messages related to database key file. Egs: Key file not found, Key file doesnot have proper access permission, empty key file, etc.
# mangled_entry_in_mapfile	[s7rs]		Test for valid entry and format for mapping file.
# mu_bkuprestore_enc		[s7rs]		Test whether encryption binaries can  perform mupip restore operation for back-ups generated by prior version of GTM.
# mu_extract_enc		[s7rs]		Test mupip load and extract operations between encrypted and un-encrypted databases.
# mu_integ_enc			[s7rs]		To test all possible error messages reported by gtmcrypt library related to Mupip Integ.
# exp_test			[s7kr]		To verify that all possible states of gtm_passwd is handled both inside and outside of GT.M.
# gpghome_perms			[s7kr]		To verify that encryption plugin issues proper error message when user without proper permissions for gpghome accessess the database.
# err_mu_extract		[s7kr]		Test case for mupip extract behaviors without gtm_passwd.
# err_mu_backup			[s7kr]		Test case for mupip backup behaviors without gtm_passwd.
# err_mu_freeze			[s7kr]		Test case for mupip freeze behaviors without gtm_passwd.
# err_mu_journal		[s7kr]		Test case for mupip journal extract and show behaviors without gtm_passwd.
# err_mu_restore		[s7kr]		Test case for mupip restore behaviors without gtm_passwd.
# err_mu_load			[s7kr]		Test case for mupip binary load behaviors without gtm_passwd.
# err_mu_rundown		[s7kr]		Test case for mupip rundown behaviors without gtm_passwd.
# err_dse_check			[s7kr]		Test case for dse behaviors with incorrect encryption environment.
# err_mu_misc			[s7kr]		Test case for mupip endiancvt, integ, extend and reorg behaviors without gtm_passwd.
# err_mu_recover		[s7kr]		Test case for mupip recover behaviors without gtm_passwd.
# err_mu_rollback		[s7kr]		Test case for mupip rollback behaviors without gtm_passwd.
# err_maskpass			[s7kk]		Check if maskpass executable works in all kinds of erroneous user environment.
# encr_env			[SOPINI]	Check various environment configurations.
# key_management		[SOPINI]	Exercise different key management scenarios.
# sym_key_management		[SOPINI]	Ensure validation of symmetric key properties.
# device_encryption		[SOPINI]	Exercise different aspects of device encryption.
# file_access			[NITINM]	Test accessibility/validity of configuration file, obfuscation file, symmetric key file, and keyring file.
# memory_leak			[SOPINI]	Ensure that the encryption plug-in does not have any memory leaks.
# ioerr				[SOPINI]	Test intricate I/O-specific situations.
# gtm_dist_utf			[SOPINI]	Verify that the UTF-specific $gtm_dist path can be used with encryption.
# iv_ops			[SOPINI]	Test the operation of various commands in regards to different IV modes.
# gtm7936			[NARS]		Test DSE CACHE -SHOW lists encrypted global buffer section
# helper_scripts 		[s7kk/kishore]	Test encryption helper scripts
#
# Encryption on-the-fly (EOTF) tests:
# eotf_basic			[SOPINI]	Test basic stand-along (re)encryption.
# eotf_errors			[SOPINI]	Validate various (re)encryption-specific errors.
# eotf_concur			[SOPINI]	Test online (re)encryption on a prefilled database.
# eotf_resume			[SOPINI]	Test the resume functionality of encryption-on-the-fly.
# eotf_backup			[SOPINI]	Test the backup functionality against concurrent (re)encryption.
# eotf_recover			[SOPINI]	Test journal-based recovery against database (re)encryption.
# eotf_misc			[KISHORE]	Miscellaneous encryption-on-the-fly test cases.

setenv acc_meth BG		# MM and encryption is not supported
setenv test_encryption ENCRYPT
setenv gtm_test_set_encryptable	0	# since this is encryption specific test, do not randomly set encryptable

# If encryption environment is not already set, do it now
if !(-e $tst_general_dir/encrypt_env_settings.csh) then
	source $gtm_tst/com/set_encrypt_env.csh $tst_general_dir $gtm_dist $tst_src >>! $tst_general_dir/set_encrypt_env.log
	# If there is an encryption setup issue, set_encrypt_env.csh will set $test_encryption to "NON_ENCRYPT".
	# In that case exit immediately. No point continuing.
	if ("NON_ENCRYPT" == "$test_encryption") then
		exit 1
	endif
	echo "# Encryption algorithm and library set by encryption/instream.csh"	>>! $tst_general_dir/settings.csh
	source $gtm_tst/com/set_encryption_lib_and_algo.csh 				>>! $tst_general_dir/settings.csh
endif

echo "encryption test starts..."
setenv subtest_list_common	""
setenv subtest_list_non_replic  "badpasswd badpasswd_manual change_database_keys dse_enc encryption_check error_messages"
setenv subtest_list_non_replic	"$subtest_list_non_replic extract_load gde_enc  gtmdbkeys_enc gtmpasswd hash_verification"
setenv subtest_list_non_replic	"$subtest_list_non_replic header_verify key_file_enc mangled_entry_in_mapfile mu_bkuprestore_enc"
setenv subtest_list_non_replic	"$subtest_list_non_replic mu_extract_enc mu_integ_enc exp_test gpghome_perms"
setenv subtest_list_non_replic	"$subtest_list_non_replic err_mu_extract err_mu_backup err_mu_freeze err_mu_journal err_mu_restore"
setenv subtest_list_non_replic	"$subtest_list_non_replic err_mu_load err_mu_rundown err_dse_check err_mu_misc err_mu_recover"
setenv subtest_list_non_replic	"$subtest_list_non_replic err_maskpass encr_env key_management sym_key_management"
setenv subtest_list_non_replic	"$subtest_list_non_replic file_access memory_leak ioerr device_encryption iv_ops gtm_dist_utf gtm7936 helper_scripts"

setenv subtest_list_replic	"err_mu_replic err_mu_rollback"

# Encryption on-the-fly (EOTF) tests:
setenv subtest_list_non_replic	"$subtest_list_non_replic eotf_basic eotf_errors eotf_concur eotf_resume eotf_backup eotf_recover eotf_misc"

if ($?test_replic == 1) then
	setenv subtest_list "$subtest_list_common $subtest_list_replic"
else
	setenv subtest_list "$subtest_list_common $subtest_list_non_replic"
endif

setenv subtest_exclude_list ""

# On z/OS, we don't have 'expect' program to automate interactive tasks. So, disable gtmpasswd and exp_test subtests.
if ("os390" == $gtm_test_osname) then
	setenv subtest_exclude_list "$subtest_exclude_list exp_test"
endif

# On any system with gpg2 gtmpasswd subtest needs to be disabled because proper connection to the gpg-agent during the passphrase-
# changing procedure cannot be established when submitting a test remotely.
if (20000 <= $gtm_gpg_exact_version) then
	setenv subtest_exclude_list "$subtest_exclude_list gtmpasswd"
endif

set shorthost = $HOST:r:r:r

# The memory_leak test is too stressful for slower boxes.
if (($shorthost =~ "inti") || ($shorthost =~ "atlst2000")) then
	setenv subtest_exclude_list "$subtest_exclude_list memory_leak"
endif

# The extract_load test needs a 32-bit version, which these hosts don't have.
if ($shorthost =~ {scylla,charybdis,bolt}) then
	setenv subtest_exclude_list "$subtest_exclude_list extract_load"
endif

# from version 1.0.1h, OpenSSL added a check on the length for the Blowfish cipher.
# The current key size (256 bits) is longer than the keysize Blowfish and RC5 algorithms use (128 bits)
# The subtests that sets encryption algorithms randomly handle this > 1.0.1h scenario by not chosing bf-cfb in that case
# iv_ops subtest does a version switch which forces BLOWFISH on AIX servers. Hence disable the subtest on sphere that has OpenSSL 1.0.2d
if ($shorthost =~ {sphere}) then
	setenv subtest_exclude_list "$subtest_exclude_list iv_ops"
endif

# The below is a test for gen_keypair.sh. It is okay to run just for one image. Also it takes a long time on solaris (no need to test there)
if (("dbg" == "$tst_image") || ("HOST_SUNOS_SPARC" == "$gtm_test_os_machtype")) then
	setenv subtest_exclude_list "$subtest_exclude_list helper_scripts"
endif

# The sylog on solaris servers prints "last message repeated 1 time" when it sees two identical GTM-I-NEWJNLFILECREAT messages.
# Exclude the subtest on solaris (since it is no longer supported), but if we see this on other servers, it needs some work
if ("HOST_SUNOS_SPARC" == "$gtm_test_os_machtype") then
	setenv subtest_exclude_list "$subtest_exclude_list eotf_basic"
endif

# od output on atlhxit1 seem to vary based on "unencrypted" randomness in the test
if ("HOST_HP-UX_IA64" == "$gtm_test_os_machtype") then
	setenv subtest_exclude_list "$subtest_exclude_list eotf_backup"
endif

if ($?gtm_test_temporary_disable) then
       setenv subtest_exclude_list "$subtest_exclude_list extract_load gpghome_perms err_maskpass encr_env iv_ops helper_scripts eotf_basic"
endif

setenv GNUPGHOME	"$tst_working_dir/.gnupg"
setenv gtm_pubkey	"$tst_working_dir/pubkey.asc"
setenv gtm_com_gnupg	"$gtm_com/gnupg"

if ((-d $gtm_com_gnupg) && (-f $gtm_com_gnupg/gtm@fnis.com_pubkey.txt)) then
	if (-e $GNUPGHOME) rm -rf $GNUPGHOME
	cp -L -r $gtm_com_gnupg $GNUPGHOME
	# -r required for the -L option on HP-UX even if the source is not a directory.
	cp -L -rf $gtm_com_gnupg/gtm@fnis.com_pubkey.txt $gtm_pubkey
	$gtm_tst/com/submit_subtest.csh
else
	echo "TEST-E-NOKEY, Either $gtm_com_gnupg or $gtm_com_gnupg/gtm@fnis.com_pubkey.txt does not exist. Not submitting tests."
	echo 'Please, fix this by running $cms_tools/build_gnupghome.csh as library on this box using an appropriate version.'
endif

# Kill the gpg-agent deamon if one was left out by the test.
$gtm_tst/com/reset_gpg_agent.csh

echo "encryption test DONE."
