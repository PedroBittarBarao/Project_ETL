(** Module for parsing CSV rows into structured records. *)

(** Type representing an item in an order. *)
type item = {
  order_id  : int;
  product_id: int;
  quantity  : int;
  price     : float;
  tax       : float;
}

(** Type representing an order. *)
type order = {
  id         :int;
  client_id  :int;
  order_date :string;
  status     :string;
  origin     :char;
}

(** Converts a CSV row into an [item] record.
    Assumes that the row has the correct format.

    @param row A list of strings representing a row in the item CSV.
    @return An [item] record.
*)
val parse_row_item : string list -> (item, string) result


(** Converts a CSV row into an [order] record.
    Assumes that the row has the correct format.

    @param row A list of strings representing a row in the order CSV.
    @return An [order] record.
*)
val parse_row_order : string list -> (order, string) result
