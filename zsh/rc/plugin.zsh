######################################################################
# zsh/rc/plugin.zsh
#   zsh のプラグイン管理
######################################################################

# プラグインマネージャーインストール (なければ)
(which sheldon > /dev/null 2>&1) || brew install sheldon

# プラグイン設定 (保存先ディレクトリとかを環境変数に入れる)
export SHELDON_CONFIG_DIR="$zsh_dir/sheldon"
export SHELDON_CONFIG_FILE="$SHELDON_CONFIG_DIR/plugins.toml"
export SHELDON_DATA_DIR="$XDG_DATA_HOME/sheldon"

# ロード
#   必要に応じてプラグインをインストール・アンインストールする
#   (`$SHELDON_DATA_DIR/sheldon/plugins.lock` ファイルを生成)
eval "$(sheldon source)"

# コマンドメモ
# - 手動でリロード: `sheldon lock`
# - プラグインを更新: `sheldon lock --update`
# - プラグイン再インストール: `sheldon lock --reinstall`
