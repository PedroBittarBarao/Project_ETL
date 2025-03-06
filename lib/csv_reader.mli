(** Module for reading CSV files and returning their contents as string lists. *)

(** Reads a CSV file and returns its contents as a list of rows.
    Each row is represented as a list of strings.

    @param file_path The path to the CSV file.
    @return A list of rows, where each row is a list of strings.
    @raise Failure if the file cannot be read.
*)
    val read_csv : string -> string list list
