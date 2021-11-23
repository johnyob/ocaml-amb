(lang dune 2.9)
(name amb)

(generate_opam_files true)

(license MIT)

(maintainers "ajo41@cam.ac.uk")

(authors "Alistair O'Brien")

(source
 (github johnyob/ocaml-amb))

(package
 (name amb)
 (synopsis "Monadic implementation of amb")
 (depends
  (ocaml
   (= 4.12.0))
  (dune
   (>= 2.9))
  (base
   (>= v0.14.1))))
