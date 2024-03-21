#!/bin/bash
#------------
MAIN(){
    clear 
    echo $'\e[31m=============================\e[0m'
    echo -e $'\e[31m\tAPK-MANAGER\e[0m'
    echo $'\e[31m=============================\e[0m'
    echo -e $'\e[32m1-APK COMPILE\e[0m'
    echo -e $'\e[32m2-APK DECOMPILE\e[0m'
    echo -e $'\e[32m3-APK KEYGEN\e[0m'
    echo -e $'\e[32m4-APK SIGN\e[0m'
    read -p "PLEASE SELECT NUMBER:" num
    if [ $num == "2" ];then
        APKDECOMPILE
    elif [ $num == "1" ];then
        APKCOMPILE
    elif [ $num == "3" ];then
        KEYGEN
    elif [ $num == "4" ];then
        APKSIGN
    fi
}
APKDECOMPILE(){
    read -p "APK-NAME:" apknum
    apktool d $apknum >> /dev/null
}
APKCOMPILE(){
    read -p 'FOLDER-NAME:' folder
    apktool empty-framework-dir --force >>/dev/null
    apktool b $folder >>/dev/null
}
KEYGEN(){
    while :
    do
        read -p "ENTER KEY NAME:" key
        if [ -f $key ];then
            echo "alreday name"
            continue
        else
            KEY=`keytool -genkey -noprompt -alias alias1 -dname "CN=test.com, OU=ID, O=test, L=test, S=test, C=GB" -keystore $key -keyalg RSA -keysize 2048 -validity 10000 -storepass password -keypass password 3>&1 1>/dev/null 2>&1`
            echo $KEY
            break
        fi
    done
        
}
APKSIGN(){
    read -p "ENTER NAME KEY:" key
    read -p "ENTER NAME APK:" apk
    apksigner sign --ks $key --ks-pass pass:password --ks-key-alias alias1 $apk
    echo -e $'\e[32mSCUSSFULY\e[0m'
}
MAIN
