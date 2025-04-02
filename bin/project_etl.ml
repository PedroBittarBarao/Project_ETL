let () =
  (* Check if the command-line arguments were passed correctly *)
  if Array.length Sys.argv <> 6 then (
    Printf.printf "Usage: %s <orders_csv> <items_csv> <output_csv> <status> <origin>\n" Sys.argv.(0);
    exit 1
  );

  let orders_csv = Sys.argv.(1) in
  let items_csv = Sys.argv.(2) in
  let output_csv = Sys.argv.(3) in
  let status_filter = Sys.argv.(4) in
  let origin_filter = Sys.argv.(5).[0] in  (* Get the first character for origin *)

  (* Read the CSV files *)
  let orders_data = Csv_reader.read_csv orders_csv in
  let items_data = Csv_reader.read_csv items_csv in

  (* Convert data to records *)
  let orders = Csv_helper.string_to_orders orders_data in
  
  let items = Csv_helper.string_to_items items_data in
  
  (* Filter orders by status and origin *)
  let valid_orders = Filter.filter_orders orders status_filter origin_filter in
  
  (* Process items and calculate totals *)
  let processed_output = Processor.process_orders valid_orders items in

  (* Write output to CSV *)
  Csv_writer.write_csv output_csv processed_output;

  Printf.printf "Processing completed! File saved at: %s\n" output_csv
