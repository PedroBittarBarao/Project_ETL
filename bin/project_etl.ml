
let () =
  (* Verifica se os argumentos da linha de comando foram passados corretamente *)
  if Array.length Sys.argv <> 6 then (
    Printf.printf "Uso: %s <orders_csv> <items_csv> <output_csv> <status> <origin>\n" Sys.argv.(0);
    exit 1
  );

  let orders_csv = Sys.argv.(1) in
  let items_csv = Sys.argv.(2) in
  let output_csv = Sys.argv.(3) in
  let status_filter = Sys.argv.(4) in
  let origin_filter = Sys.argv.(5).[0] in  (* Pega o primeiro caractere para o origin *)

  (* Lê os arquivos CSV *)
  let orders_data = Csv_reader.read_csv orders_csv in
  let items_data = Csv_reader.read_csv items_csv in

  (* Converte os dados para registros *)
  let orders = Csv_helper.string_to_orders orders_data in
  
  let items = Csv_helper.string_to_items items_data in
  
  (* Filtra os pedidos conforme status e origem *)
  let valid_orders = Filter.filter_orders orders status_filter origin_filter in
  
  (* Processa os itens e calcula os totais *)
  let processed_output = Processor.process_orders valid_orders items in

  (* Escreve a saída no CSV *)
  Csv_writer.write_csv output_csv processed_output;

  Printf.printf "Processamento concluído! Arquivo salvo em: %s\n" output_csv
