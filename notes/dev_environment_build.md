# 簡単開発環境構築


### ocaml compiler
```sh
opam switch install <最新バージョン(4.11.~がおすすめ)> 
```

### dev tools

1. [VS Code Ocaml Platform extension](https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform)
2. ocaml-lsp-server
3. ocamlformat

opam switch install で作成したスイッチは、別々の環境とみなされる。
ライブラリーも最初からインストールし直し


#### Dune とかは？
`ocaml-lsp-server` をインストールすると、開発に必要なものはほぼ全て
dependency としてインストールされる。

なので、VSCode 拡張と `ocaml-lsp-server` だけインストールしとけばOK.

# What is ocaml platform?

IDE 的な機能を全部ひとまとめにする
特に、VS Code の Ocaml 拡張機能をそう呼ぶ

- ocaml-lsp-sever
- merlin
- utop
- ocamlformat
- ppxlib
- ...

全部統合するプログラム
ツール間の複雑さを取り除く


