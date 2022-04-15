#!/bin/bash
echo "Start building framework..."

function version_ge() { test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" == "$1"; }

XCFRAMEWORK_PATH=$1

pushd $XCFRAMEWORK_PATH

iphoneOsArch="armv7_arm64"

support_sim=0
support_m1_sim=0

cur_path=$XCFRAMEWORK_PATH
framework_suffix=".xcframework"
frameworks=""
for file in `ls $cur_path`; do
    echo $file
    if [[ $file == *$framework_suffix* ]]; then
        frameworks="$frameworks $file"
    fi

    for sub_file in `ls $file`; do
        echo $sub_file
        if [[ $sub_file == *-simulator ]]; then
            support_sim=1
            if [[ $sub_file == *ios-arm64_x86_64-simulator* || $sub_file == *ios-x86_64_arm64-simulator* ]]; then
                support_m1_sim=1
            fi
        else 
            if [[ $sub_file == *ios-arm64_armv7* ]]; then
                iphoneOsArch="arm64_armv7"
            elif [[ $sub_file == *ios-arm64* ]]; then
                iphoneOsArch="arm64"
            fi
        fi
    done
done



echo "Frameworks found:$frameworks"
if [ ! -d "ALL_ARCHITECTURE" ]; then
    rm -rf ALL_ARCHITECTURE
fi

mkdir ALL_ARCHITECTURE
for framework in $frameworks; do
    binary_name=${framework%.*}
    echo "framework_name is $binary_name"
    echo "iphoneOsArch: $iphoneOsArch"
#    cp -rf $binary_name.xcframework/ios-$iphoneOsArch/$binary_name.framework ./
    cp -rf $binary_name.xcframework/ios-$iphoneOsArch/$binary_name.framework ALL_ARCHITECTURE/

    if [ $support_sim -eq 0 ]; then
        continue;
    fi

    if [ $support_m1_sim -eq 1 ]; then
        if [ -d "$binary_name.xcframework/ios-arm64_x86_64-simulator" ];then
            cp -rf $binary_name.xcframework/ios-arm64_x86_64-simulator/$binary_name.framework ALL_ARCHITECTURE/${binary_name}-simulator.framework
            lipo -remove arm64 ALL_ARCHITECTURE/${binary_name}-simulator.framework/$binary_name -output ALL_ARCHITECTURE/${binary_name}-simulator.framework/$binary_name
            lipo -create ALL_ARCHITECTURE/${binary_name}-simulator.framework/$binary_name ALL_ARCHITECTURE/$binary_name.framework/$binary_name -o ALL_ARCHITECTURE/$binary_name.framework/$binary_name
            rm -rf ALL_ARCHITECTURE/${binary_name}-simulator.framework

            # lipo -remove arm64 $binary_name.xcframework/ios-arm64_x86_64-simulator/$binary_name.framework/$binary_name -output $binary_name.xcframework/ios-arm64_x86_64-simulator/$binary_name.framework/$binary_name
            # lipo -create $binary_name.xcframework/ios-arm64_x86_64-simulator/$binary_name.framework/$binary_name ALL_ARCHITECTURE/$binary_name.framework/$binary_name -o ALL_ARCHITECTURE/$binary_name.framework/$binary_name
        elif [ -d "$binary_name.xcframework/ios-x86_64_arm64-simulator" ];then
            cp -rf $binary_name.xcframework/ios-x86_64_arm64-simulator/$binary_name.framework ALL_ARCHITECTURE/${binary_name}-simulator.framework
            lipo -remove arm64 ALL_ARCHITECTURE/${binary_name}-simulator.framework/$binary_name -output ALL_ARCHITECTURE/${binary_name}-simulator.framework/$binary_name
            lipo -create ALL_ARCHITECTURE/${binary_name}-simulator.framework/$binary_name ALL_ARCHITECTURE/$binary_name.framework/$binary_name -o ALL_ARCHITECTURE/$binary_name.framework/$binary_name
            rm -rf ALL_ARCHITECTURE/${binary_name}-simulator.framework

            # lipo -remove arm64 $binary_name.xcframework/ios-x86_64_arm64-simulator/$binary_name.framework/$binary_name -output $binary_name.xcframework/ios-x86_64_arm64-simulator/$binary_name.framework/$binary_name
            # lipo -create $binary_name.xcframework/ios-x86_64_arm64-simulator/$binary_name.framework/$binary_name ALL_ARCHITECTURE/$binary_name.framework/$binary_name -o ALL_ARCHITECTURE/$binary_name.framework/$binary_name
        else
            lipo -create $binary_name.xcframework/ios-x86_64-simulator/$binary_name.framework/$binary_name ALL_ARCHITECTURE/$binary_name.framework/$binary_name -o ALL_ARCHITECTURE/$binary_name.framework/$binary_name
        fi
    else
        lipo -create $binary_name.xcframework/ios-x86_64-simulator/$binary_name.framework/$binary_name ALL_ARCHITECTURE/$binary_name.framework/$binary_name -o ALL_ARCHITECTURE/$binary_name.framework/$binary_name
    fi

#    rm -rf $binary_name.xcframework
done


echo "Build framework successfully."

popd