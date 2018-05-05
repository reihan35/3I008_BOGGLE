open Boggle

let main () =
  if Array.length Sys.argv < 2 then
    begin
    print_string "********************************************************************************************\n";
    print_string "Welcome to the Boggle Game !! Here's a Boggle generated for you ! Try to solve it by your own\n";
    let random_letter_fr = RandomLetter.picker RandomLetter.Distribution.fr in
    let board = Board.make 4 (random_letter_fr)
    in
    Board.print board;
    print_string "\n";
    print_string "\nOr tap enter to see the solutions if you are lazy !\n";
    read_line();
    print_string "Here's your Boggle's solutions :\n";
    print_string "\n";
    let dict = Lexicon.load_file "dict/dico_fr.txt" in
    match dict with
    |None->print_string "problem";
    |Some d->
    let my_compare x y=
      if String.length x > String.length y then -1
      else
      if String.length x < String.length y then 1
      else
       String.compare x y;
      in

    let list_mots = List.sort_uniq my_compare (Iter.to_rev_list (Path.iter_to_words board (Solver.find_all_paths board d))) in
    let rec parcours_liste l =
	  match l with
	  | [] -> print_string("\n");print_string "********************************************************************************************\n";
	  | t::q -> print_string(t ^ " "); parcours_liste q
    in parcours_liste list_mots;
    end
  else
  begin
    print_string "J'ai reçu le paramètre ";
    print_endline Sys.argv.(1);
    print_string "********************************************************************************************\n";
    print_string "Welcome to the Boggle Game !! Here's a Boggle generated for you ! Try to solve it by your own\n";
    let b = Board.from_string Sys.argv.(1) in
    match b with
    |None->print_string "Sorry board length not valid "
    |Some(board)->Board.print board;
    print_string "\n";
    print_string "\nOr tap enter to see the solutions if you are lazy !\n";
    read_line();
    print_string "Here's your Boggle's solutions :\n";
    print_string "\n";
    let dict = Lexicon.load_file "dict/dico_fr.txt" in
    match dict with
    |None->print_string "problem";
    |Some d->
    let my_compare x y=
      if String.length x > String.length y then -1
      else
      if String.length x < String.length y then 1
      else
       String.compare x y;
      in

    let list_mots = List.sort_uniq my_compare (Iter.to_rev_list (Path.iter_to_words board (Solver.find_all_paths board d))) in
    let rec parcours_liste l =
	  match l with
	  | [] -> print_string("\n");print_string "********************************************************************************************\n";
	  | t::q -> print_string(t ^ " "); parcours_liste q
    in parcours_liste list_mots
  end;
  print_endline "Bye Bye ! <____> "
let () = main ();;
