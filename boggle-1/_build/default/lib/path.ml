type t = (int * int) list

let empty = []

let start = [(0,0)]

let rev path =
  List.rev path;;

(*
let add_tile board path (i, j) =
  match path with
  | [] -> Some([(i,j)])
  | _ when (List.mem (i,j) path==false) && (Board.is_valid_pos board (i,j)) && (Board.are_neighbours board (List.nth path ((List.length path)-1)) (i, j)) ->Some(List.cons (i,j) path)
  | _ ->None
*)

let add_tile board path (i, j) = 
	if List.length path >= 1 then
		if (List.mem (i,j) path==false) && (Board.is_valid_pos board (i,j)) && (Board.are_neighbours board (List.nth path ((List.length path)-1)) (i, j)) then
			let rec aux p =
				match p with
				| [] -> (i, j)::[]
				| (a, b)::q -> (a, b) :: (aux q)
			in Some (aux path)
		else
			None
	else
		if (Board.is_valid_pos board (i,j)) then
			Some((i,j)::[])
		else 
			None


let rec to_string board path =
	match path with
	|[]->""
	|(a,b)::q -> (String.make 1 (Board.get_letter board a b))^to_string board q

let iter_to_words board all_paths =
  	Iter.map (fun x -> to_string board x) all_paths