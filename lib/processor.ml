type item = {
  order_id  : int;
  product_id: int;
  quantity  : int;
  price     : float;
  tax       : float;
}

type output = {
  order_id     : int;
  total_amount : float;
  total_taxes  : float;
}

let process_orders (order_ids : int list) (items : item list) : output list =
  let filtered_items = List.filter (fun i -> List.mem i.order_id order_ids) items in
  
  (* Agrupa os itens por order_id e calcula os totais *)
  let grouped_items =
    List.fold_left (fun acc curr_item ->
      let existing = try Some (List.assoc curr_item.order_id acc) with Not_found -> None in
      match existing with
      | Some (total_amount, total_taxes) ->
        let total_amount' = total_amount +. (curr_item.price *. float_of_int curr_item.quantity) in
        let total_taxes' = total_taxes +. (curr_item.tax *. curr_item.price *. float_of_int curr_item.quantity) in
        (curr_item.order_id, total_amount', total_taxes') :: List.remove_assoc curr_item.order_id acc
      | None ->
        let total_amount' = curr_item.price *. float_of_int curr_item.quantity in
        let total_taxes' = curr_item.tax *. curr_item.price *. float_of_int curr_item.quantity in
        (curr_item.order_id, total_amount', total_taxes') :: acc
    ) [] filtered_items
  in

  (* Converte os resultados para o tipo output *)
  List.map (fun (order_id, total_amount, total_taxes) ->
    { order_id; total_amount; total_taxes }
  ) grouped_items