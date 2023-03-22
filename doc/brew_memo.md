# Brewfile memo
- ` brew bundle dump --force --describe 'comment' --file $XDG_CONFIG_HOME/Brewfile` で現在インストール中のライブラリをBrewfileに上書き
- ` brew bundle cleanup --force --file $XDG_CONFIG_HOME/Brewfile` でBrewfileの内容を反映 (不要ライブラリはアンインストールされる)
## taps
### bundle
- Brewfile をサポートするためのtap

## brew installs
### asdf
- anyenvに変わる言語バージョン管理ツール
### direnv
- ディレクトリ毎に環境変数書き換えるやつ
### fontforge
- NerdFontを自前で作成するのに使う。
  - ref: [Ricty DiminishedとNerd Fontsを合成する方法(Mac) - Qiita](https://qiita.com/uhooi/items/dc9a9657f1706283753b)
- それ以外ではあまり使わないので作成し終わったら消してもいいかも。
### fzf
- FuZzy Finder
- インタラクティブなコマンド選択を用意してくれる。
- 履歴を始め色々なところで使っている
### git
### git-lfs
- 大きなファイルを取り扱うためのgit拡張
### glow
- MarkdownファイルをCLI上で見やすく表示する
### gnupg
- GNU Pretty Good Privacy
- 主にGithubの認証バッチをつけるのに使う
### jq
- json 整形ツール
### neovim
### pinentry-mac
- gnupg 認証時に求められるパスフレーズをMacのkeychainから呼び出すのに使う
### sheldon
- Zsh/Bashプラグインマネージャー
### the\_platinum\_searcher (pt)
- 高速なコードサーチツール
### tmux

## cask
### rancher
- docker ランチャー。k8s対応。無料。
