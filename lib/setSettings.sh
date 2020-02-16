#!/bin/bash
while :; do
    PROGRESS_STATUS="ファイルの確認中    "
    SCROLL
    if [ -e ./assets/settings.txt ]; then
        PROGRESS_STATUS="ファイルの確認に成功"
        SCROLL
        break
    else
        echo "設定ファイルが存在しないため、動作を停止します。"
    fi
done
while :; do
. ./assets/settings.txt
    echo "どの設定を変更しますか?"
    echo "1.Botを起動した際にアップデートを確認する | 2.Botを起動した際にBOTの招待リンクを表示する"
    echo "   ┗  現在の設定: $setting_VersionCheck             |           ┗  現在の設定: $setting_botinvite"
    echo "3.Botを起動した際にTOKEN等の情報を更新する| 4.Botを起動した際Backupを取るかどうか"
    echo "   ┗  現在の設定: $setting_outputdata             |           ┗  現在の設定: $setting_backuptime"
    echo "5.動作に失敗した際何回リトライするか"
    echo "   ┗  現在の設定: ${RETRYMAX}回"
    echo "変更したい設定の番号を入力してください..."
    read -p ">" setsettings
    case "$setsettings" in
    [1])
        #バージョンチェックの設定
        echo "使用可能 (Y)es (N)o"
        while :; do
            read INPUT_DATA
            #YESの場合
            if [ $INPUT_DATA = y ]; then
                #既に設定がその値になってないかをチェック
                if [ yes = $setting_VersionCheck ]; then
                    echo -e "\e[31mERROR\e[m: 既に設定は "$setting_VersionCheck" に選択されています"
                    break
                else
                    sed -i -e 's/setting_VersionCheck="'$setting_VersionCheck'"/setting_VersionCheck="'yes'"/' ./assets/settings.txt
                    echo "設定を YES に変更しました"
                    break
                fi
            #NOの場合
            elif [ $INPUT_DATA = n ]; then
                #既に設定がその値になってないかをチェック
                if [ no = $setting_VersionCheck ]; then
                    echo -e "\e[31mERROR\e[m: 既に設定は "$setting_VersionCheck" に選択されています"
                    break
                else
                    sed -i -e 's/setting_VersionCheck="'$setting_VersionCheck'"/setting_VersionCheck="'no'"/' ./assets/settings.txt
                    echo "設定を NO に変更しました"
                    break
                fi
            else
                echo "y or n を入力してください "
            fi
        done
        ;;
    [2])
        echo "使用可能 (Y)es (N)o"
        while :; do
            read INPUT_DATA
            #YESの場合
            if [ yes = y ]; then
                #既に設定がその値になってないかをチェック
                if [ $INPUT_DATA = $setting_botinvite ]; then
                    echo -e "\e[31mERROR\e[m: 既に設定は "$setting_botinvite" に選択されています"
                    break
                else
                    sed -i -e 's/setting_botinvite="'$setting_botinvite'"/setting_botinvite="'yes'"/' ./assets/settings.txt
                    echo "設定を YES に変更しました"
                    break
                fi
            #NOの場合
            elif [ $INPUT_DATA = n ]; then
                #既に設定がその値になってないかをチェック
                if [ no = $setting_botinvite ]; then
                    echo -e "\e[31mERROR\e[m: 既に設定は "$setting_botinvite" に選択されています"
                    break
                else
                    sed -i -e 's/setting_botinvite="'$setting_botinvite'"/setting_botinvite="'no'"/' ./assets/settings.txt
                    echo "設定を NO に変更しました"
                    break
                fi
            else
                echo "y or n を入力してください "
            fi
        done
        ;;
    [3])
        #BOTを起動した際データを再生成するか
        echo "使用可能 (Y)es (N)o"
        while :; do
            read INPUT_DATA
            #YESの場合
            if [ $INPUT_DATA = y ]; then
                #既に設定がその値になってないかをチェック
                if [ yes = $setting_outputdata ]; then
                    echo -e "\e[31mERROR\e[m: 既に設定は "$setting_outputdata" に選択されています"
                    break
                else
                    sed -i -e 's/setting_outputdata="'$setting_outputdata'"/setting_outputdata="'yes'"/' ./assets/settings.txt
                    echo "設定を YES に変更しました"
                    break
                fi
            #NOの場合
            elif [ $INPUT_DATA = n ]; then
                #既に設定がその値になってないかをチェック
                if [ no = $setting_outputdata ]; then
                    echo -e "\e[31mERROR\e[m: 既に設定は "$setting_outputdata" に選択されています"
                    break
                else
                    sed -i -e 's/setting_outputdata="'$setting_outputdata'"/setting_outputdata="'no'"/' ./assets/settings.txt
                    echo "設定を NO に変更しました"
                    break
                fi
            else
                echo "y or n を入力してください "
            fi
        done

        ;;
    [4])
        #バックアップするかどうかの設定
        echo "使用可能 (Y)es (N)o"
        while :; do
            read INPUT_DATA
            #YESの場合
            if [ $INPUT_DATA = y ]; then
                #既に設定がその値になってないかをチェック
                if [ yes = $setting_backuptime ]; then
                    echo -e "\e[31mERROR\e[m: 既に設定は "$setting_backuptime" に選択されています"
                    break
                else
                    sed -i -e 's/setting_backuptime="'$setting_backuptime'"/setting_backuptime="'yes'"/' ./assets/settings.txt
                    echo "設定を YES に変更しました"
                    break
                fi
            #NOの場合
            elif [ $INPUT_DATA = n ]; then
                #既に設定がその値になってないかをチェック
                if [ no = $setting_backuptime ]; then
                    echo -e "\e[31mERROR\e[m: 既に設定は "$setting_backuptime" に選択されています"
                    break
                else
                    sed -i -e 's/setting_backuptime="'$setting_backuptime'"/setting_backuptime="'no'"/' ./assets/settings.txt
                    echo "設定を NO に変更しました"
                    break
                fi
            else
                echo "y or n を入力してください "
            fi
        done
        ;;
    [5])
        #リトライ上限
        echo "使用可能 数字全般"
        while :; do
            read INPUT_DATA
            #YESの場合
            if [ -n "$INPUT_DATA" ]; then
                if expr "$INPUT_DATA" : '[0-9]*'; then
                    #既に設定がその値になってないかをチェック
                    if [ $INPUT_DATA = $RETRYMAX ]; then
                        echo -e "\e[31mERROR\e[m: 既に設定は "$RETRYMAX" に選択されています"
                        break
                    else
                        sed -i -e 's/RETRYMAX="'$RETRYMAX'"/RETRYMAX="'$INPUT_DATA'"/' ./assets/settings.txt
                        echo "リトライ回数を ${INPUT_DATA} 回に変更しました"
                        break
                    fi
                else
                    echo "数字を入力してください"
                fi
            else
                echo "空白を使用するとサービスが動作しなくなる可能性があるため、お控えください。"
            fi
        done
        ;;
    esac
done
