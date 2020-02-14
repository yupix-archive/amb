#!/bin/bash
while :; do
    if [[ $COUNT != $RETRYMAX ]]; then
        for ((i = 0; i < ${#chars}; i++)); do
            sleep 0.1
            echo -en "${chars:$i:1} ファイルの確認 " "\r"
        done
        if [ -e ./discord/music/config.txt ]; then
            if [ -e ./discord/music/config-back.txt ]; then
                rm ./discord/music/config-back.txt
            fi
            cp ./discord/music/config.txt ./discord/music/config-back.txt
            sed -i -e "s/\"//" ./discord/music/config-back.txt
            sed -i -e "s/\"//" ./discord/music/config-back.txt
            #もとのデータを削除
            if [ -e ./assets/outdata.txt ]; then
                for ((i = 0; i < ${#chars}; i++)); do
                    sleep 0.1
                    echo -en "${chars:$i:1} ファイルの確認 " "\r"
                done
                rm -r ./assets/outdata.txt
                for ((i = 0; i < ${#chars}; i++)); do
                    sleep 0.1
                    echo -en "${chars:$i:1} ファイルの削除中 " "\r"
                done
                #削除できたか確認
                for ((i = 0; i < ${#chars}; i++)); do
                    sleep 0.1
                    echo -en "${chars:$i:1} ファイルの確認中 " "\r"
                done
                if [ -e ./assets/outdata.txt ]; then
                    echo "ファイルの削除に失敗しました。"
                else
                    echo "ファイルの削除に成功しました。"
                    echo "ファイルの生成を開始します。"
                    for ((i = 0; i < ${#chars}; i++)); do
                        sleep 0.1
                        echo -en "${chars:$i:1} ファイルの作成中 " "\r"
                    done
                    cat ${target} | awk -f ./lib/convert.awk >./assets/outdata.txt
                    for ((i = 0; i < ${#chars}; i++)); do
                        sleep 0.1
                        echo -en "${chars:$i:1} ファイルの確認中 " "\r"
                        if [ -e ./assets/outdata.txt ]; then
                            echo "ファイルの生成に成功しました。"
                            break
                            exit 0
                        else
                            echo "ファイルの生成に失敗しました。"
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
                    done
                fi
            else
                echo "出力ファイルが存在しません。"
                echo "ファイルの生成を開始します。"
                for ((i = 0; i < ${#chars}; i++)); do
                    sleep 0.1
                    echo -en "${chars:$i:1} ファイルの作成中 " "\r"
                done
                cat ${target} | awk -f ./lib/convert.awk >./assets/outdata.txt
                for ((i = 0; i < ${#chars}; i++)); do
                    sleep 0.1
                    echo -en "${chars:$i:1} ファイルの確認中 " "\r"
                    if [ -e ./assets/outdata.txt ]; then
                        echo "ファイルの生成に成功しました。"
                        exit 0
                    else
                        echo "ファイルの生成に失敗しました。"
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
                done
            fi
            exit 0
        else
            COUNT=$((COUNT + 1))
            echo "ファイルが存在しません。"
            echo "失敗数: $COUNT"
        fi
    else
        echo "失敗数が上限を超えたため、自動的に停止しました。"
        exit 0
    fi
done
