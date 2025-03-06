(** Implementation of order filtering functions. *)

(** Type representing an order. *)
type order = {
  id         :int;
  client_id  :int;
  order_date :string;
  status     :string;
  origin     :char;
}

let filter_orders (orders : order list) (status : string) (origin : char) : int list =
  orders
  |> List.filter (fun order -> order.status = status && order.origin = origin)
  |> List.map (fun order -> order.id)
