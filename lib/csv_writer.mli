(** Module for writing processed order data to a CSV file. *)

type output = {
  order_id     : int;
  total_amount : float;
  total_taxes  : float;
}

(** Writes the processed order data to a CSV file.

    @param file_path The path of the CSV file to write.
    @param outputs The list of output records to be written.
*)
val write_csv : string -> output list -> unit
