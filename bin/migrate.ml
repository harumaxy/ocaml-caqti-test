open Lib

(* シンプルな migrate 実行ファイル *)

let migrate () =
  print_endline "Creating livs table.";
  match%lwt Live.migrate () with
  | Ok () -> print_endline "Done." |> Lwt.return
  | Error (Live.Database_error msg) -> print_endline msg |> Lwt.return

let () = Lwt_main.run (migrate ())
