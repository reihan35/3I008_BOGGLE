(* backtrack : Board.t -> Lexicon.t -> Path.t -> int * int -> Path.t Iter.t *)

let rec backtrack board lexicon path (i, j) =
  match Path.add_tile board path (i, j) with
  |None->Iter.empty
  |Some(path_prime)-> let alpha = Board.get_letter board i j in
             let lex_prime =Lexicon.filter_min_length 4 (Lexicon.letter_suffixes lexicon alpha) in
             match Lexicon.is_empty lex_prime with
             |true-> Iter.empty
             |false->
                 match Lexicon.has_empty_word lex_prime with
                 |true ->  Iter.append  (Iter.flat_map (fun x -> backtrack board lex_prime path_prime x) (Board.neighbours board (i, j))) (Iter.singleton path_prime);
                 |false ->  Iter.flat_map (fun x -> backtrack board lex_prime path_prime x) (Board.neighbours board (i, j));;

let find_all_paths board lexicon =
  Iter.flat_map (fun x -> backtrack board lexicon (Path.empty) x) (Board.all_positions board);;
