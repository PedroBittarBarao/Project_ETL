open Alcotest
open Csv_helper

(* Custom pretty-printer for the order type *)
let pp_order (fmt : Format.formatter) (order : order) : unit =
  Format.fprintf fmt "{ id = %d; client_id = %d; order_date = %s; status = %s; origin = %c }"
    order.id order.client_id order.order_date order.status order.origin

(* Define equality check for order records *)
let equal_order (o1 : order) (o2 : order) : bool =
  o1.id = o2.id && o1.client_id = o2.client_id &&
  o1.order_date = o2.order_date && o1.status = o2.status &&
  o1.origin = o2.origin

(* Create an Alcotest testable for order *)
let order_testable : order Alcotest.testable = testable pp_order equal_order

(* Sample orders for testing *)
let orders : order list = [
  { id = 1; client_id = 101; order_date = "2024-03-01"; status = "shipped"; origin = 'A' };
  { id = 2; client_id = 102; order_date = "2024-03-02"; status = "pending"; origin = 'B' };
  { id = 3; client_id = 103; order_date = "2024-03-03"; status = "shipped"; origin = 'A' };
  { id = 4; client_id = 104; order_date = "2024-03-04"; status = "pending"; origin = 'A' };
  { id = 5; client_id = 105; order_date = "2024-03-05"; status = "shipped"; origin = 'B' };
]

(* Test function for filtering shipped orders from origin A *)
let test_filter_shipped_origin_a () : unit =
  let result : order list = Filter.filter_orders orders "shipped" 'A' in
  let expected : order list = [
    { id = 1; client_id = 101; order_date = "2024-03-01"; status = "shipped"; origin = 'A' };
    { id = 3; client_id = 103; order_date = "2024-03-03"; status = "shipped"; origin = 'A' };
  ] in
  let sorted_result = List.sort (fun (a : order) (b : order) -> compare a.id b.id) result in
  let sorted_expected = List.sort (fun (a : order) (b : order) -> compare a.id b.id) expected in
  check (list order_testable) "Filter shipped orders from origin A" sorted_expected sorted_result

(* Test function for filtering pending orders from origin A *)
let test_filter_pending_origin_a () : unit =
  let result : order list = Filter.filter_orders orders "pending" 'A' in
  let expected : order list = [
    { id = 4; client_id = 104; order_date = "2024-03-04"; status = "pending"; origin = 'A' };
  ] in
  check (list order_testable) "Filter pending orders from origin A" expected result

(* Test function for filtering shipped orders from origin B *)
let test_filter_shipped_origin_b () : unit =
  let result : order list = Filter.filter_orders orders "shipped" 'B' in
  let expected : order list = [
    { id = 5; client_id = 105; order_date = "2024-03-05"; status = "shipped"; origin = 'B' };
  ] in
  check (list order_testable) "Filter shipped orders from origin B" expected result

(* Test function for filtering non-existent status *)
let test_filter_nonexistent_status () : unit =
  let result : order list = Filter.filter_orders orders "delivered" 'A' in
  let expected : order list = [] in
  check (list order_testable) "Filter nonexistent status" expected result

(* Run the test suite *)
let () : unit =
  run "Filter Orders Tests" [
    ("filter_orders", [
      test_case "Filter shipped orders from origin A" `Quick test_filter_shipped_origin_a;
      test_case "Filter pending orders from origin A" `Quick test_filter_pending_origin_a;
      test_case "Filter shipped orders from origin B" `Quick test_filter_shipped_origin_b;
      test_case "Filter nonexistent status" `Quick test_filter_nonexistent_status;
    ])
  ]