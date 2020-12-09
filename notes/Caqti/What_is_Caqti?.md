
使い方の記事
https://medium.com/@bobbypriambodo/interfacing-ocaml-and-postgresql-with-caqti-a92515bdaa11

- type-safe な SQL を書ける
  - SQL の引数、戻り値を単純な型 or タプルにコンバート
- Lwt を使った Asyncronous/Cooperating
- コネクションプーリング
- `postgres://user:secret@host:port` というシンプルなurlで接続できる


- 単純な SELECT, CREATE, UPDATE, DELETE の他に、 CREATE (TEMP) TABLE や Transaction もできそう
- Knex より遥かにいい