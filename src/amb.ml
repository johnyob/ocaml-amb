open! Import

(** {1 Backtracking Monad Transformer} *)

module type S = sig
  include Monad.Trans.S
  include Monad.S_plus with type 'a t := 'a t

  val assert_ : bool -> unit t
  val of_list : 'a list -> 'a t
end

module Endo = struct
  type 'a t = 'a -> 'a
end

module Make (M : Monad.S) = struct
  type 'a t = { f : 'b. ('a -> 'b M.t Endo.t) -> 'b M.t Endo.t }

  include Monad.Make (struct
    type nonrec 'a t = 'a t

    let bind t ~f = { f = (fun k -> t.f (fun x -> (f x).f k)) }
    let return x = { f = (fun k -> k x) }
    let map = `Define_using_bind
  end)

  let lift m = { f = M.(fun k f -> m >>= fun x -> k x f) }
  let run t = t.f (fun x _ -> M.return (Some x)) (M.return None)
  let zero = { f = (fun _ -> Fn.id) }
  let ( <|> ) t1 t2 = { f = (fun k x -> t1.f k (t2.f k x)) }

  let assert_ = function
    | true -> return ()
    | false -> zero


  let rec of_list xs =
    match xs with
    | [] -> zero
    | x :: xs -> return x <|> of_list xs
end

include Make (Monad.Ident)


