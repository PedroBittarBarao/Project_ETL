(lang dune 3.17)

(name Project_ETL)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name <author@example.com>")

(maintainers "Maintainer Name <maintainer@example.com>")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name Project_ETL)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml
 alcotest
  csv)
  (allow_empty)

 (tags
  ("add topics" "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
