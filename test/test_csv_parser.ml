open Alcotest
open Csv_parser

(* Test parse_row_item *)
let test_parse_row_item () =
  let input = ["1"; "101"; "2"; "9.99"; "0.5"] in
  match parse_row_item input with
  | Ok item -> 
      check int "order_id" 1 item.order_id;
      check int "product_id" 101 item.product_id;
      check int "quantity" 2 item.quantity;
      check (float 0.01) "price" 9.99 item.price;
      check (float 0.01) "tax" 0.5 item.tax
  | Error msg -> fail msg

let test_invalid_parse () =
  let input = ["a"; "b"; "c"; "d"; "e"] in
  match parse_row_item input with
  | Error _ -> ()  (* Expected failure *)
  | Ok _ -> fail "Expected parsing error"

(* Test parse_row_order *)
let test_parse_row_order () =
  (* Test valid row *)
  let input = ["1"; "1001"; "2025-02-27"; "completed"; "P"] in
  match parse_row_order input with
  | Ok order -> 
      check int "id" 1 order.id;
      check int "client_id" 1001 order.client_id;
      check string "order_date" "2025-02-27" order.order_date;
      check string "status" "completed" order.status;
      check char "origin" 'P' order.origin
  | Error msg -> fail msg

  let test_invalid_order_parse () =
    (* Test row with invalid origin *)
    let input = ["1"; "1001"; "2025-02-27"; "completed"; "Invalid"] in
    match parse_row_order input with
    | Error msg when msg = "Invalid number format in order row" || msg = "Origin must be a single character" -> ()  (* Expected failure *)
    | Ok _ -> fail "Expected parsing error"
    | Error _ -> fail "Unexpected error"
  

let test_invalid_order_format () =
  (* Test row with incorrect number of fields *)
  let input = ["1"; "1001"; "2025-02-27"; "completed"] in
  match parse_row_order input with
  | Error msg when msg = "Invalid item row" -> ()  (* Expected failure *)
  | Ok _ -> fail "Expected parsing error"
  | Error _ -> fail "Unexpected error"

let () =
  run "CSV Parser Tests" [
    "parse_row_item", [
      test_case "valid row" `Quick test_parse_row_item;
      test_case "invalid row" `Quick test_invalid_parse;
    ];
    "parse_row_order", [
      test_case "valid row" `Quick test_parse_row_order;
      test_case "invalid origin" `Quick test_invalid_order_parse;
      test_case "invalid format" `Quick test_invalid_order_format;
    ]
  ]
