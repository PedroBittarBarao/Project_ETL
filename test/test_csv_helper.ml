open Alcotest
open Csv_helper

(* Pretty-printer for items *)
let pp_item (fmt : Format.formatter) (i : item) : unit =
  Format.fprintf fmt "{ order_id = %d; product_id = %d; quantity = %d; price = %.2f; tax = %.2f }"
    i.order_id i.product_id i.quantity i.price i.tax

(* Pretty-printer for orders *)
let pp_order (fmt : Format.formatter) (o : order) : unit =
  Format.fprintf fmt "{ id = %d; client_id = %d; order_date = %s; status = %s; origin = %c }"
    o.id o.client_id o.order_date o.status o.origin

(* Equality functions for comparison *)
let eq_item (i1 : item) (i2 : item) : bool =
  i1.order_id = i2.order_id && i1.product_id = i2.product_id &&
  i1.quantity = i2.quantity && Float.abs (i1.price -. i2.price) < 0.001 &&
  Float.abs (i1.tax -. i2.tax) < 0.001

let eq_order (o1 : order) (o2 : order) : bool =
  o1.id = o2.id && o1.client_id = o2.client_id &&
  o1.order_date = o2.order_date && o1.status = o2.status &&
  o1.origin = o2.origin

(* Define Alcotest testable types *)
let item_testable : item Alcotest.testable = testable pp_item eq_item
let order_testable : order Alcotest.testable = testable pp_order eq_order

(* Test function for string_to_items *)
let test_string_to_items () : unit =
  let input = [
    ["1"; "101"; "2"; "10.0"; "0.1"];
    ["2"; "102"; "1"; "5.0"; "0.05"]
  ] in

  let expected : item list = [
    { order_id = 1; product_id = 101; quantity = 2; price = 10.0; tax = 0.1 };
    { order_id = 2; product_id = 102; quantity = 1; price = 5.0; tax = 0.05 }
  ] in

  let result : item list = string_to_items input in
  let sorted_result = List.sort compare result in
  let sorted_expected = List.sort compare expected in

  Alcotest.(check (list item_testable)) "Parse items correctly" sorted_expected sorted_result

(* Test function for string_to_orders *)
let test_string_to_orders () : unit =
  let input = [
    ["1"; "201"; "2024-03-01"; "shipped"; "A"];
    ["2"; "202"; "2024-03-02"; "pending"; "B"]
  ] in

  let expected : order list = [
    { id = 1; client_id = 201; order_date = "2024-03-01"; status = "shipped"; origin = 'A' };
    { id = 2; client_id = 202; order_date = "2024-03-02"; status = "pending"; origin = 'B' }
  ] in

  let result : order list = string_to_orders input in
  let sorted_result = List.sort compare result in
  let sorted_expected = List.sort compare expected in

  Alcotest.(check (list order_testable)) "Parse orders correctly" sorted_expected sorted_result

(* Run all tests *)
let () =
  Alcotest.run "String Parsing Tests" [
    ("string_to_items", [test_case "Parse item list" `Quick test_string_to_items]);
    ("string_to_orders", [test_case "Parse order list" `Quick test_string_to_orders]);
  ]
