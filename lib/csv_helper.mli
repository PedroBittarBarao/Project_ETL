(** Types representing items and orders in the system. *)

(** Represents an item in an order. *)
type item = {
  order_id  : int;    (** The ID of the order this item belongs to. *)
  product_id: int;    (** The ID of the product. *)
  quantity  : int;    (** The quantity of the product in the order. *)
  price     : float;  (** The price of a single unit of the product. *)
  tax       : float;  (** The tax applied to this product. *)
}

(** Represents an order. *)
type order = {
  id         : int;     (** The unique ID of the order. *)
  client_id  : int;     (** The ID of the client who placed the order. *)
  order_date : string;  (** The date when the order was placed. *)
  status     : string;  (** The current status of the order. *)
  origin     : char;    (** The origin of the order (e.g., online, in-store). *)
}

(** Parses a CSV file (as a list of string lists) into a list of items.

    @param lines The CSV content, where each row is a list of strings.
    @return A list of [item] records parsed from the input.
    Invalid rows (e.g., with missing or malformed values) are ignored.
*)
val string_to_items : string list list -> item list

(** Parses a CSV file (as a list of string lists) into a list of orders.

    @param lines The CSV content, where each row is a list of strings.
    @return A list of [order] records parsed from the input.
    Invalid rows (e.g., with missing or malformed values) are ignored.
*)
val string_to_orders : string list list -> order list
