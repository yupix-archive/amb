#!/bin/bash
echo "どの設定を変更しますか?"
echo "1.Botを起動した際にアップデートを確認する"
echo "   ┗  現在の設定: $setting_VersionCheck"
echo "2.Botを起動した際にBOTの招待リンクを表示する"
echo "   ┗  現在の設定: $setting_botinvite"
echo "3.Botを起動した際にTOKEN等の情報を更新する"
echo "   ┗  現在の設定: $setting_outputdata"
echo "4.Botを起動した際Backupを取るかどうか"
echo "   ┗  現在の設定: $setting_backuptime"
echo "変更したい設定の番号を入力してください..."
read setsettings
case "$setsettings" in
[1])
    #バージョンチェックの設定
    if [ -e ./assets/settings.txt ]; then
        echo "使用可能 (Y)es (N)o"
        while :; do
            read INPUT_DATA
            #YESの場合
            if [ $INPUT_DATA = y ]; then
                #既に設定がその値になってないかをチェック
                if [ yes = $setting_VersionCheck ]; then
                    echo "既に設定は "$setting_VersionCheck" に選択されています"
                    exit 0
                else
                    sed -i -e 's/setting_VersionCheck="'$setting_VersionCheck'"/setting_VersionCheck="'yes'"/' ./assets/settings.txt
                    echo "設定を YES に変更しました"
                    exit 0
                fi
            #NOの場合
            elif [ $INPUT_DATA = n ]; then
                #既に設定がその値になってないかをチェック
                if [ no = $setting_VersionCheck ]; then
                    echo "既に設定は "$setting_VersionCheck" に選択されています"
                    exit 0
                else
                    sed -i -e 's/setting_VersionCheck="'$setting_VersionCheck'"/setting_VersionCheck="'no'"/' ./assets/settings.txt
                    echo "設定を NO に変更しました"
                    exit 0
                fi
            else
                echo "y or n を入力してください "
            fi
        done
    else
        echo "設定ファイルが破損している、又は存在しません。"
    fi
    ;;
[2])
    if [ -e ./assets/settings.txt ]; then
        echo "使用可能 (Y)es (N)o"
        while :; do
            read INPUT_DATA
            #YESの場合
            if [ yes = y ]; then
                #既に設定がその値になってないかをチェック
                if [ $INPUT_DATA = $setting_botinvite ]; then
                    echo "既に設定は "$setting_botinvite" に選択されています"
                    exit 0
                else
                    sed -i -e 's/setting_botinvite="'$setting_botinvite'"/setting_botinvite="'yes'"/' ./assets/settings.txt
                    echo "設定を YES に変更しました"
                    exit 0
                fi
            #NOの場合
            elif [ $INPUT_DATA = n ]; then
                #既に設定がその値になってないかをチェック
                if [ no = $setting_botinvite ]; then
                    echo "既に設定は "$setting_botinvite" に選択されています"
                    exit 0
                else
                    sed -i -e 's/setting_botinvite="'$setting_botinvite'"/setting_botinvite="'no'"/' ./assets/settings.txt
                    echo "設定を NO に変更しました"
                    exit 0
                fi
            else
                echo "y or n を入力してください "
            fi
        done
    else
        echo "設定ファイルが破損している、又は存在しません。"
    fi
    ;;
[3])
    #BOTを起動した際データを再生成するか
    if [ -e ./assets/settings.txt ]; then
        echo "使用可能 (Y)es (N)o"
        while :; do
            read INPUT_DATA
            #YESの場合
            if [ $INPUT_DATA = y ]; then
                #既に設定がその値になってないかをチェック
                if [ yes = $setting_outputdata ]; then
                    echo "既に設定は "$setting_outputdata" に選択されています"
                    exit 0
                else
                    sed -i -e 's/setting_outputdata="'$setting_outputdata'"/setting_outputdata="'yes'"/' ./assets/settings.txt
                    echo "設定を YES に変更しました"
                    exit 0
                fi
            #NOの場合
            elif [ $INPUT_DATA = n ]; then
                #既に設定がその値になってないかをチェック
                if [ no = $setting_outputdata ]; then
                    echo "既に設定は "$setting_outputdata" に選択されています"
                    exit 0
                else
                    sed -i -e 's/setting_outputdata="'$setting_outputdata'"/setting_outputdata="'no'"/' ./assets/settings.txt
                    echo "設定を NO に変更しました"
                    exit 0
                fi
            else
                echo "y or n を入力してください "
            fi
        done
    else
        echo "設定ファイルが破損している、又は存在しません。"
    fi

    ;;
[4])
    #バックアップするかどうかの設定
    if [ -e ./assets/settings.txt ]; then
        echo "使用可能 (Y)es (N)o"
        while :; do
            read INPUT_DATA
            #YESの場合
            if [ $INPUT_DATA = y ]; then
                #既に設定がその値になってないかをチェック
                if [ yes = $setting_backuptime ]; then
                    echo "既に設定は "$setting_backuptime" に選択されています"
                    exit 0
                else
                    sed -i -e 's/setting_backuptime="'$setting_backuptime'"/setting_backuptime="'yes'"/' ./assets/settings.txt
                    echo "設定を YES に変更しました"
                    exit 0
                fi
            #NOの場合
            elif [ $INPUT_DATA = n ]; then
                #既に設定がその値になってないかをチェック
                if [ no = $setting_backuptime ]; then
                    echo "既に設定は "$setting_backuptime" に選択されています"
                    exit 0
                else
                    sed -i -e 's/setting_backuptime="'$setting_backuptime'"/setting_backuptime="'no'"/' ./assets/settings.txt
                    echo "設定を NO に変更しました"
                    exit 0
                fi
            else
                echo "y or n を入力してください "
            fi
        done
    else
        echo "設定ファイルが破損している、又は存在しません。"
    fi
    ;;
esac
