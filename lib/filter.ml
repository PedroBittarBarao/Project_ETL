(** Implementation of order filtering functions. *)

open Csv_helper


let filter_orders (orders : order list) (status : string) (origin : char) : order list =
  List.filter (fun order ->
    order.status = status && order.origin = origin
  ) orders

