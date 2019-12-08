#!/bin/bash
#------------------------------------------------------------------------------#
#外部ファイル読み込み
. ./assets/outdate.txt
. ./assets/language/ja.txt
. ./assets/commands.txt
. ./assets/variable.txt
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
#------------------------------------------------------------------------------#

case $1 in
start)
    if [ -e $JAR ]; then
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
        echo "$FILEFALSE"
        read -p "$FILEDOWNLOAD " DATA
        case "$DATA" in
        [yY])
            sudo wget -v https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION-$EDITION.jar
            mv ./JMusicBot-$VERSION-$EDITION.jar /home/$USER/デスクトップ/disocrd/musicbot/
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
    ;;
"start -d")
    if [ -e $JAR ]; then
        echo "$FILETRUE"
        echo "$BOTSTART"
        echo "開発者モードで起動します"
        echo "ログが大量に流れるためキャンセルする場合 Ctrl + c を押してください"
        echo "3秒後に実行します"
        echo "残り3秒"
        sleep 1
        echo "残り2秒"
        sleep 1
        echo "残り1秒"
        sleep 1
        echo "STARTING!!"
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
            mv ./JMusicBot-$VERSION-$EDITION.jar /home/$USER/デスクトップ/disocrd/musicbot/
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
CREATECONFIG)
    if [ -e $target ]; then
        main
    else
        echo "ファイルが存在しません"
    fi
    ;;
RECONFIG)
    $main
    ;;
CLEANCONFIG)
        read -p "$FILEDELETED " CLEANCONFI
case "$CLEANCONFI" in
        [yY])
            echo "ファイルの削除を開始します"
            $CLEANCONFIG
            echo "ファイル有無を確認しています"
            if [ -e ./assets/outdate.txt ]; then
                echo "ファイルが存在しない、又は削除に失敗しました"
                    else
                echo "ファイルの削除に成功しました"
            fi
            ;;
        [nN]) 
        
            ;;
        *) ;;
        esac
    ;;
    
#動作しません。
#setprefix)
#        read SETPREFIX
#    sed -e 's/$PREFIX/prefix = $SETPREFIX/g' $FILE/config.txt
#
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
    echo -e "\033[0;31mCLEANCONFIG\033[1;39m: 出力したファイルを削除します"
    ;;
esac
exit 0
