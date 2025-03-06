(** Module for filtering orders based on status and origin. *)

(** Type representing an order. *)
type order = {
  id         : int;
  client_id  : int;
  order_date : string;
  status     : string;
  origin     : char;
}

(** Filters orders by status and origin, returning only the order IDs.

    @param orders The list of orders to filter.
    @param status The desired status of the order.
    @param origin The desired origin character of the order.
    @return A list of order IDs matching the given status and origin.
*)
val filter_orders : order list -> string -> char -> int list
