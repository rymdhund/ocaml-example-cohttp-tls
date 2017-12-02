open Lwt
open Cohttp

let () =
  let callback _conn req req_body =
    (req_body |> Cohttp_lwt.Body.to_string) >>=
      (fun body  ->
         Cohttp_lwt_unix.Server.respond_string ~status:`OK
           ~body:"hello world" ()) in
  let server = Cohttp_lwt_unix.Server.make ~callback () in
  let port = 4433 in
  let mode =
    `TLS
      ((`Crt_file_path "server.crt"), (`Key_file_path "server.key"),
        `No_password, (`Port port)) in
  let lwt_server = Cohttp_lwt_unix.Server.create ~mode server in
  Printf.printf "Running web server on port %d\n%!" port;
  ignore (Lwt_main.run lwt_server)
