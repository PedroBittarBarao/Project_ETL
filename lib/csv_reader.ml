(** Implementation of the CSV reading module. *)

let read_csv (file_path : string) : string list list =
  try
    Csv.load file_path
  with _ -> failwith ("Failed to read CSV file: " ^ file_path)
