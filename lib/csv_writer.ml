  (** Implementation of CSV writing functions. *)

  open Processor

  let write_csv file_path output_data =
    let header = ["order_id"; "total_amount"; "total_taxes"] in
    let csv_data = List.map (fun { order_id; total_amount; total_taxes } ->
      [string_of_int order_id; string_of_float total_amount; string_of_float total_taxes]
    ) output_data in

    let csv_with_header = header :: csv_data in
    Csv.save file_path csv_with_header
  
  


