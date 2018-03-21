open Boggle
(*
let main () =
  if Array.length Sys.argv >= 2
  then begin
    print_string "J'ai reçu le paramètre ";
    print_endline Sys.argv.(1);
  end
  else begin
    print_endline "Je n'ai reçu aucun paramètre"
  end;
  print_endline "Je ne sais pas quoi faire... Programmez moi !"
*)

let main () =
  let random_letter_fr = RandomLetter.picker RandomLetter.Distribution.fr in
  let board = Board.make 4 random_letter_fr
  in Board.print board;;
(*
	let board = Board.from_string "hugowyborskammmm" in
    match board with
    | Some(t) -> Board.print t
    | None -> print_string("Désolées pas carré");;
*)
let () = main ()
