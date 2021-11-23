open! Import

(** {1 Backtracking Monad for Continuations} *)

module type S = sig
  include Monad.Trans.S
  include Monad.S_plus with type 'a t := 'a t
  
  val assert_ : bool -> unit t
  val of_list : 'a list -> 'a t
end

module Make (M : Monad.S) : 
  S with type 'a m := 'a M.t
    and type 'a e := 'a option M.t

include S with type 'a m := 'a and type 'a e := 'a option