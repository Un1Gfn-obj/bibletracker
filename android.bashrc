#!/dev/null

if [ -v TMUX ]; then

  echo

  export PATH="$PATH:$ANDROID_HOME/tools"
  export PATH="$PATH:$ANDROID_HOME/platform-tools"

  # export ANDROID_HOME=/home/darren/android-sdk
  # alias sdkmanager="/usr/bin/sdkmanager --sdk_root $ANDROID_HOME"
  export ANDROID_HOME=/opt/android-sdk

  export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
  GRADLE="/usr/bin/gradle"
  GRADLE+=" --no-daemon" # avoid incompatibilities with 'gradle --stop'
  GRADLE+=" -Dorg.gradle.java.home=$JAVA_HOME"
  GRADLE+=" -Dhttp.proxyHost=127.0.0.1"
  GRADLE+=" -Dhttp.proxyPort=8080"
  GRADLE+=" -Dhttps.proxyHost=127.0.0.1"
  GRADLE+=" -Dhttps.proxyPort=8080"
  GRADLE+=" -Dhttp.nonProxyHosts=\*.nonproxyrepos.com\|localhost"
  GRADLE+=" -warning-mode all"
  alias gradle="$GRADLE"
  alias gradle

  # function a_ver {
  #   {
  #     env | /usr/bin/grep JAVA_HOME
  #     echo
  #     echo gradle.properties; /usr/bin/grep -n org.gradle.java.home gradle.properties
  #     echo
  #     archlinux-java status
  #     echo
  #   } | /usr/bin/grep --color=auto -E -e '-.*-|$'
  # }

  function a_edit {
    # https://www.baeldung.com/linux/find-exclude-paths
    local N0HSUQ=(
      find .
      \(
        -path ./.git       -prune -o
        -path ./.gitignore -prune -o
        -path ./.gradle    -prune -o
        -path ./README.md  -prune -o
        -path ./app/build  -prune
      \) -o
      -type f
      # -print
      -exec subl {} \;
    )
    "${N0HSUQ[@]}"
  }

  source ~/proxy.bashrc

  /usr/local/bin/alacrittytitle.sh '(proxy) android'

else

  echo 'err: need tmux'

fi
