#!/bin/bash -e

# https://github.com/termux/termux-app/blob/master/art/generate-launcher-images.sh

# https://developer.android.com/develop/ui/views/launch/icon_design_adaptive

[ "/home/darren/android_app" = "$PWD" ]

cd /tmp
[ -f "Android_Robot.svg" ] || wget https://developer.android.com/static/images/brand/Android_Robot.svg
# [ -f "convert.xsl" ] || wget https://raw.githubusercontent.com/leso-kn/svg2vd/master/convert.xsl
cd -

for DENSITY in mdpi hdpi xhdpi xxhdpi xxxhdpi; do
  case $DENSITY in
    mdpi) SIZE=48;;
    hdpi) SIZE=72;;
    xhdpi) SIZE=96;;
    xxhdpi) SIZE=144;;
    xxxhdpi) SIZE=192;;
  esac
  FOLDER=app/src/main/res/mipmap-$DENSITY
  mkdir -pv $FOLDER
  cd $FOLDER
  rsvg-convert -w $SIZE -h $SIZE --keep-aspect-ratio /tmp/Android_Robot.svg >ic_launcher.png
  zopflipng -y ic_launcher.png ic_launcher.png
  cp -v ic_launcher.png ic_launcher_round.png
  cd -
done

# mkdir -pv app/src/main/res/drawable-anydpi-v26
# cd "$_"
# xsltproc -o android_robot.xml /tmp/convert.xsl /tmp/Android_Robot.svg # not working at all
# rsvg-convert -w 192 -h 192 --keep-aspect-ratio /tmp/Android_Robot.svg >android_robot.png
# magick convert -size 72x72 /tmp/Android_Robot.svg -background transparent -gravity center -extent 108x108 android_robot.png
# zopflipng -y android_robot.png android_robot.png
# cd -

# mkdir -pv app/src/main/res/mipmap-anydpi-v26
# cd "$_"
# cat <<EOF >ic_launcher.xml
# <?xml version="1.0" encoding="utf-8"?>
# <adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
#     <background android:drawable="@android:color/black"/>
#     <foreground android:drawable="@drawable/android_robot"/>
# </adaptive-icon>
# EOF
# cd -

echo "done"

