# Project Development

To streamline code management and execution, the project utilizes [Dune](https://dune.build/install) as its build system. Additionally, [the OCaml CSV library](https://opam.ocaml.org/packages/csv/) was imported to handle CSV files.

After exploring the library’s functionalities, [reader functions](/lib/csv_reader.ml) were implemented to extract data from the input CSV files, ensuring a clear separation between pure and impure functions.

Next, [helper functions](/lib/csv_helper.ml) were created to convert the extracted string list lists into structured records of type Order and OrderItem. With the data now represented as records, a [filtering function](/lib/filter.ml) was developed to select orders based on their status flag.

A [processing function](/lib/processor.ml) was then implemented to perform the necessary computations and generate output records. Once processed, the results were [written to a CSV file ](/lib/csv_writer.ml)using the library’s writing capabilities.

Finally, a [main function](/bin/project_etl.ml) was constructed to integrate all components, ensuring the complete workflow from reading input to generating output.

After the program’s completion, [tests](/test) were designed to validate the behavior of pure functions.