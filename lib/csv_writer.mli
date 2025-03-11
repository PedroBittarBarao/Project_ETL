(** Module for writing processed order data to a CSV file. *)

(** Writes the processed order data to a CSV file.

    @param file_path The path of the CSV file to write.
    @param outputs The list of output records to be written.
*)
val write_csv : string -> Processor.output list -> unit
