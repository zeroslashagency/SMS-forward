#!/usr/bin/env sh

#
# Copyright 2015 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

##############################################################################
##
##  Gradle start up script for UN*X
##
##############################################################################

# Attempt to set APP_HOME
# Resolve links: $0 may be a link
PRG="$0"
# Need this for relative symlinks.
while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : ''.*-> \(.*\)''`
    if expr "$link" : ''/'' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`"/$link"
    fi
done
SAVED="`pwd`"
cd "`dirname "$PRG"`/" >/dev/null
APP_HOME="`pwd -P`"
cd "$SAVED" >/dev/null

APP_NAME="Gradle"
APP_BASE_NAME=`basename "$0"`

# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS=''''

# Use the maximum available, or set MAX_FD != -1 to use that value.
MAX_FD="maximum"

warn () {
    echo "$*"
}

die () {
    echo
    echo "$*"
    echo
    exit 1
}

# OS specific support (must be 'true' or 'false').
cygwin=false
msys=false
darwin=false
nonstop=false
case "`uname`" in
  CYGWIN* )
    cygwin=true
    ;;
  Darwin* )
    darwin=true
    ;;
  MINGW* )
    msys=true
    ;;
  NONSTOP* )
    nonstop=true
    ;;
esac

# For Cygwin, ensure paths are in UNIX format before anything is touched.
if $cygwin ; then
    [ -n "$JAVA_HOME" ] && JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
fi

# Attempt to find java
if [ -z "$JAVA_HOME" ] ; then
    JAVA="java"
else
    JAVA="$JAVA_HOME/bin/java"
fi

# Determine the Java version
if [ -n "$JAVA" ] ; then
    java_version=$("$JAVA" -version 2>&1 | grep "version" | cut -d'"' -f2)
    if [ -n "$java_version" ] ; then
        # If the version is of the form "1.x.y", we want to extract "x".
        java_major_version=$(echo "$java_version" | cut -d'.' -f2)
        # If the version is of the form "x.y.z", we want to extract "x".
        if [ "$java_major_version" -eq 1 ]; then
            java_major_version=$(echo "$java_version" | cut -d'.' -f1)
        fi
        if [ "$java_major_version" -lt 8 ]; then
            die "Gradle 8.0 requires Java 8 or later to run. You are currently using Java $java_version."
        fi
    fi
fi

# For Cygwin, switch paths to Windows format before running java
if $cygwin ; then
    APP_HOME=`cygpath --path --windows "$APP_HOME"`
    CLASSPATH=`cygpath --path --windows "$CLASSPATH"`
    CYGHOME=`cygpath --windows "$HOME"`
fi

# Split up the JVM options only if spaces are available.
if [ -z "$DEFAULT_JVM_OPTS" -a -z "$JAVA_OPTS" -a -z "$GRADLE_OPTS" ] ; then
    JVM_OPTS=
else
    JVM_OPTS="$DEFAULT_JVM_OPTS $JAVA_OPTS $GRADLE_OPTS"
fi

# Collect all arguments for the java command, following the shell quoting and substitution rules
eval set -- "$@"
for arg in "$@" ; do
    case $arg in
        --stop)
            STOP_GRADLE=true
            ;;
        --status)
            STATUS_GRADLE=true
            ;;
        --foreground)
            FOREGROUND_GRADLE=true
            ;;
        -D*)
            # Collect all system properties
            JVM_OPTS="$JVM_OPTS $arg"
            ;;
    esac
done

if [ "$STOP_GRADLE" = "true" ] ; then
    "$JAVA" $JVM_OPTS -cp "$APP_HOME/gradle/wrapper/gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain --stop "$@"
    exit $?
fi

if [ "$STATUS_GRADLE" = "true" ] ; then
    "$JAVA" $JVM_OPTS -cp "$APP_HOME/gradle/wrapper/gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain --status "$@"
    exit $?
fi

# Escape the arguments for the new process
for arg in "$@" ; do
    if echo "$arg" | grep -q ' ' ; then
        # The argument contains a space, so quote it
        args="$args "$arg""
    else
        # The argument has no space, so we can pass it as is
        args="$args $arg"
    fi
done

# Launch the Gradle client
if [ "$FOREGROUND_GRADLE" = "true" ] ; then
    "$JAVA" $JVM_OPTS -cp "$APP_HOME/gradle/wrapper/gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain $args
else
    # Start Gradle in a separate process
    exec "$JAVA" $JVM_OPTS -cp "$APP_HOME/gradle/wrapper/gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain $args
fi