type t = char array array

let get_letter board i j =
  board.(i).(j);;

let dim board =
  Array.length board;;

let all_positions board =
	let n = dim board in
	let iter = ref Iter.empty in
	for i=0 to n do
		for j=0 to n do		
			iter:=Iter.append (!iter) (Iter.cons ((i,j)) (Iter.singleton (i,j)))
		done
	done;
	!iter;;
  
let are_neighbours board (i, j) (i', j') =
  failwith "Unimplemented"

let is_valid_pos board (i, j) =
  failwith "Unimplemented"

let neighbours board (i, j) =
  failwith "Unimplemented"

let make () (* dim make_char*) =
  [|[|'a';'b';'c'|];[|'e';'f';'g'|];[|'p';'m';'m'|]|];;

let from_string s =
  failwith "Unimplemented"

let ij_from_iter iter =
	match iter with
	|((a,b -> c) -> c) -> (a,b);;

let print board =
	Iter.iter (print_char) (Iter.map get_letter (all_positions board));;
