open Base
open! Amb

let index_domain xs = 
  Amb.of_list (List.init (List.length xs) ~f:Fn.id)

let eq_at xs ys =
  let open Amb.Let_syntax in
  let%bind i = index_domain xs in
  let%bind j = index_domain ys in
  let%bind () = assert_ (List.nth_exn xs i = List.nth_exn ys j) in
  return (i, j)
