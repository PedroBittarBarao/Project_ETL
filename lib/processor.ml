open Csv_helper

type output = {
  order_id     : int;
  total_amount : float;
  total_taxes  : float;
}

let process_orders (orders : order list) (items : item list) : output list =
  let order_ids = List.map (fun (order : order) -> order.id) orders in
  let filtered_items = List.filter (fun (item : item) -> List.mem item.order_id order_ids) items in
  let outs =
    List.fold_left (fun acc (item : item) ->
      let existing = try Some (List.assoc item.order_id acc) with Not_found -> None in
      match existing with
      | Some (total_amount, total_taxes) ->
          let total_amount' = total_amount +. (item.price *. float_of_int item.quantity) in
          let total_taxes' = total_taxes +. (item.tax *. item.price *. float_of_int item.quantity) in
          (item.order_id, (total_amount', total_taxes')) :: List.remove_assoc item.order_id acc
      | None ->
          let total_amount' = item.price *. float_of_int item.quantity in
          let total_taxes' = item.tax *. item.price *. float_of_int item.quantity in
          (item.order_id, (total_amount', total_taxes')) :: acc
    ) [] filtered_items
  in
  List.map (fun (order_id, (total_amount, total_taxes)) ->
    { order_id; total_amount; total_taxes }
  ) outs
