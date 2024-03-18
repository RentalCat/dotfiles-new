# npm grobal package memo
- 管理しづらいので基本は他パッケージ管理 (`brew` とか) を使っていく。

```sh
$ npm list -g | grep "── " | sed "s/.* //"
corepack@0.16.0
gnomon@1.5.0
neovim@4.10.1
npm@9.5.0
```

## corepack
- デフォルトで入ってるやつ。

## gnomon
- https://github.com/paypal/gnomon
- 行ごとの実行時間を表示してくれるツール

## n
- nodejs バージョン管理ツール (pyenv的なやつ)

## neovim
- neovim サポート

## npm
- nodejs パッケージ管理ツール (pip的なやつ)
