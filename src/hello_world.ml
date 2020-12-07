
open Core

let () = Sexp.to_string_hum [%sexp ([3;4;5] : int list)] |> print_endline

let () = Lwt_main.run (Lwt_io.printf "Hello, world!\n")