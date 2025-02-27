let process_item_csv file_path =
  match Csv.load file_path with
  | [] -> Printf.printf "Empty item CSV file!\n"
  | _ :: rows -> 
      List.iter (fun row ->
        match Csv_parser.parse_row_item row with
        | Ok item -> 
            Printf.printf "Item Parsed : order_id=%d, product_id=%d, quantity=%d, price=%f, tax=%f\n"
              item.order_id item.product_id item.quantity item.price item.tax
        | Error msg -> Printf.printf "Error: %s\n" msg
      ) rows


let process_order_csv file_path = 
  match Csv.load file_path with
  | [] -> Printf.printf "Empty order CSV file\n"
  | _ :: rows ->
    List.iter (fun row -> 
      match Csv_parser.parse_row_order row with 
      | Ok order -> 
        Printf.printf "Order Parsed: id=%d, client_id=%d, order_date=%s, status=%s, origin=%c\n"
        order.id order.client_id order.order_date order.status order.origin
      | Error msg -> Printf.printf "Error: %s\n" msg 
      ) rows
