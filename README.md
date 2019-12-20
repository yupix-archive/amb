![AUTOMUSICBOT](https://akari.fiid.net/images/AUTOMUSICBOT.jpg "Image")
# amb
AutoMusicBot DiscordのBotを自動でダウンロードから、管理を行います。
MainSystemに関してはほぼ99%程はyupixが作成しています。

## このProjectに関して
本Projectの大幅な機能などはyupixが作成しております。
本Project内に存在するAWKの管理などをsousuke0422さんがおこなっています。
次に、本Projectでは[JMusicBot](https://github.com/jagrosh/MusicBot/releases)を使用しております。
JMusicBotの作者様、その他の関係者様等の方々がいて
成り立っている物です、そのあたりをご理解の上、お使いください。

## 動作環境
本Projectではechoの色を付けるのに -e を付けています。
そのため、Dash等のConsoleを使用すると -e がそのまま、表示される可能性が極めて高いです。
本Projectの開発は以下の環境下で行われており、動作のサポート等は基本的に以下の物を優先します。
今後その他console等にも対応する予定ですが、少々時間がかかると思われますので、宜しくおねがいします

### OS
- Ubuntu
- Windows(WSL必須)
Windowsで実行する際にwslにはubuntuを使うことを推奨します

### Shell
- Bash

## 使い方
### Linux:
1.projectをclone
'git clone git@github.com:yupix/amb.git'
2.linux.shに実行権限を付与する
4.動作を確認する
例:
'./linux.sh vercheck'

### Windows:
```diff
- **警告** git for windows で入手する際の注意点
```
Git for Windows のインストール後、改行コードを自動で変更する設定が有効になっている
可能性が高くCRLFに自動変換されてしまいます。
改行コードがLFでないと正常に動作しないため、
以下のコマンドを必ず実行する必要が有ります
> git config --global core.autoCRLF false

1.wsl の有効化
2.windows.bat 又はwsl上で linux.sh vercheck の実行


## author
- [MainSYSTEM / yupix](https://github.com/yupix/)
- [SubSYSTEM / sousuke0422](https://github.com/sousuke0422/)

## SpecialThanks
本Projectを作るきっかけとなった物です、この場で心より感謝申し上げます。
[JMusicBot](https://github.com/jagrosh/MusicBot/releases)

## サポート
バグの発見または機能の追加に付きましては以下のページ等に報告していただけると助かります。
Issuesは確認までに時間がかかると思われます、早めの対応を
望む場合はDiscordへの参加を推奨します。
- [Discord](https://discord.gg/uDNyePY)
- [issues](https://github.com/yupix/amb/issues)

## ２時配布に関して
現在本Projectは多くのバグなどを抱えています。
そのため、本Projectを2次配布等をする際、アップデート先の
URLを変更するなどすると修正パッチが正しく適応されないなどの重大な問題が発生する可能性が極めて高いです。
その他、改造された物などは、yupixによって追加された機能以外が存在する可能性があるため、
今永久的なサポートを受けるには本Projectの2次配布をお控えください。ご協力お願いします
