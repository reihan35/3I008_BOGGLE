(* backtrack : Board.t -> Lexicon.t -> Path.t -> int * int -> Path.t Iter.t *)
let rec backtrack board lexicon path (i, j) =
  (*let s_c_c = ref Iter.empty in*)
  match Path.add_tile board (Path.rev path) (i, j) with
  |None->Iter.empty
  |Some(path_prime)-> let alpha = Board.get_letter board i j in
             let lex_prime = Lexicon.letter_suffixes lexicon alpha in
             match Lexicon.is_empty lex_prime with
             |true->Iter.empty
             |false->
(*                  let solutions_via_voisins = Iter.flat_map (fun x -> backtrack board lex_prime (Path.rev path_prime) x) (Board.neighbours board (i, j)) in *)

(*                  let solutions_via_voisins =List.fold_left (Iter.cons) (Iter.empty) (SS.elements(SS.union SS.empty (SS.of_list(Iter.to_rev_list(Iter.flat_map (fun x -> backtrack board lex_prime path_prime x) (Board.neighbours board (i, j))))))) in *)
                 match Lexicon.has_empty_word lex_prime with
(*                  |true-> if Iter.exists (fun x -> x = (Path.rev path_prime)) solutions_via_voisins then *)
(*                             solutions_via_voisins *)
(*                         else *)
(*                             Iter.append solutions_via_voisins (Iter.singleton (Path.rev path_prime)) *)
                 |true -> Iter.append  (Iter.singleton (Path.rev path_prime)) (Iter.flat_map (fun x -> backtrack board lex_prime (Path.rev path_prime) x) (Board.neighbours board (i, j)));
(*                  |false-> solutions_via_voisins;; *)
                 |false -> Iter.append (Iter.flat_map (fun x -> backtrack board lex_prime (Path.rev path_prime) x) (Board.neighbours board (i, j))) (Iter.empty);;


let find_all_paths board lexicon =
  (*failwith "unimplemented"*)
(*  Iter.flat_map (fun x -> if Iter.exists (fun a -> if a=x && (backtrack board lexicon Path.empty x)=false then(backtrack board lexicon Path.empty x))) (Board.all_positions board);; *)
  Iter.flat_map (fun x -> backtrack board lexicon (Path.empty) x) (Board.all_positions board);;
(*  let iter_string = ref Iter.empty in *)
(*  Iter.flat_map (fun x -> let v =(backtrack board lexicon Path.empty x) in if Iter.exists v !iter_string then  ) (Board.all_positions board);; *)
