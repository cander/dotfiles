#
#	Try to figure out what kind of machine we're running on.  Set
#	PATH accordingly
#
if [ `uname` = "FreeBSD" ]
then
    echo "Running under FreeBSD"
    MACHTYPE="i386"
    OSTYPE="freebsd"
    PATH=.:$genpath:/sbin:/usr/sbin:/usr/X11R6/bin
    MACH_PATH_HEAD=.
    MACH_PATH_TAIL=/sbin:/usr/sbin:/usr/X11R6/bin
elif [ `uname` = "Darwin" ]
then
    echo "Running under Darwin"
    MACHTYPE="ppc"
    OSTYPE="freebsd"
    MACH_PATH_HEAD=.
    MACH_PATH_TAIL=""
    MANPATH=/usr/share/man
elif [ "$OSTYPE" = "linux" -o "$OSTYPE" = "Linux" ]
then
    echo "Running under Linux"
    MACHTYPE="i386"
    OSTYPE="linux"
    MACH_PATH_HEAD=.
    MACH_PATH_TAIL=/usr/X11R6/bin:/usr/local/java/bin:/home/ford/cander/bin
elif [ -f /proc/$$ ]
then
    echo "Running under SVR4"
    MACHTYPE="svr4"
    OSTYPE="svr4"
    MACH_PATH_HEAD=.
    MACH_PATH_TAIL=.:$genpath:/usr/sbin:/sbin:/usr/ccs/bin:/usr/openwin/bin
    alias hostname='uname -n'
elif [ -f /etc/autoconfig -a -c /dev/rfloppy0 ]
then
    echo "Running under A/UX"
    MACHTYPE="mac"
    PATH=.:~/macbin:$genpath
    OSTYPE="aux"
elif sun > /dev/null 2>&1
then
    if [ -f /usr/bin/sun ]
    then
	echo "Running under SunOS 4.0"
	MACHTYPE="sun"
	OSTYPE="sunOS4"
	PATH=.:~/sun4bin:$genpath:/usr/sbin:/sbin:/usr/X11/bin
    elif [ -f /bin/sun ]
    then
	echo "Running under SunOS 3.x"
	MACHTYPE="sun"
	OSTYPE="sunOS3"
	PATH=.:~/sun3bin:$genpath:/usr/X11/bin
    else
	echo "What kind of machine has /dev/eeprom and is not a Sun?"
	PATH=.:$genpath:/usr/sbin:/sbin
    fi
elif [ -d /usr/.attbin ]
then
    echo "Running on a Pyramid"
    MACHTYPE="pyramid"
    OSTYPE="pyramid"
    PATH=.:~/pyrbin:$genpath:/.attbin:/usr/.attbin:/usr/local/dvbin
elif [ -f /hp-ux ]
then
    echo "Running under HP-UX"
    MACHTYPE="hp-ux"
    OSTYPE="hp-ux"
    PATH=.:~/hpbin:/usr/softbench/bin:$genpath:/usr/bin/X11:/etc:/y/cadre/tool_kit:/usr/local/games
    alias df=bdf
elif [ -d /com ]
then
    echo "Running under Domain"
    MACHTYPE="apollo"
    OSTYPE="domain"
    PATH=.:~/apollo_bin:$genpath:/com:/usr/apollo/bin:/usr/bin/X11
else
    echo "Cannot determine machine type! Defaulting PATH."
    PATH=.:$genpath:/usr/sbin:/sbin
fi

export MACHTYPE OSTYPE
