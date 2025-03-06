(** Module for processing items and aggregating order totals. *)

(** Type representing an item in an order. *)
type item = {
  order_id  : int;
  product_id: int;
  quantity  : int;
  price     : float;
  tax       : float;
}


(** Type representing aggregated order data. *)
type output = {
  order_id     : int;
  total_amount : float;
  total_taxes  : float;
}

(** Processes items to compute total amount and total taxes for each order.

    @param order_ids The list of order IDs to process.
    @param items The list of items to be aggregated.
    @return A list of output records with aggregated totals for each order.
*)
val process_orders : int list -> item list -> output list
