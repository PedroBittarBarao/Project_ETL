(** Module for processing items and aggregating order totals. *)

(** Type representing aggregated order data. *)
type output = {
  order_id     : int;
  total_amount : float;
  total_taxes  : float;
}


(** Processes items to compute total amount and total taxes for each order.

    @param orders The list of orders to process.
    @param items The list of items to be aggregated.
    @return A list of output records with aggregated totals for each order.
*)
val process_orders : Csv_helper.order list -> Csv_helper.item list -> output list
