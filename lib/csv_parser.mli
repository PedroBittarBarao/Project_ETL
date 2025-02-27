(** csv_parser.mli *)

(** Type representing an order item *)
type item = {
  order_id  : int;
  product_id: int;
  quantity  : int;
  price     : float;
  tax       : float;
}

(** Type representing an order*)
type order = {
  id         :int;
  client_id  :int;
  order_date :string;
  status     :string;
  origin     :char;
}

(** 
  Parses a row representing an order.
  
  This function takes a row (a list of strings) and tries to parse it into an 
  `order` record. It expects the row to contain the following fields:
  
  - `id`: The unique identifier of the order (int).
  - `client_id`: The identifier of the client placing the order (int).
  - `order_date`: The date of the order (string).
  - `status`: The status of the order (string).
  - `origin`: A single character indicating the origin of the order (char).
  
  If the row format is correct, it returns `Ok` with an `order` record. Otherwise, 
  it returns an `Error` with a descriptive error message.

  @param row A list of strings representing a row in the order CSV.
  @return `Ok order` if the row is valid, or `Error msg` if there is a parsing error.
*)
val parse_row_item : string list -> (item, string) result

(** 
    Parses a row representing an item in the order.
    
    This function takes a row (a list of strings) and tries to parse it into an 
    `item` record. It expects the row to contain the following fields:
    
    - `order_id`: The identifier of the order (int).
    - `product_id`: The identifier of the product (int).
    - `quantity`: The quantity of the product ordered (int).
    - `price`: The price of the product (float).
    - `tax`: The tax applied to the product (float).
    
    If the row format is correct, it returns `Ok` with an `item` record. Otherwise, 
    it returns an `Error` with a descriptive error message.
  
    @param row A list of strings representing a row in the item CSV.
    @return `Ok item` if the row is valid, or `Error msg` if there is a parsing error.
  *)
val parse_row_order : string list -> (order,string) result
