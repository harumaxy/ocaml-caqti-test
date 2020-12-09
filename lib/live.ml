type live = { lesson_id : int; course_cd : string; class_ : string }

type error = Database_error of string

let connection_url = "postgresql://postgres:maxy8821@localhost:5432"

(* Caqti_lwt : グリーンスレッドを使った非同期処理、並列処理をするCaqti *)
(* Caqti_lwt.Pool : コネクションプール機能のためのモジュール。Caqti のクエリをこのモジュールを介して実行することでプールを利用できる *)
let pool =
  match Caqti_lwt.connect_pool ~max_size:5 (Uri.of_string connection_url) with
  | Ok pool -> pool
  | Error err -> failwith (Caqti_error.show err)

let or_error m =
  match%lwt m with
  | Ok a -> Ok a |> Lwt.return
  | Error e -> Error (Database_error (Caqti_error.show e)) |> Lwt.return

(* Caqti_reqest.exec 関数 *)
(* migrate, rollback など、戻り値のない DB 操作には exec を使う *)

let migrate_query =
  Caqti_request.exec Caqti_type.unit
    {|
    CREATE TABLE lives (
      lesson_id SERIAL NOT NULL PRIMARY KEY,
      course_cd text NOT NULL,
      class text Not NULL
    )
  |}

let migrate () =
  let migrate' (module C : Caqti_lwt.CONNECTION) = C.exec migrate_query () in
  Caqti_lwt.Pool.use migrate' pool |> or_error

let rollback_query = Caqti_request.exec Caqti_type.unit "DROP TABLE lives"

let rollback () =
  let rollback' (module C : Caqti_lwt.CONNECTION) = C.exec rollback_query () in
  Caqti_lwt.Pool.use rollback' pool |> or_error

(* Caqti_request.collect 関数 *)
(* Select クエリ結果、Insert, Update, Delete の Returning など、戻り値がある場合の操作はこれを使う *)

let get_all_query =
  Caqti_request.collect Caqti_type.unit
    Caqti_type.(tup3 int string string)
    "SELECT lesson_id, course_cd, class FROM lives"

let get_all () =
  let get_all' (module C : Caqti_lwt.CONNECTION) =
    C.fold get_all_query
      (fun (lesson_id, course_cd, class_) acc ->
        { lesson_id; course_cd; class_ } :: acc)
      () []
  in
  Caqti_lwt.Pool.use get_all' pool |> or_error

let add_query =
  Caqti_request.collect
    Caqti_type.(tup2 string string)
    Caqti_type.int
    "INSERT INTO lives (course_cd, class) VALUES (?, ?) RETURNING lesson_id"

let add course_cd class_ =
  let add' (module C : Caqti_lwt.CONNECTION) =
    C.fold add_query (fun id acc -> id :: acc) (course_cd, class_) []
  in
  pool |> Caqti_lwt.Pool.use add' |> or_error

let remove_query =
  Caqti_request.exec Caqti_type.int "DELETE FROM lives WEHRE lesson_id = ?"

let remove lesson_id =
  let remove' (module C : Caqti_lwt.CONNECTION) =
    C.exec remove_query lesson_id
  in
  pool |> Caqti_lwt.Pool.use remove' |> or_error

let clear_query = Caqti_request.exec Caqti_type.unit "TRUNCATE TABLE lives"

let clear () =
  let clear' (module C : Caqti_lwt.CONNECTION) = C.exec clear_query () in
  pool |> Caqti_lwt.Pool.use clear' |> or_error
