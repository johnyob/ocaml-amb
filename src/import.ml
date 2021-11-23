include Base

module Monad = struct
  include Base.Monad

  module type S_plus = sig
    include S
    val zero : 'a t
    val (<|>) : 'a t -> 'a t -> 'a t
  end

  module Trans = struct
    module type S = sig
      type 'a t
      type 'a m
      type 'a e

      val lift : 'a m -> 'a t
      val run : 'a t -> 'a e
    end

    module type S2 = sig
      type ('a, 'b) t
      type ('a, 'b) m
      type ('a, 'b) e

      val lift : ('a, 'b) m -> ('a, 'b) t
      val run : ('a, 'b) t -> ('a, 'b) e
    end
  end
end