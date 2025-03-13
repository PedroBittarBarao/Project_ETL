type item = {
  order_id  : int;
  product_id: int;
  quantity  : int;
  price     : float;
  tax       : float;
}

type order = {
  id         :int;
  client_id  :int;
  order_date :string;
  status     :string;
  origin     :char;
}


let string_to_items (lines : string list list) : item list =
  let parse_line line =
    match line with
    | [order_id; product_id; quantity; price; tax] ->
        begin
          try 
            let order_id = int_of_string order_id in
            let product_id = int_of_string product_id in
            let quantity = int_of_string quantity in
            let price = float_of_string price in
            let tax = float_of_string tax in
            Some { order_id; product_id; quantity; price; tax }
          with Failure _ -> None
        end
    | _ -> None
  in
  List.filter_map parse_line lines

let string_to_orders (lines : string list list) : order list =
  let parse_line line =
    match line with
    | [id; client_id; order_date; status; origin] ->
        begin
          try 
            let id = int_of_string id in
            let client_id = int_of_string client_id in
            let order_date = order_date in
            let status = status in
            let origin = origin.[0] in
            Some { id; client_id; order_date; status; origin }
          with Failure _ -> None
        end
    | _ -> None
  in
  List.filter_map parse_line lines
  

  