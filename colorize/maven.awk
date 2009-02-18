# maven.awk
#
# This is an nawk script used to colorize the output from maven2. Simply
# pipe the output from mvn into the nawk (or gawk) program with this
# file as the awk script.
#
# Examples:
#    mvn 2>&1 | nawk -f maven.awk
#
# Functions:
#    cmvn () { mvn $* 2>&1 | nawk -f maven.awk; }
# -----------------------------------------------------------------------------

BEGIN {

# Define the colors in our color pallete
# --------------------------------------
    normal       = "\033[0m"
    boldon       = "\033[1m"
    italicson    = "\033[3m"
    underlineon  = "\033[4m"
    inverseon    = "\033[7m"
    strikethon   = "\033[9m"
    boldoff      = "\033[22m"
    italicsoff   = "\033[23m"
    underlineoff = "\033[24m"
    inverseoff   = "\033[27m"
    strikethoff  = "\033[29m"
    fgblack      = "\033[30m"
    fgred        = "\033[31m"
    fggreen      = "\033[32m"
    fgyellow     = "\033[33m"
    fgblue       = "\033[34m"
    fgmagenta    = "\033[35m"
    fgcyan       = "\033[36m"
    fgwhite      = "\033[37m"
    fgdefault    = "\033[39m"
    bgblack      = "\033[40m"
    bgred        = "\033[41m"
    bggreen      = "\033[42m"
    bgyellow     = "\033[43m"
    bgblue       = "\033[44m"
    bgmagenta    = "\033[45m"
    bgcyan       = "\033[46m"
    bgwhite      = "\033[47m"
    bgdefault    = "\033[49m"
}

# Normal maven info lines
#
/^(INFO|\[INFO\])/ { print boldon fgblue $0 normal; next }

# Warnings reported by maven
#
/^(WARNING|\[WARNING\])/ { print boldon fgyellow $0 normal; next }
/^(WARN|\[WARN\])/ { print boldon fgyellow $0 normal; next }

# Errors reported by maven
#
/^(ERROR|\[ERROR\])/ { print boldon fgwhite bgred $0 normal; next }

# Test Results
#Tests run: 23, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.046 sec
#
/^Tests run:.*Errors: [^0]/ { print boldon fgwhite bgred $0 normal; next }
/^Tests run:.*Failures: [^0]/ { print boldon fgred $0 normal; next }
/^Tests run:.*Skipped: [^0]/ { print boldon fgyellow $0 normal; next }
/^Tests run:/ { print boldon fggreen $0 normal; next }

# Everything else is normal
#
{ print $0 }
