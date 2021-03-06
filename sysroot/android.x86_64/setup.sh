#! /bin/sh

set -e
set -u

NDK_ROOT=$1
NDK_PREBUILT_BIN=$2

for FILE in $NDK_PREBUILT_BIN/x86_64-linux-android*; do

FILE_ALIAS="$cur__bin/$(basename $FILE)"
cat > "$FILE_ALIAS" <<EOF
#!/bin/sh
$FILE "\$@"
EOF
chmod +x "$FILE_ALIAS"

done

cat > $cur__install/toolchain.cmake <<EOF
set(ANDROID_ABI x86_64)
set(ANDROID_NATIVE_API_LEVEL 24) # API level

include($NDK_ROOT/build/cmake/android.toolchain.cmake)
EOF

not-esy-gen-tools android $NDK_PREBUILT/bin/x86_64-linux-android
