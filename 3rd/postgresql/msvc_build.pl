# -*-perl-*- hey - emacs - this is a perl file

# src/tools/msvc/build.pl

use strict;

use File::Basename;
use File::Spec;
BEGIN { use lib File::Spec->rel2abs(dirname(__FILE__)); }

use Cwd;

use Mkvcbuild;

chdir('..\..\..') if (-d '..\msvc' && -d '..\..\..\src');
die 'Must run from root or msvc directory'
  unless (-d 'src\tools\msvc' && -d 'src');

# buildenv.pl is for specifying the build environment settings
# it should contain lines like:
# $ENV{PATH} = "c:/path/to/bison/bin;$ENV{PATH}";

if (-e "src/tools/msvc/buildenv.pl")
{
	do "./src/tools/msvc/buildenv.pl";
}
elsif (-e "./buildenv.pl")
{
	do "./buildenv.pl";
}

# set up the project
our $config;
do "./src/tools/msvc/config_default.pl";
do "./src/tools/msvc/config.pl" if (-f "src/tools/msvc/config.pl");

my $vcver = Mkvcbuild::mkvcbuild($config);

# check what sort of build we are doing

my $bconf     = $ENV{CONFIG}   || "Release";
my $msbflags  = $ENV{MSBFLAGS} || "";
my $buildwhat = $ARGV[1]       || "";
my $msbuildcmd = "msbuild pgsql.sln /verbosity:normal $msbflags /p:Configuration=$bconf";

if (uc($ARGV[0]) eq 'DEBUG')
{
	$bconf = "Debug";
}
elsif (uc($ARGV[0]) ne "RELEASE")
{
	$buildwhat = $ARGV[0] || "";
}

# ... and do it

if ($buildwhat)
{
	system(
		"msbuild $buildwhat.vcxproj /verbosity:normal $msbflags /p:Configuration=$bconf"
	);
}
else
{
   if ($ENV{'BUILD_ARCH'} == "x86") {
               $msbuildcmd  = "msbuild pgsql.sln /verbosity:normal $msbflags /p:Configuration=$bconf /p:Platform=Win32";
   }
   system( $msbuildcmd );
}

# report status

my $status = $? >> 8;

exit $status;
