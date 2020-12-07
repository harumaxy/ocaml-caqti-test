(lang dune 2.3)

; dune-project ファイルで設定したメタデータを使って `.opam`ファイルを自動生成する

(generate_opam_files true)

; 暗黙的に依存のバージョンを更新するか

(implicit_transitive_deps true)

(license MIT)

(authors max)

(maintainers max)

(package
 (name mylib)
 (synopsis "hello")
 (description "world")
 (depends))

; (homepage https://harumaxy.com)
