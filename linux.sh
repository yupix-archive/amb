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
#██╗    ██╗ █████╗ ██████╗ ███╗   ██╗██╗███╗   ██╗ ██████╗
#██║    ██║██╔══██╗██╔══██╗████╗  ██║██║████╗  ██║██╔════╝
#██║ █╗ ██║███████║██████╔╝██╔██╗ ██║██║██╔██╗ ██║██║  ███╗
#██║███╗██║██╔══██║██╔══██╗██║╚██╗██║██║██║╚██╗██║██║   ██║
#╚███╔███╔╝██║  ██║██║  ██║██║ ╚████║██║██║ ╚████║╚██████╔╝
# ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚═════╝
#このファイルを変更するにはShellScriptに詳しい方を知り合いにお持ちか、
#又はある程度の知識があることを前提に変更することをとても強く推奨します。
#本ファイルはMAIN SYSTEM そのもののため、どこかが欠けたりすると
#ほぼ確実に全ての機能が正常に動作しなくなります。
#本Projectの内容を変更する際は以下の本Projectの作者であるyupixが
#解説しているサイトを読みながらすることを推奨します。
# https://akari.fiid.net/dev/amb/top
#------------------------------------------------------------------------------#

#コマンド
main() {
    rm -r ./assets/outdate.txt
    sleep 1
    echo "$FAILEDELETENOW"
    echo "ファイルが削除できているか確認しています..."
    if [ -e $outputdata ]; then
        echo "ファイルが削除できていません"

    else
        echo "ファイルの削除を確認しました..."
        echo "ファイルの生成を開始します..."
        cat ${target} | awk -f ./lib/convert.awk >./assets/outdate.txt
    fi
    if [ -e ./assets/outdate.txt ]; then
        echo "$FILECREATESUCCESS"
    else
        echo "$FILECREATEFAILED"
    fi
}
autoreconfig() {
    rm -r ./assets/outdate.txt
    sleep 1
    echo "$FAILEDELETENOW"
    echo "ファイルが削除できているか確認しています..."
    if [ -e $outputdata ]; then
        echo "ファイル削除を確認しました..."
        echo "ファイルの生成を開始します..."
        cat ${target} | awk -f ./lib/convert.awk >./assets/outdate.txt
    else
        echo "ファイルが削除できていません"
        cat ${target} | awk -f ./lib/convert.awk >./assets/outdate.txt
    fi
    if [ -e ./assets/outdate.txt ]; then
        echo "$FILECREATESUCCESS"
    else
        echo "$FILECREATEFAILED"
        read -p "再試行しますか? (y/n)" RETRY
        case "$RETRY" in
        [yY])
            cat ${target} | awk -f ./lib/convert.awk >./assets/outdate.txt
            if [ -e ./assets/outdate.txt ]; then
                echo "$FILECREATESUCCESS"
            else
                echo "ファイルの削除に失敗しました。"
                echo "ファイルの生成に合計2回失敗したため、サービスを終了します"
                echo "再度実行し、ファイルの生成に失敗する場合は製作者に報告を宜しくおねがいします"
            fi
            ;;
        [nN])
            echo "$ENDSERVICE"
            ;;
        esac
    fi
}
vcheck() {
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
            echo "アップデートをキャンセルしました"
            echo "MusicBotを起動します..."
            ;;
        esac
    fi
}
versioncheck() {
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
            echo "アップデートをキャンセルしました"
            echo "MusicBotを起動します..."
            botstart
            ;;
        esac
    fi
}
botstart() {
    echo "SYSTEMFILEが存在するか確認しています..."
    echo "ファイルを確認中 1/2"
    if [ -e $SYSTEMFILE ]; then
        echo "ファイルが存在します"
        echo "ファイルを確認中 2/2"
        if [ -e $SYSTEMFILEMUSIC ]; then
            echo "ファイルが存在します"
            echo "$SYSTEMSTART"
            systemstart
        else
            echo "ファイルが不足しています。"
            echo "$FAILECREATE"
            mkdir "discord/music/"
            echo "$SYSTEMSTART"
            systemstart
        fi
    else
        echo "SYSTEMFILEが欠落しています"
        mkdir "discord"
        echo "ファイルを作成しました"
        echo "ファイルを確認中 2/2"
        if [ -e $SYSTEMFILEMUSIC ]; then
            echo "ファイルが存在します"
            echo "$SYSTEMSTART"
            systemstart
        else
            echo "ファイルが不足しています。"
            echo "$FAILECREATE"
            mkdir "discord/music/"
            echo "$SYSTEMSTART"
            systemstart
        fi
        if [ -e $SYSTEMFILE ]; then
            echo "ファイルが存在します"
            echo "$SYSTEMSTART"
            systemstart
            echo "ファイルを確認中 2/2"
            if [ -e $SYSTEMFILEMUSIC ]; then
                echo "ファイル"
            else
                echo "test"
            fi
        fi
    fi
}
systemstart() {
    if [ -e $JAR ]; then
        echo "jarファイルにchmodで権限を付与します"
        sudo chmod u+x $JAR
        echo "$FILETRUE"
        echo "$BOTSTART"
        cd $FILE
        java -jar JMusicBot-$VERSION-$EDITION.jar &
        echo -e 'BOTSTATUS: \e[1;37;32mONLINE\e[0m'
        read -p "e でSystemを終了します" SERVICEEXIT
        sleep 1
        case "$SERVICEEXIT" in
        [e])
            pid=$!
            kill $pid
            echo "$SERVICECHECK"
            sleep 2
            count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
            if [ $count = 0 ]; then
                echo "$SERVICEDEAD"
            else
                echo "$SERVICEALIVE"
            fi
            echo "$ENDSERVICE"
            exit
            ;;
        esac
    else
        echo "$JARFALSE"
        read -p "$FILEDOWNLOAD " DATA
        case "$DATA" in
        [yY])
            echo "ファイルのダウンロードを開始します"
            wget -q https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION-$EDITION.jar
            mv ./JMusicBot-$VERSION-$EDITION.jar $SELF_DIR_PATH/discord/music/
            cd $FILE
            java -jar JMusicBot-$VERSION-$EDITION.jar &
            read -p "テスト" SERVICEEXIT
            case "$SERVICEEXIT" in
            [yY])
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
            esac
            ;;
        [nN]) echo "$ENDSERVICE" ;;
        *) ;;
        esac
    fi
}
#------------------------------------------------------------------------------#
case $1 in
vercheck)
    vcheck
    ;;
start)
    if [ yes = $setting_outputdata ]; then
        autoreconfig
        if [ -z "$CLIENT_ID" ]; then
            echo "CLIENT_IDを入力してください"
            read INPUT_CLIENTID
            sed -i -e 's/CLIENT_ID="'$CLIENT_ID'"/CLIENT_ID="'$INPUT_CLIENTID'"/g' ./assets/settings.txt
            echo "BOTの招待URL: https://discordapp.com/api/oauth2/authorize?client_id=$INPUT_CLIENTID&permissions=8&scope=bot"
            if [ yes = $setting_VersionCheck ]; then
                versioncheck
            else
                botstart
            fi
        fi
        if [ -z "$CLIENT_ID" ]; then
            echo "CLIENT_IDを入力してください"
            read INPUT_CLIENTID
            sed -i -e 's/CLIENT_ID="'$CLIENT_ID'"/CLIENT_ID="'$INPUT_CLIENTID'"/g' ./assets/settings.txt
            echo "BOTの招待URL: https://discordapp.com/api/oauth2/authorize?client_id=$INPUT_CLIENTID&permissions=8&scope=bot"
            if [ yes = $setting_VersionCheck ]; then
                versioncheck
            else
                botstart
            fi
        else
            if [ yes = $setting_botinvite ]; then
                echo "BOTの招待URL: https://discordapp.com/api/oauth2/authorize?client_id=$CLIENT_ID&permissions=8&scope=bot"
                if [ yes = $setting_VersionCheck ]; then
                    versioncheck
                else
                    botstart
                fi
            else
                if [ yes = $setting_VersionCheck ]; then
                    versioncheck
                else
                    botstart
                fi
            fi
        fi
    fi

    ;;
"start-d")
    if [ -e $JAR ]; then
        echo "$FILETRUE"
        echo "$BOTSTART"
        echo "$STARTDEVELOPERMODE"
        echo -e "$DEVELOPERMODEWARNING"
        echo "ログが大量に流れるためキャンセルする場合 Ctrl + c を押してください"
        echo "3秒後に実行します"
        echo "$remainingtimethree"
        sleep 1
        echo "$remainingtimetwo"
        sleep 1
        echo "$remainingtimeone"
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
        echo "$FAILNOTFOUND"
        read -p "$FILEDOWNLOAD " DATA
        case "$DATA" in
        [yY])
            wget https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION-$EDITION.jar
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
botstatus)
    count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
    if [ $count = 0 ]; then
        echo -e "BOTSTATUS: \033[0;31mOFFLINE\033"
    else
        echo -e 'BOTSTATUS: \e[1;37;32mONLINE\e[0m'
    fi
    ;;
time)
    echo "現在時刻を表示します。 (終了する場合はCtrl + c)"
    while true; do
        echo -e "$(date +%H:%M:%S)\r\c"
        sleep 1
    done
    ;;
remove)
    read -p "$FILEDELETED" DATA
    case "$DATA" in
    [yY])
        if [ -e $JAR ]; then
            rm $JAR
            echo "$FILEDELETE"
            exit
        else
            echo "$FAILNOTFOUND"
        fi
        ;;
    [nN]) echo "$FAILNOTFOUND" ;;
    *) ;;
    esac
    ;;
#===========#
#Config設定用#
#===========#
#ClientID   #
#===========#

clientid)
    echo "現在のCLIENT_IDは $CLIENT_ID に設定されています。"
    echo -e "変更する場合は \033[0;31msetclientid\033[0;39m をお使いください"
    ;;

setclientid)
    echo "CLIENT_IDを入力してください"
    read INPUT_CLIENTID
    sed -i -e 's/CLIENT_ID="'$CLIENT_ID'"/CLIENT_ID="'$INPUT_CLIENTID'"/g' ./assets/settings.txt
    echo -e "CLIENT_IDを \033[0;31m$INPUT_CLIENTID\033[0;39m に変更しました"
    ;;

#===========#
#InviteBOT  #
#===========#

invite)
    echo "BOTの招待URL: https://discordapp.com/api/oauth2/authorize?client_id=$CLIENT_ID&permissions=8&scope=bot"
    ;;

#===========#
#Token関係　 #
#===========#
token)
    echo -e "現在のTokenは $token_  です。"
    echo -e "変更する場合は \033[0;31msettoken\033[0;39m をお使いください"
    ;;
setoken)
    echo "TOKENを入力してください"
    read SETTOKEN
    sed -i -e "s/$TOKEN/token = $SETTOKEN/g" $FILE/config.txt
    ;;
prefix)
    echo -e "$prefix_ です。変更する場合はSETPREFIXをお使いください"
    ;;
status)
    echo -e "現在のステータスは $status_ です。"
    echo -e "変更する場合は \033[0;31msetstatus\033[0;39m をお使いください"
    ;;
createconfig)
    if [ -e $target ]; then
        sed -i 's/"//g' $CONFIGFILE
        main
    else
        echo "$FAILNOTFOUND"
    fi
    ;;
reconfig)
    rm -r ./assets/outdate.txt
    sleep 1
    echo "$FAILEDELETENOW"
    echo "ファイルが削除できているか確認しています..."
    if [ -e $outputdata ]; then
        echo "ファイル削除を確認しました..."
        echo "ファイルの生成を開始します..."
        cat ${target} | awk -f ./lib/convert.awk >./assets/outdate.txt
    else
        echo "ファイルが削除できていません"
        cat ${target} | awk -f ./lib/convert.awk >./assets/outdate.txt
    fi
    if [ -e ./assets/outdate.txt ]; then
        echo "$FILECREATESUCCESS"
    else
        echo "$FILECREATEFAILED"
        read -p "再試行しますか? (y/n)" RETRY
        case "$RETRY" in
        [yY])
            cat ${target} | awk -f ./lib/convert.awk >./assets/outdate.txt
            if [ -e ./assets/outdate.txt ]; then
                echo "$FILECREATESUCCESS"
            else
                echo "ファイルの削除に失敗しました。"
                echo "ファイルの生成に合計2回失敗したため、サービスを終了します"
                echo "再度実行し、ファイルの生成に失敗する場合は製作者に報告を宜しくおねがいします"
            fi
            ;;
        [nN])
            echo "$ENDSERVICE"
            ;;
        esac
    fi
    ;;
removeconfig)
    read -p "$FILEDELETED" CLEANCONFI
    case "$CLEANCONFI" in
    [yY])
        echo "ファイルの有無を確認しています"
        if [ -e ./assets/outdate.txt ]; then
            echo "ファイルの削除を開始します"
            rm $OUTDATADIRECTORY
            if [ -e ./assets/outdate.txt ]; then
                echo "ファイルの削除に失敗しました"
                else
                echo "ファイルの削除に成功しました"
            fi
        else
            echo "$FILEFALSE."
        fi
        ;;
    [nN]) ;;

    *) ;;
    esac
    ;;

#===================#
#Botの機能のon/off　　#
#===================#

#setSettingsに統一された為、廃止
#settings)
#    echo "Botを起動する際にアップデートを確認する"
#    echo "現在の設定: $setting_VersionCheck"
#    echo "起動した際にBOTの招待URLを表示する"
#    echo "現在の設定: $setting_botinvite"
#    ;;
setSettings)
    echo "どの設定を変更しますか?"
    echo "1.Botを起動した際にアップデートを確認する"
    echo "   ┗現在の設定: $setting_VersionCheck"
    echo "2.Botを起動した際にBOTの招待リンクを表示する"
    echo "   ┗現在の設定: $setting_botinvite"
    echo "3.Botを起動した際にTOKEN等の情報を更新する"
    echo "   ┗現在の設定: $setting_outputdata"
    echo "4.Botを起動した際Backupを取るかどうか"
    echo "   ┗現在の設定: $setting_backuptime"
    echo "変更したい設定の番号を入力してください..."
    read setsettings
    case "$setsettings" in
    [1])
        echo "SettingsFileの有無を確認しています"
        if [ -e ./assets/settings.txt ]; then
            echo "使用可能: yes/no"
            read updatecheck
            if [ $updatecheck = $setting_VersionCheck ]; then
                echo "既に設定は "$setting_VersionCheck" に選択されています"
            else
                sed -i -e 's/setting_VersionCheck="'$setting_VersionCheck'"/setting_VersionCheck="'$updatecheck'"/' ./assets/settings.txt
                if [ $updatecheck = $setting_VersionCheck ]; then
                    echo "変更に失敗しました..."
                else
                    echo "変更に成功しました!"
                fi
            fi
        else
            echo "SettingsFileが存在しません..."
            echo "exit 1"
        fi
        ;;
    [2])
        echo "SettingsFileの有無を確認しています"
        if [ -e ./assets/settings.txt ]; then
            echo "使用可能: yes/no"
            read settingCLIENTID
            if [ $settingCLIENTID = $setting_botinvite ]; then
                echo "既に設定は "$setting_botinvite" に選択されています"
            else
                sed -i -e 's/setting_botinvite="'$setting_botinvite'"/setting_botinvite="'$settingCLIENTID'"/' ./assets/settings.txt
                if [ $settingCLIENTID = $setting_botinvite ]; then
                    echo "変更に失敗しました..."
                else
                    echo "変更に成功しました!"
                fi
            fi
        else
            echo "SettingsFileが存在しません..."
            echo "exit 1"
        fi
        ;;
    [3])
        echo "SettingsFileの有無を確認しています"
        if [ -e ./assets/settings.txt ]; then
            echo "使用可能: yes/no"
            read settingoutputin
            if [ $settingoutputin = $setting_outputdata ]; then
                echo "既に設定は "$setting_outputdata" に選択されています"
            else
                sed -i -e 's/setting_outputdata="'$setting_outputdata'"/setting_outputdata="'$settingoutputin'"/' ./assets/settings.txt
                if [ $settingoutputin = $setting_outputdata ]; then
                    echo "変更に失敗しました..."
                else
                    echo "変更に成功しました!"
                fi
            fi
        else
            echo "SettingsFileが存在しません..."
            echo "exit 1"
        fi
        ;;
    [4])
        echo "SettingsFileの有無を確認しています"
        if [ -e ./assets/settings.txt ]; then
            echo "使用可能: yes/no"
            read settinginputbackup
            if [ $settinginputbackup = $setting_backuptime ]; then
                echo "既に設定は "$setting_backuptime" に選択されています"
            else
                sed -i -e 's/setting_backuptime="'$setting_backuptime'"/setting_backuptime="'$settinginputbackup'"/' ./assets/settings.txt
                if [ $settinginputbackup = $setting_backuptime ]; then
                    echo "変更に失敗しました..."
                else
                    echo "設定を$settinginputbackupに変更しました"
                fi
            fi
        else
            echo "SettingsFileが存在しません..."
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
#        echo "$FAILNOTFOUND"
#        read -p "$FILEDOWNLOAD " DATA
#        case "$DATA" in
#        [yY])
#            wget -v https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION-$EDITION.jar
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

    echo -e "\033[1;37m##===========================##\033[0;39m"
    echo "## █████╗ ███╗   ███╗██████╗ ##"
    echo "##██╔══██╗████╗ ████║██╔══██╗##"
    echo "##███████║██╔████╔██║██████╔╝##"
    echo "##██╔══██║██║╚██╔╝██║██╔══██╗##"
    echo "##██║  ██║██║ ╚═╝ ██║██████╔╝##"
    echo "##╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ##"
    echo -e "\033[1;37m##===========================##\033[0;39m"
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
                echo "$SYSTEMSTART"
                systemstart
            else
                echo "ファイルが不足しています。"
                echo "$FAILECREATE"
                mkdir "discord/music/"
                echo "$SYSTEMSTART"
                systemstart
            fi
        else
            echo "SYSTEMFILEが欠落しています"
            mkdir "discord"
            echo "ファイルを作成しました"
            echo "ファイルを確認中 2/2"
            if [ -e $SYSTEMFILEMUSIC ]; then
                echo "ファイルが存在します"
                echo "$SYSTEMSTART"
                systemstart
            else
                echo "ファイルが不足しています。"
                echo "$FAILECREATE"
                mkdir "discord/music/"
                echo "$SYSTEMSTART"
                systemstart
            fi
            if [ -e $SYSTEMFILE ]; then
                echo "ファイルが存在します"
                echo "$SYSTEMSTART"
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
