(** Module for filtering orders based on status and origin. *)

open Csv_helper

(** Filters orders by status and origin, returning filtered orders.

    @param orders The list of orders to filter.
    @param status The desired status of the order.
    @param origin The desired origin character of the order.
    @return A list of orders matching the given status and origin.
*)
val filter_orders : order list -> string -> char -> order list
