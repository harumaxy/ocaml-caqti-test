(lang dune 2.3)

(name lib)

; dune-project ファイルで設定したメタデータを使って `.opam`ファイルを自動生成する

(generate_opam_files true)

; 暗黙的に依存のバージョンを更新するか

(implicit_transitive_deps true)

(package
 (name lib)
 (license MIT)
 (authors max)
 (maintainers max)
 (synopsis "hello")
 (description "world")
 (depends lwt lwt_ppx caqti caqti-lwt caqti-driver-postgresql))
