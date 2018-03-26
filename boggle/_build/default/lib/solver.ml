(* backtrack : Board.t -> Lexicon.t -> Path.t -> int * int -> Path.t Iter.t *)
let rec backtrack board lexicon path (i, j) =
  (*let s_c_c = ref Iter.empty in*)
  match Path.add_tile board path (i, j) with
  |None->Iter.empty
  |Some(path_prime)-> let alpha = Board.get_letter board i j in
             let lex_prime = Lexicon.letter_suffixes lexicon alpha in
             match Lexicon.is_empty lex_prime with
             |true->Iter.empty
             |false->
                 match Lexicon.has_empty_word lex_prime with
                 |true->Iter.append (Iter.singleton path_prime) (Iter.flat_map (fun x -> backtrack board lex_prime path_prime x) (Board.neighbours board (i, j)));
                 |false->Iter.append (Iter.empty)  (Iter.flat_map (fun x -> backtrack board lex_prime path_prime x) (Board.neighbours board (i, j)));;

let find_all_paths board lexicon =
  failwith "Unimplemented"
