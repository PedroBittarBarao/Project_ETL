(** csv_processor.mli *)

(** 
  Processes a CSV file containing item data, parses each row using the 
  Csv_parser module, and prints the parsed items or errors.

  @param file_path The path to the CSV file that contains item data.
  @return unit
*)
val process_item_csv : string -> unit

(** 
  Processes a CSV file containing order data, parses each row using the 
  Csv_parser module, and prints the parsed orders or errors.

  @param file_path The path to the CSV file that contains order data.
  @return unit
*)
val process_order_csv:string -> unit
