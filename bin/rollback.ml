open Lib

let rollback () =
  print_endline "Deleting livs table.";
  match%lwt Live.rollback () with
  | Ok () -> print_endline "Done." |> Lwt.return
  | Error (Live.Database_error msg) -> print_endline msg |> Lwt.return

let () = Lwt_main.run (rollback ())
