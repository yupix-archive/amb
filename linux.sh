#!/bin/bash
#------------------------------------------------------------------------------#
#外部ファイル読み込み
. ./assets/outdata.txt
. ./assets/language/ja.txt
. ./assets/permissions.txt
. ./assets/commands.txt
. ./assets/variable.txt
. ./assets/settings.txt
. ./newversion.txt
. ./version.txt
. ./version.txt
. ./assets/userdata/allsettings.txt
. ./assets/password.txt
#------------------------------------------------------------------------------#
target="$FILE/config.txt"
output=$3
outputdata="./assets/outdata.txt"
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

firststart() {
    if [ $firststart = 0 ]; then
        echo "AMBPROJECTをインストールしていただきありがとうございます。"
        echo "本Projectを自分好みに動かすために初期設定を行うことを推奨します"
        echo "使用可能 (y)es (n)o"
        while :; do
            read INPUT_DATA
            if [ $INPUT_DATA = y ]; then
                sed -i -e 's/firststart="'$firststart'"/firststart="'1'"/' ./assets/settings.txt
                echo "#BOTを起動した際にVercheckを走らせるかどうか (default = yes)"
                read firstsetting1
                sed -i -e 's/setting_VersionCheck="'$setting_VersionCheck'"/setting_VersionCheck="'$firstsetting1'"/' ./assets/settings.txt
                echo "BOTを起動した際に招待リンクを表示するかどうか (default = yes)"
                read firstsetting2
                sed -i -e 's/setting_botinvite="'$setting_botinvite'"/setting_botinvite="'$firstsetting2'"/' ./assets/settings.txt
                echo "BOTを起動した際にTOKEN等の情報を更新するかどうか (default = yes)"
                read firstsetting3
                sed -i -e 's/setting_outputdata="'$setting_outputdata'"/setting_outputdata="'$firstsetting3'"/' ./assets/settings.txt
                echo "バックアップを行うか否か (default = yes)"
                read firstsetting4
                sed -i -e 's/setting_backuptime="'$setting_backuptime'"/setting_backuptime="'$firstsetting4'"/' ./assets/settings.txt
                echo "これで初期設定は終わりです、お疲れ様でした。"
                echo "この他にもExtension等様々な物の有効化方法が有りますが、詳しくは https://akari.fiid.net/dev/amb/top をご覧ください!"
                echo "それでは良いDiscordBotライフを!"
                sleep 10
                break
            elif [ $INPUT_DATA = n ]; then
                sed -i -e 's/firststart="'$firststart'"/firststart="'1'"/' ./assets/settings.txt
                echo "キャンセルしました!"
                echo "自動的に元の動作を行います。"
                break
            else
                echo "(y)es or (n)o を入力してください"
            fi
        done

    fi
}

main() {
    rm -r ./assets/outdata.txt
    sleep 1
    echo "$FAILEDELETENOW"
    echo "ファイルが削除できているか確認しています..."
    if [ -e $outputdata ]; then
        echo "$FILEDELETEFAILED"

    else
        echo "$FILEDELETESUCCESS"
        echo "$FILECREATESTART"
        cat ${target} | awk -f ./lib/convert.awk >./assets/outdata.txt
    fi
    if [ -e ./assets/outdata.txt ]; then
        echo "$FILECREATESUCCESS"
    else
        echo "$FILECREATEFAILED"
    fi
}
autoreconfig() {
    rm -r ./assets/outdata.txt
    sleep 1
    echo "$FAILEDELETENOW"
    echo "ファイルが削除できているか確認しています..."
    if [ -e $outputdata ]; then
        echo "$FILEDELETEFAILED"
        cat ${target} | awk -f ./lib/convert.awk >./assets/outdata.txt
    else
        cat ${target} | awk -f ./lib/convert.awk >./assets/outdata.txt
        echo "$FILEDELETESUCCESS"
        echo "$FILECREATESTART"
    fi
    if [ -e ./assets/outdata.txt ]; then
        echo "$FILECREATESUCCESS"
    else
        echo "$FILECREATEFAILED"
        read -p "再試行しますか? (y/n)" RETRY
        case "$RETRY" in
        [yY])
            cat ${target} | awk -f ./lib/convert.awk >./assets/outdata.txt
            if [ -e ./assets/outdata.txt ]; then
                echo "$FILECREATESUCCESS"
            else
                echo "$FILEDELETESUCCESS。"
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
    #新バージョンアップ
    curl -sl https://akari.fiid.net/app/amb/newversion.txt >newversion.txt
    if [ $version = $newversion ]; then
        echo -e '現在のambは\e[1;37;32m最新バージョン\e[0mで実行中です '
    else
        read -p "最新のデータをダウンロードしますか?(y/n)" Newversiondata
        case "$Newversiondata" in
        [yY])
            #本番用
            echo "$FILEDOWNLOADSTART"
            wget https://github.com/yupix/amb/releases/download/$newversion/amb$newversion-linux.zip
            unzip -o amb$newversion-linux.zip
            cp -r ./amb/* ./
            rm -rf ./amb
            ;;
        [tT])
            #動作テスト用
            curl -OL https://akari.fiid.net/app/releases/download/$newversion/amb$newversion-Linux.zip
            unzip -o amb$newversion-linux.zip
            cp -r ./amb/* ./
            rm -r ./amb
            ;;
        [nN])
            echo "アップデートをキャンセルしました"
            echo "システムを終了します..."
            ;;
        esac
    fi
}

#loading
SCROLL() {
    for ((i = 0; i < ${#chars}; i++)); do
        sleep 0.2
        echo -en "${chars:$i:1} $PROGRESS_STATUS" "\r"
    done
}
SCROLLFILECHECK1() {
    for ((i = 0; i < ${#chars}; i++)); do
        sleep 0.2
        echo -en "${chars:$i:1} SYSTEMファイルの確認 1/3" "\r"
    done
}
SCROLLFILECHECK2() {
    for ((i = 0; i < ${#chars}; i++)); do
        sleep 0.2
        echo -en "${chars:$i:1} SYSTEMファイルの確認 2/3" "\r"
    done
}
SCROLLFILECHECK3() {
    for ((i = 0; i < ${#chars}; i++)); do
        sleep 0.2
        echo -en "${chars:$i:1} SYSTEMファイルの確認 3/3" "\r"
    done
}
FILEDONWLOADNOW() {
    for ((i = 0; i < ${#chars}; i++)); do
        sleep 0.2
        echo -en "${chars:$i:1} ファイルのダウンロード中" "\r"
    done
}

versioncheck() {
    #新しいバージョン
    rm -r ./newversion.txt
    curl -sl https://akari.fiid.net/app/amb/newversion.txt >newversion.txt
    if [ $version = $newversion ]; then
        echo -e '現在のambは\e[1;37;32m最新バージョン\e[0mで実行中です '
    else
        echo "最新のデータをダウンロードしますか?"
        echo "使用可能 (Y)es / (N)o"
        read Newversiondata
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

#新型
botstart() {
    while :; do
        #discordファイルが存在するかチェック
        SCROLLFILECHECK1
        if [ -e $SYSTEMFILE ]; then
            echo "SYSTEMファイルの確認に成功! 1/3"
            #musicファイルが存在するかチェック
            SCROLLFILECHECK2
            if [ -e $SYSTEMFILEMUSIC ]; then
                echo "SYSTEMファイルの確認に成功! 2/3"
                #jarファイルがあるかチェック
                SCROLLFILECHECK3
                if [ -e $JAR ]; then
                    echo "SYSTEMファイルの確認に成功! 3/3"
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
                    echo "ERROR SYSTEMファイルの確認に失敗 3/3"
                    echo "JARファイルが存在しません"
                    echo "JARファイルをダウンロードしますか?"
                    echo "使用可能 (y)es (n)o"
                    while :; do
                        read INPUT_DATA
                        if [ $INPUT_DATA = y ]; then
                            echo "$FILEDONWLOADSTART"
                            wget -q https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION-$EDITION.jar
                            if [[ -e JMusicBot-$VERSION-$EDITION.jar ]]; then
                                mv ./JMusicBot-$VERSION-$EDITION.jar $SELF_DIR_PATH/discord/music/
                                if [[-e $SELF_DIR_PATH/discord/music/JMusicBot-$VERSION-$EDITION.jar ]]; then
                                    echo "ファイルの移動に成功しました"
                                fi
                            fi
                        elif [ $INPUT_DATA = n ]; then
                            echo "JARファイルのダウンロードをキャンセルしました。"
                            echo "サービスを終了します"
                            exit 0
                        else
                            echo "(y)es又は(n)oを入力してください"
                        fi
                    done
                fi
            else
                echo "SYSTEMファイルの確認に成功! 2/3"
                echo "musicファイルが不足しています。"
                echo "$FILECREATESTART"
                mkdir "discord/music/"
                if [ -e discord/music/ ]; then
                    echo "$FILECREATESUCCESS"
                else
                    echo "$FILECREATEFAILED"
                fi
            fi
        #discordファイルが無かった場合
        else
            echo "SYSTEMファイルの確認に成功! 1/3"
            echo "discordファイルが不足しています。"
            echo "$FILECREATESTART"
            mkdir "discord"
            if [ -e discord ]; then
                echo "$FILECREATESUCCESS"
            else
                echo "$FILECREATEFAILED"
            fi
        fi
    done
}

newbotstart() {
    while :; do
        #discordファイルが存在するかチェック
        SCROLLFILECHECK1
        if [ -e $SYSTEMFILE ]; then
            if [[ $ERRORCODE = bu8Oong5 ]]; then
                echo "ファイルの作成に成功しました"
            fi
            echo "SYSTEMファイルの確認に成功! 1/3"
        else
            echo -e "\e[31mERROR\e[m: SYSTEMファイルの確認に失敗 1/3"
            echo "ファイルの作成を開始します。"
            PROGRESS_STATUS="ファイルの作成中"
            SCROLL
            mkdir "discord"
            ERRORCODE="bu8Oong5"
        fi
        #musicファイルが存在するかチェック
        SCROLLFILECHECK2
        if [ -e $SYSTEMFILEMUSIC ]; then
            if [[ $ERRORCODE = foo3UCa4 ]]; then
                echo "ファイルの作成に成功しました"
            fi
            echo "SYSTEMファイルの確認に成功! 2/3"
        else
            echo -e "\e[31mERROR\e[m: SYSTEMファイルの確認に失敗 2/3"
            echo "ファイルの作成を開始します。"
            PROGRESS_STATUS="ファイルの作成中"
            SCROLL
            mkdir "discord/music"
            ERRORCODE="foo3UCa4"
        fi
        #jarファイルがあるかチェック
        SCROLLFILECHECK3
        if [ -e $JAR ]; then
            echo "SYSTEMファイルの確認に成功! 3/3"
            chmod 755 ./discord/music/JMusicBot-$VERSION-$EDITION.jar &
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
            *)
                #起動した際の終了コマンド等以外を入力した際の処理
                echo "変なキー入力"
                ;;
            esac
        else
            echo -e "\e[31mERROR\e[m: SYSTEMファイルの確認に失敗 3/3"
            echo "ファイルをダウンロードしますか? (使用可能: (Y)es or (N)o"
            while [ ! -e $JAR ]; do
                read -p ">" INPUT_DATA
                case $INPUT_DATA in
                [yY])
                    while [[ $progress_status != SUCCESS ]]; do
                        PROGRESS_STATUS="ファイルの確認中"
                        SCROLL
                        if [ -e $JAR ]; then
                            echo "ダウンロードに成功しました。"
                            #実行権限付与(暫定的)
                            chmod 755 ./discord/music/JMusicBot-$VERSION-$EDITION.jar &
                            break
                        else
                            PROGRESS_STATUS="ファイルのダウンロード中"
                            wget -q https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION-$EDITION.jar -O ./discord/music/JMusicBot-$VERSION-$EDITION.jar &
                            PROGRESS_STATUS="ファイルの確認中"
                            #実行権限付与
                            chmod 755 ./discord/music/JMusicBot-$VERSION-$EDITION.jar &
                        fi
                    done
                    ;;
                [nN])
                    echo "キャンセルしました。"
                    echo "サービスを終了します。"
                    ;;
                *)
                    echo "(Y)es or (N)o で入力してください"
                    ;;
                esac
            done
        fi
    done
}

#旧型
oldbotstart() {
    echo "SYSTEMFILEが存在するか確認しています..."
    echo "ファイルを確認中 1/2"
    if [ -e $SYSTEMFILE ]; then
        echo "$FILECHECKSUCCSESS"
        echo "ファイルを確認中 2/2"
        if [ -e $SYSTEMFILEMUSIC ]; then
            echo "$FILECHECKSUCCSESS"
            echo "$SYSTEMSTART"
            systemstart
        else
            echo "$FILECHECKFAILED"
            echo "$FAILECREATE"
            mkdir "discord/music/"
            echo "$SYSTEMSTART"
            systemstart
        fi
    else
        echo "SYSTEMFILEが欠落しています"
        mkdir "discord"
        echo "$FILECREATESUCCESS"
        echo "ファイルを確認中 2/2"
        if [ -e $SYSTEMFILEMUSIC ]; then
            echo "$FILECHECKSUCCSESS"
            echo "$SYSTEMSTART"
            systemstart
        else
            echo "$FILECHECKFAILED"
            echo "$FAILECREATE"
            mkdir "discord/music/"
            echo "$SYSTEMSTART"
            systemstart
        fi
        if [ -e $SYSTEMFILE ]; then
            echo "$FILECHECKSUCCSESS"
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
        #sudo chmod u+x $JAR
        chmod u+x $JAR
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
            echo "$FILEDOWNLOADSTART"
            wget -q https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION-$EDITION.jar
            if [ -e $JAR ]; then
                echo "$FILEDOWNLOADFAILED"
                exit
            else
                echo "$FILEDOWNLOADUCCESS"
            fi
            mv ./JMusicBot-$VERSION-$EDITION.jar $SELF_DIR_PATH/discord/music/
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
                    echo "$SERVICEALIVE(未実装です)"
                fi
                echo "$ENDSERVICE"
                exit
                ;;
            esac
            #            read -p "テスト" SERVICEEXIT
            #            case "$SERVICEEXIT" in
            #            [yY])
            #                echo "$SERVICECHECK"
            #                count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
            #                if [ $count = 0 ]; then
            #                    echo "$SERVICEDEAD"
            #                else
            #                    echo "$SERVICEALIVE"
            #                fi
            #                echo "$ENDSERVICE"
            #                exit
            #                ;;
            #            esac
            #            ;;
            #        [nN]) echo "$ENDSERVICE" ;;
            #        *) ;;
            ;;
        esac
    fi
}

#------------------------------------------------------------------------------#
case $1 in
newbotstart)
    newbotstart
    ;;

vercheck)
    firststart
    if [ -e ./newversion.txt ]; then
        vcheck
    else
        echo "$FILEFALSE"
        curl -sl https://akari.fiid.net/app/amb/newversion.txt >newversion.txt
        echo "正常な動作を行うため、もうⅠ度実行を宜しくおねがいします。"
    fi
    ;;

start)
    firststart
    if [ yes = $setting_outputdata ]; then
        autoreconfig
        if [ -z "$CLIENT_ID" ]; then
            echo "CLIENT_IDを入力してください"
            read INPUT_CLIENTID
            sed -i -e 's/CLIENT_ID="'$CLIENT_ID'"/CLIENT_ID="'$INPUT_CLIENTID'"/g' ./assets/settings.txt
            echo "BOTの招待URL: https://discordapp.com/api/oauth2/authorize?client_id=$INPUT_CLIENTID&permissions=8&scope=bot"
        fi
        if [ yes = $setting_VersionCheck ]; then
            versioncheck
        fi
        botstart
    fi
    ;;

"start-d")
    firststart
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
    firststart
    count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
    if [ $count = 0 ]; then
        echo -e "BOTSTATUS: \033[0;31mOFFLINE\033"
    else
        echo -e 'BOTSTATUS: \e[1;37;32mONLINE\e[0m'
    fi
    ;;
time)
    firststart
    if [ $permission1 = 1 ]; then
        echo "現在時刻を表示します。 (終了する場合はCtrl + c)"
        while true; do
            echo -e "$(date +%H:%M:%S)\r\c"
            sleep 1
        done
    else
        echo "拡張機能が有効ではありません!"
        echo "extensionコマンドで有効にしてから再度実行をよろしくおねがいします。"
    fi
    ;;
#廃止予定です
remove)
    firststart
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
    firststart
    echo "現在のCLIENT_IDは $CLIENT_ID に設定されています。"
    echo -e "変更する場合は \033[0;31msetclientid\033[0;39m をお使いください"
    ;;

setclientid)
    firststart
    echo "CLIENT_IDを入力してください"
    read INPUT_CLIENTID
    sed -i -e 's/CLIENT_ID="'$CLIENT_ID'"/CLIENT_ID="'$INPUT_CLIENTID'"/g' ./assets/settings.txt
    echo -e "CLIENT_IDを \033[0;31m$INPUT_CLIENTID\033[0;39m に変更しました"
    ;;

#===========#
#InviteBOT  #
#===========#

invite)
    firststart
    echo "BOTの招待URL: https://discordapp.com/api/oauth2/authorize?client_id=$CLIENT_ID&permissions=8&scope=bot"
    ;;

#===========#
#Token関係　 #
#===========#
token)
    firststart
    echo -e "現在のTokenは $token_  です。"
    echo -e "変更する場合は \033[0;31msettoken\033[0;39m をお使いください"
    ;;
setoken)
    firststart
    echo "TOKENを入力してください"
    read SETTOKEN
    sed -i -e "s/$TOKEN/token = $SETTOKEN/g" $FILE/config.txt
    ;;
prefix)
    firststart
    echo -e "$prefix_ です。変更する場合はSETPREFIXをお使いください"
    ;;
status)
    firststart
    echo -e "現在のステータスは $status_ です。"
    echo -e "変更する場合は \033[0;31msetstatus\033[0;39m をお使いください"
    ;;
createconfig)
    firststart
    if [ -e $target ]; then
        sed -i 's/"//g' $CONFIGFILE
        main
    else
        echo "$FAILNOTFOUND"
    fi
    ;;
reconfig)
    firststart
    . ./lib/reconfig.sh
    ;;
dev)
    firststart
    if [ -n "$YOURNAME" ]; then
        if [ -n "$KEISHOU" ]; then
            echo -e '\e[1;37;32mようこそ'$YOURNAME$KEISHOU'\e[0m'
        else
            echo -e '\e[1;37;32mようこそ'$YOURNAME様'\e[0m'
        fi
    else
        if [ -n "$KEISHOU" ]; then
            echo -e '\e[1;37;32mようこそ開発者'$KEISHOU'\e[0m'
        else
            echo -e '\e[1;37;32mようこそ開発者様\e[0m'
        fi
    fi
    echo "ここでは試験段階の機能を試すことができます"
    echo "何をしますか?"
    echo "1.自分の名前を決める"
    echo "2.呼ぶさいの敬称を決める"
    echo "新型起動方法を実行する"
    read dev
    case "$dev" in
    [1])
        echo "呼んでほしい名前を書いてください"
        echo "入力待ち..."
        read INPUT_YOURNAME
        sed -i -e 's/YOURNAME="'$YOURNAME'"/YOURNAME="'$INPUT_YOURNAME'"/' ./assets/userdata/allsettings.txt
        echo "名前を覚えましたよ! $INPUT_YOURNAMEさん!"
        ;;
    [2])
        clear
        echo "1. さん"
        echo "2. くん"
        echo "3. 様"
        echo "4. ちゃん"
        echo "5. きゅん"
        echo "6. 陛下"
        echo "7. 殿下"
        echo "8. 自分で設定"
        read dev2
        case "$dev2" in
        [1])
            sed -i -e 's/KEISHOU="'$KEISHOU'"/KEISHOU="'さん'"/' ./assets/userdata/allsettings.txt
            ;;
        [2])
            sed -i -e 's/KEISHOU="'$KEISHOU'"/KEISHOU="'くん'"/' ./assets/userdata/allsettings.txt
            ;;
        [3])
            sed -i -e 's/KEISHOU="'$KEISHOU'"/KEISHOU="'様'"/' ./assets/userdata/allsettings.txt
            ;;
        [4])
            sed -i -e 's/KEISHOU="'$KEISHOU'"/KEISHOU="'ちゃん'"/' ./assets/userdata/allsettings.txt
            ;;
        [5])
            sed -i -e 's/KEISHOU="'$KEISHOU'"/KEISHOU="'きゅん'"/' ./assets/userdata/allsettings.txt
            ;;
        [6])
            sed -i -e 's/KEISHOU="'$KEISHOU'"/KEISHOU="'陛下'"/' ./assets/userdata/allsettings.txt
            ;;
        [7])
            sed -i -e 's/KEISHOU="'$KEISHOU'"/KEISHOU="'殿下'"/' ./assets/userdata/allsettings.txt
            ;;
        [8])
            read ORIGINAL_KEISHOU
            sed -i -e 's/KEISHOU="'$KEISHOU'"/KEISHOU="'$ORIGINAL_KEISHOU'"/' ./assets/userdata/allsettings.txt
            ;;
        esac
        ;;
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
    firststart
    . ./lib/setSettings.sh
    ;;

extension)
    firststart
    echo "拡張機能の有効化"
    echo "有効にしたい拡張機能を選択してください."
    echo "⚠    有効化せずに、コマンドを使用することはできません"
    echo "1.現在時刻の表示"
    echo "   ┗  現在の設定: $setting_VersionCheck"
    read setsettings
    case "$setsettings" in
    [1])
        while :; do
            echo "使用可能: (y)es / (n)o"
            echo "入力待ち..."
            read setsettings
            if [ $setsettings = y ]; then
                sed -i -e 's/permission1="'$permission1'"/permission1="1"/' ./assets/permissions.txt
                echo "拡張機能を有効化しました!"
                exit 0
            elif [ $setsettings = n ]; then
                sed -i -e 's/permission1="'$permission1'"/permission1="0"/' ./assets/permissions.txt
                echo "拡張機能を無効化しました"
                exit 0
            else
                echo "y or nを打ってね!"
            fi
        done

        #        echo "Extension.txtが存在するか確認しています..."
        #        if [ -e ./assets/settings.txt ]; then
        #            echo "使用可能: yes/no"
        #            read updatecheck
        #            if [ $updatecheck = $setting_VersionCheck ]; then
        #                echo "既に設定は "$setting_VersionCheck" に選択されています"
        #            else
        #                sed -i -e 's/setting_VersionCheck="'$setting_VersionCheck'"/setting_VersionCheck="'$updatecheck'"/' ./assets/settings.txt
        #                if [ $updatecheck = $setting_VersionCheck ]; then
        #                    echo "変更に失敗しました..."
        #                else
        #                    echo "変更に成功しました!"
        #                fi
        #            fi
        #        else
        #            echo "SettingsFileが存在しません..."
        #            echo "exit 1"
        #        fi
        ;;
    esac
    ;;

#開発者向けコマンド
removedev)
    firststart
    if [ -e $PASSWORDDILECTORY ]; then
        echo "過去のログイン記録を参照中..."
        #１度目の初回入力でパスワードを入力しなかった場合、ご自分で
        #paswword.txtにパスワードを記入しても、正常に動作しなくなる可能性がある。
        #バグ有り
        if [[ aXeHBw1dh8QLPhVuw40N = $password ]]; then
            echo "認証に成功..."
            if [ -n "$YOURNAME" ]; then
                if [ -n "$KEISHOU" ]; then
                    echo -e '\e[1;37;32mようこそ'$YOURNAME$KEISHOU'\e[0m'
                else
                    echo -e '\e[1;37;32mようこそ'$YOURNAME様'\e[0m'
                fi
            else
                if [ -n "$KEISHOU" ]; then
                    echo -e '\e[1;37;32mようこそ開発者'$KEISHOU'\e[0m'
                else
                    echo -e '\e[1;37;32mようこそ開発者様\e[0m'
                fi
            fi
            echo "削除するファイルを指定してください"
            echo "1.JARファイルを削除"
            echo "2.OUTDATA.txtを削除"
            echo "3.BOTの設定ファイルの削除"
            echo "変更したい設定の番号を入力してください..."
            read setsettings
            case "$setsettings" in
            [1])
                echo "SettingsFileの有無を確認しています"
                if [ -e $JAR ]; then
                    echo "使用可能: (y)es/(n)o"
                    read removeve
                    if [ $removeve = y ]; then
                        rm $JAR
                    else
                        echo "ファイルの削除をキャンセルしました。"
                    fi
                else
                    echo "SettingsFileが存在しません..."
                    echo "exit 1"
                fi
                ;;
            esac
        else
            echo "おや?どうやら開発者モードの初回起動時になにか問題があったようで、パスワードがきちんと入力できていないようです..."
            echo "引き続き開発者モードを有効化する場合は、パスワードを入力してください..."
            while :; do
                if [[ $RETRYCOUNT = 3 ]]; then
                    echo "www"
                    break
                else
                    read devpassword
                    if [ $devpassword = aXeHBw1dh8QLPhVuw40N ]; then
                        echo "password="aXeHBw1dh8QLPhVuw40N"" >./assets/password.txt
                        echo "パスワード認証に成功しました!"
                        break
                    else
                        echo "パスワードが間違っています。"
                        RETRYCOUNT=$((RETRYCOUNT + 1))
                    fi
                fi
            done
        fi
    else
        echo "開発者モードを初めて使用するため、必要なファイルを作成します"
        touch ./assets/password.txt
        echo "開発者モードを有効化するためにはパスワードを入力する必要が有ります"
        echo "パスワードを入力してください..."
        read devpassword
        if [ $devpassword = aXeHBw1dh8QLPhVuw40N ]; then
            echo "password="aXeHBw1dh8QLPhVuw40N"" >./assets/password.txt
        fi
    fi
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
    ;;
esac
exit 0
