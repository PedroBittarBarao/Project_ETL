open Alcotest
open Processor
open Csv_helper

(* Floating point comparison with tolerance *)
let float_eq (a : float) (b : float) : bool =
  Float.abs (a -. b) < 0.001

(* Custom comparison function for output records *)
let output_eq (a : output) (b : output) : bool =
  (a.order_id = b.order_id) &&
  (float_eq a.total_amount b.total_amount) &&
  (float_eq a.total_taxes b.total_taxes)

(* Alcotest testable for output type *)
let output_testable : output Alcotest.testable =
  let pp (fmt : Format.formatter) (o : output) : unit =
    Format.fprintf fmt "{ order_id = %d; total_amount = %.2f; total_taxes = %.2f }"
      o.order_id o.total_amount o.total_taxes
  in
  Alcotest.testable pp output_eq

(* Sort output lists before comparison *)
let sort_outputs (lst : output list) : output list =
  List.sort (fun (a : output) (b : output) -> compare a.order_id b.order_id) lst

(* Test function for process_orders *)
let test_process_orders () : unit =
  let orders : order list = [
    { id = 1; client_id = 101; order_date = "2024-03-01"; status = "shipped"; origin = 'A' };
    { id = 2; client_id = 102; order_date = "2024-03-02"; status = "pending"; origin = 'B' };
  ] in
  
  let items : item list = [
    { order_id = 1; product_id = 1001; quantity = 2; price = 10.0; tax = 0.1 };
    { order_id = 1; product_id = 1002; quantity = 3; price = 5.0; tax = 0.2 };
    { order_id = 2; product_id = 1003; quantity = 1; price = 15.0; tax = 0.05 };
  ] in
  
  let expected : output list = sort_outputs [
    { order_id = 1; total_amount = 35.00; total_taxes = 5.00 };
    { order_id = 2; total_amount = 15.00; total_taxes = 0.75 };
  ] in
  
  let result : output list = sort_outputs (process_orders orders items) in
  Alcotest.(check (list output_testable)) "Basic processing" expected result

(* Additional test case: No matching orders *)
let test_no_matching_orders () : unit =
  let orders : order list = [
    { id = 3; client_id = 103; order_date = "2024-03-03"; status = "shipped"; origin = 'A' };
  ] in
  
  let items : item list = [
    { order_id = 1; product_id = 1001; quantity = 2; price = 10.0; tax = 0.1 };
  ] in
  
  let expected : output list = [] in
  let result : output list = process_orders orders items in
  Alcotest.(check (list output_testable)) "No matching orders" expected result

(* Additional test case: Empty input lists *)
let test_empty_inputs () : unit =
  let orders : order list = [] in
  let items : item list = [] in
  let expected : output list = [] in
  let result : output list = process_orders orders items in
  Alcotest.(check (list output_testable)) "Empty inputs" expected result

(* Run all tests *)
let () : unit =
  Alcotest.run "Order Processing Tests" [
    ("process_orders", [
      test_case "Basic processing" `Quick test_process_orders;
      test_case "No matching orders" `Quick test_no_matching_orders;
      test_case "Empty inputs" `Quick test_empty_inputs;
    ])
  ]