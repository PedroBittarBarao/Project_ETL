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


let parse_row_order row = 
  match row with
  | [id; client_id; order_date; status; origin] ->
    begin 
      try
        let id = int_of_string id in 
        let client_id = int_of_string client_id in
        let order_date = order_date in 
        let status = status in 
        let origin = 
          if String.length origin = 1 then origin.[0]  (* Pega o primeiro caractere *)
          else failwith "Origin must be a single character"
        in
        Ok {id;client_id;order_date;status;origin}
      with Failure _ -> Error "Invalid number format in order row"
    end
  | _ -> Error "Invalid item row"
  
  
let parse_row_item row =
  match row with
  | [order_id; product_id; quantity; price; tax] -> 
      begin
        try 
          let order_id = int_of_string order_id in
          let product_id = int_of_string product_id in
          let quantity = int_of_string quantity in
          let price = float_of_string price in
          let tax = float_of_string tax in
          Ok { order_id; product_id; quantity; price; tax }
        with Failure _ -> Error "Invalid number format in item row"
      end
  | _ -> Error "Invalid item row"
  