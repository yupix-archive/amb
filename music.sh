#!/bin/bash
#------------------------------------------------------------------------------#
#外部ファイル読み込み
. ./assets/outdate.txt
. ./assets/language/ja.txt
. ./assets/commands.txt
. ./assets/variable.txt
. ./assets/settings.txt
. ./newversion.txt
. ./version.txt
#------------------------------------------------------------------------------#
target="$FILE/config.txt"
output=$3
outputdata="./assets/outdate.txt"
SELF_DIR_PATH=$(
    cd $(dirname $0)
    pwd
)/
OUTDATE="$SELF_DIR_PATH/assets/"
#------------------------------------------------------------------------------#
#現在の情報
#・Prefixの表示時に関係ないのが出る
#・SetPrefixの際にエラーが発生する
#------------------------------------------------------------------------------#
#コマンド
main() {
    rm -r ./assets/outdate.txt
    sleep 1
    echo "ファイルを削除しています..."
    echo "ファイルが削除できているか確認しています..."
    if [ -e $outputdata ]; then
        echo "ファイル削除を確認しました..."
        echo "ファイルの生成を開始します..."
        cat ${target} | awk -f ./lib/convert.awk >./assets/outdate.txt

    else

        echo "ファイルが削除できていません"
    fi
    if [ -e ./assets/outdate.txt ]; then
        echo "ファイルの生成に成功しました"
    else
        echo "ファイルの生成に失敗しました"
    fi
}
systemstart() {
    if [ -e $JAR ]; then
        sudo chmod u+x $JAR
        echo "$FILETRUE"
        echo "$BOTSTART"
        cd $FILE
        java -jar JMusicBot-$VERSION-$EDITION.jar
        echo "$SERVICECHECK"
        count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
        if [ $count = 0 ]; then
            echo "$SERVICEDEAD"
        else
            echo "$SERVICEALIVE"
        fi
        echo "$ENDSERVICE"
        exit
    else
        echo "$JARFALSE"
        read -p "$FILEDOWNLOAD " DATA
        case "$DATA" in
        [yY])
            echo "ファイルのダウンロードを開始します"
            wget -q https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION-$EDITION.jar
            mv ./JMusicBot-$VERSION-$EDITION.jar $SELF_DIR_PATH/discord/music/
            cd $FILE
            java -jar JMusicBot-$VERSION-$EDITION.jar
            echo "$SERVICECHECK"
            count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
            if [ $count = 0 ]; then
                echo "$SERVICEDEAD"
            else
                echo "$SERVICEALIVE"
            fi
            echo "$ENDSERVICE"
            exit
            ;;
        [nN]) echo "$ENDSERVICE" ;;
        *) ;;
        esac
    fi
}
#------------------------------------------------------------------------------#
case $1 in
vercheck)
    #新しいバージョン
    curl -sl https://akari.fiid.net/app/amb/version.txt >newversion.txt
    if [ $version = $newversion ]; then
        echo '現在のambは最新バージョンで実行中です'
    else
        read -p "$最新のデータをダウンロードしますか?" Newversiondata
        case "$Newversiondata" in
        [yY])
            #本番用
            wget https:/akari.fiid.net/releases/download/$newversion/amb$newversion-Linux.zip
            mv ./amb$newversion-Linux.zip ../amb$newversion-Linux.zip
            cd ../
            rm -r ./amb
            unzip ./amb$newversion-Linux.zip
            rm -r ./amb$newversion-Linux.zip
            mv ./amb$newversion-Linux ./amb

            ;;
        [tT])
            #動作テスト用
            curl -OL https://akari.fiid.net/app/releases/download/$newversion/amb$newversion-Linux.zip
            mv ./amb$newversion-Linux.zip ../amb$newversion-Linux.zip
            cd ../
            rm -r ./amb
            unzip ./amb$newversion-Linux.zip
            rm -r ./amb$newversion-Linux.zip
            mv ./amb$newversion-Linux ./amb

            ;;
        [nN])
            echo "ファイルが存在しません!"
            ;;
        esac
    fi
    ;;
start)
    echo "SYSTEMFILEが存在するか確認しています..."
    echo "ファイルを確認中 1/2"
    if [ -e $SYSTEMFILE ]; then
        echo "ファイルが存在します"
        echo "ファイルを確認中 2/2"
        if [ -e $SYSTEMFILEMUSIC ]; then
            echo "ファイルが存在します"
            echo "SYSTEMを開始します"
            systemstart
        else
            echo "ファイルが不足しています。"
            echo "ファイルを作成します"
            mkdir "discord/music/"
            echo "SYSTEMを開始します"
            systemstart
        fi
    else
        echo "SYSTEMFILEが欠落しています"
        mkdir "discord"
        echo "ファイルを作成しました"
        echo "ファイルを確認中 2/2"
        if [ -e $SYSTEMFILEMUSIC ]; then
            echo "ファイルが存在します"
            echo "SYSTEMを開始します"
            systemstart
        else
            echo "ファイルが不足しています。"
            echo "ファイルを作成します"
            mkdir "discord/music/"
            echo "SYSTEMを開始します"
            systemstartVersion
        fi
        if [ -e $SYSTEMFILE ]; then
            echo "ファイルが存在します"
            echo "SYSTEMを開始します"
            systemstart
            echo "ファイルを確認中 2/2"
            if [ -e $SYSTEMFILEMUSIC ]; then
                echo "ファイル"
            else
                echo "test"
            fi
        fi
    fi
    ;;
"start -d")
    if [ -e $JAR ]; then
        echo "$FILETRUE"
        echo "$BOTSTART"
        echo "開発者モードで起動します"
        echo "ログが大量に流れるためキャンセルする場合 Ctrl + c を押してください"
        echo "3秒後に実行します"
        echo "remaining time 3..."
        sleep 1
        echo "remaining time 2..."
        sleep 1
        echo "remaining time 1..."
        sleep 1
        echo "MusicBot Starting!"
        cd $FILE
        $STARTPLUS
        echo "$SERVICECHECK"
        count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
        if [ $count = 0 ]; then
            echo "$SERVICEDEAD"
        else
            echo "$SERVICEALIVE"
        fi
        echo "$ENDSERVICE"
        exit
    else
        echo "$FILEFALSE"
        read -p "$FILEDOWNLOAD " DATA
        case "$DATA" in
        [yY])
            sudo wget https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION-$EDITION.jar
            mv ./JMusicBot-$VERSION-$EDITION.jar $SELF_DIR_PATH/discord/music/
            cd $FILE
            $STARTPLUS
            echo "$SERVICECHECK"
            count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
            if [ $count = 0 ]; then
                echo "$SERVICEDEAD"
            else
                echo "$SERVICEALIVE"
            fi
            echo "$ENDSERVICE"
            exit
            ;;
        [nN]) echo "$ENDSERVICE" ;;
        *) ;;
        esac
    fi
    ;;
remove)
    read -p "$FILEDELETED" DATA
    case "$DATA" in
    [yY])
        if [ -e $JAR ]; then
            sudo rm $JAR
            echo "ファイルを削除しました"
            exit
        else
            echo "$FILEFALSE"
        fi
        ;;
    [nN]) echo "ファイルが存在しません!" ;;
    *) ;;
    esac
    ;;
#===========#
#Config設定用#
#===========#
#Token関係　 #
#===========#
token)
    echo -e "TOKEN"
    echo -e "$TOKEN " | sed 's/token\ =\ //g'
    echo "です。変更する場合はSETTOKENをお使いください"
    ;;
settoken)
    echo "・TOKENを入力してください"
    read SETTOKEN
    sed -i -e "s/$TOKEN/token = $SETTOKEN/g" $FILE/config.txt
    ;;
prefix)
    echo -e "PREFIX"
    echo -e "$PREFIX " | sed 's/token\ =\ //g' | sed 's/ltprefix\ =\ "NONE"//g'
    echo "です。変更する場合はSETPREFIXをお使いください"
    ;;
status)
    echo -e "現在のステータスは $status_ です。変更する場合はsetstatusをご使用ください"
    echo "です。変更する場合はSETPREFIXをお使いください"
    ;;
createconfig)
    if [ -e $target ]; then
        main
    else
        echo "ファイルが存在しません"
    fi
    ;;
reconfig)
    $main
    ;;
cleanconfig)
    read -p "$FILEDELETED "
    case "$CLEANCONFI" in
    [yY])
        echo "ファイルの削除を開始します"
        $CLEANCONFIG
        echo "ファイル有無を確認しています"
        if [ -e ./assets/outdate.txt ]; then
            echo "ファイルが存在しない、又は削除に失敗しました"
            sed -e 's/変更前の文字列/変更後の文字列/g' ./data.txt >./data-new.txt
        else
            echo "ファイルの削除に成功しました"
        fi
        ;;
    [nN]) ;;

    \
        *) ;;
    esac
    ;;
settings)
    echo "Botを起動する際にアップデートを確認する"
    echo "現在の設定: $setting_VersionCheck"
    ;;
setsettings)
    echo "どの設定を変更しますか?"
    echo "1.Botを起動する際にアップデートを確認する"
    echo "変更したい設定の番号を入力してください..."
    read setsettings
    case "$setsettings" in
    [1])
        echo "ファイル有無を確認しています"
        if [ -e ./assets/settings.txt ]; then
            echo "使用可能: yes/no"
            read updatecheck
            if [ $updatecheck = $setting_VersionCheck ]; then
                echo "既に設定は "$setting_VersionCheck" に選択されています"
            else
                sed -i -e 's/setting_VersionCheck="yes"/setting_VersionCheck="no"/' ./assets/settings.txt
            fi
        else
            echo "settingsファイルが存在しません..."
            echo "exit 1"
        fi
        ;;
    esac
    ;;

#動作しません。
#setprefix)
#        read SETPREFIX
#    sed -e 's/$PREFIX/prefix = $SETPREFIX/g' $FILE/config.txt
#
#    ;;
#startw)
#    if [ -e $JAR ]; then
#        echo "$FILETRUE"
#        echo "$BOTSTART"
#        cd $FILE
#        java -jar JMusicBot-$VERSION-$EDITION.jar
#        echo "$SERVICECHECK"
#        count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
#        if [ $count = 0 ]; then
#            echo "$SERVICEDEAD"
#        else
#            echo "$SERVICEALIVE"
#        fi
#        echo "$ENDSERVICE"
#        exit
#    else
#        echo "$FILEFALSE"
#        read -p "$FILEDOWNLOAD " DATA
#        case "$DATA" in
#        [yY])
#            sudo wget -v https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION-$EDITION.jar
#           mv ./JMusicBot-$VERSION-$EDITION.jar /home/$USER/デスクトップ/disocrd/musicbot/
#           cd $FILE
#           java -jar JMusicBot-$VERSION-$EDITION.jar
#            echo "$SERVICECHECK"
#            count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
#            if [ $count = 0 ]; then
#                echo "$SERVICEDEAD"
#           else
#                echo "$SERVICEALIVE"
#            fi
#            echo "$ENDSERVICE"
#            exit
#            ;;
#        [nN]) echo "$ENDSERVICE" ;;
#        *) ;;
#        esac
#    fi
#    ;;
*)
    echo -e "\033[1;37m##=======================================##\033[0;39m"
    echo "##███╗   ███╗██╗   ██╗███████╗██╗ ██████╗##"
    echo "##████╗ ████║██║   ██║██╔════╝██║██╔════╝##"
    echo "##██╔████╔██║██║   ██║███████╗██║██║     ##"
    echo "##██║╚██╔╝██║██║   ██║╚════██║██║██║     ##"
    echo "##██║ ╚═╝ ██║╚██████╔╝███████║██║╚██████╗##"
    echo "##╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚═╝ ╚═════╝##"
    echo -e "\033[1;37m##=======================================##\033[0;39m"
    echo -e "\033[0;31mstart\033[1;39m: BOTを起動します"
    echo -e "\033[0;31mremove\033[1;39m: jarファイルを削除します"
    echo -e "\033[0;31mRECONFIG\033[1;39m: 出力ファイルを再生成します"

    read -p musicbotstart
    case "$musicbotstart" in
    [start])
        echo "SYSTEMFILEが存在するか確認しています..."
        echo "ファイルを確認中 1/2"
        if [ -e $SYSTEMFILE ]; then
            echo "ファイルが存在します"
            echo "ファイルを確認中 2/2"
            if [ -e $SYSTEMFILEMUSIC ]; then
                echo "ファイルが存在します"
                echo "SYSTEMを開始します"
                systemstart
            else
                echo "ファイルが不足しています。"
                echo "ファイルを作成します"
                mkdir "discord/music/"
                echo "SYSTEMを開始します"
                systemstart
            fi
        else
            echo "SYSTEMFILEが欠落しています"
            mkdir "discord"
            echo "ファイルを作成しました"
            echo "ファイルを確認中 2/2"
            if [ -e $SYSTEMFILEMUSIC ]; then
                echo "ファイルが存在します"
                echo "SYSTEMを開始します"
                systemstart
            else
                echo "ファイルが不足しています。"
                echo "ファイルを作成します"
                mkdir "discord/music/"
                echo "SYSTEMを開始します"
                systemstart
            fi
            if [ -e $SYSTEMFILE ]; then
                echo "ファイルが存在します"
                echo "SYSTEMを開始します"
                systemstart
                echo "ファイルを確認中 2/2"
                if [ -e $SYSTEMFILEMUSIC ]; then
                    echo "ファイル"
                else
                    echo "test"
                fi
            fi
        fi
        ;;
    [nN])
        exit
        ;;

    [exit])
        exit
        ;;

    *) ;;
    esac
    ;;
esac
exit 0
