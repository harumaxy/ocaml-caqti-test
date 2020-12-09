stanza = 一節、語句

`dune`ファイルで `exacutable` stanza を定義すると、
複数の実行可能ファイルを定義できる。

OCaml の エントリーポイントを別の名前で分けることは、ライブラリの小さなラッパーの小さいロジックを
効率的にたくさんかける。

- get logs
- migrate db
- rollback db
- batch operation
- etc...

`public_names` stanza は必須
ただし、`names` stanza を同時に定義しているときは、`public_names` stanza を別名にすることができる？


# executables vs single entory point

実際には、サブコマンドやコマンド引数を取ることで、一つのバイナリにすべての動作を詰め込むことができる

- Arg
- cmdliner
- Core.Command (Jane Street)


