type t = (int * int) list

let empty = []

let add_tile board path (i, j) =
  match path with
  | [] -> [(i,j)]
  | _ when List.mem (i,j) path && (Board.is_valid_pos board (i, j)) && Board.are_neighbours board (List.nth path (List.length path)) (i, j) -> List.cons path (i,j)
  | _ -> path

let rec to_string board path =
  failwith "Unimplemented"

let iter_to_words board all_paths =
  failwith "Unimplemented"
