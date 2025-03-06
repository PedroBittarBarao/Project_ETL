(** Implementation of CSV writing functions. *)

type output = {
  order_id     : int;
  total_amount : float;
  total_taxes  : float;
}

let write_csv file_path output_data =
  (* Converte os dados de output para um formato adequado para Csv.save *)
  let csv_data = List.map (fun { order_id; total_amount; total_taxes } ->
    [string_of_int order_id; string_of_float total_amount; string_of_float total_taxes]
  ) output_data in
  Csv.save file_path csv_data


