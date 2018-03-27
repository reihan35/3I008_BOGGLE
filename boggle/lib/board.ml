type t = char array array

let get_letter board i j =
  board.(i).(j);;

let dim board =
  Array.length board;;

let all_positions board =
  let n = dim board
  in
  Iter.product (Iter.range 0 (n-1)) (Iter.range 0 (n-1))

let are_neighbours board (i, j) (i', j') =
  match (i',j') with
    | (i',j') when i'=(i+1) && j'=j -> true
    | (i', j') when i'=i && j'=(j+1) -> true
    | (i', j') when i' = (i+1) && j' = (j+1) -> true
    | (i', j') when i' = (i+1) && j' = (j-1) -> true
    | (i', j') when i' = (i-1) && j' = (j+1) -> true
    | (i',j') when i'=(i-1) && j'=j -> true
    | (i', j') when i'=i && j'=(j-1) -> true
    | (i', j') when i' = (i-1) && j' = (j-1) -> true
    | (i', j') -> false

let is_valid_pos board (i, j) =
  let n = dim board in
  match (i, j) with
  | (i,j) when i < 0 || j < 0 -> false
  | (i,j) when i >= n || j >= n -> false
  | (i,j) -> true

let neighbours board (i, j) =
  Iter.filter (are_neighbours board (i,j) ) (all_positions board)

let make dim make_char =
  let board = ref (Array.make_matrix dim dim 'a') in
    for i=0 to dim-1 do
      for j=0 to dim-1 do
        (!board).(i).(j) <- make_char ()
      done
    done;
  !board

let from_string s =
  let n = String.length s in
  match n with
  |n when n=0 ->None
  |n when (Iter.exists (fun x-> if x*x = n then true else false)(Iter.range 1 10000))->
    let dim = (int_of_float(sqrt (float_of_int n))) in
    let cpt = ref 0 in
      let board = ref (Array.make_matrix dim dim 'a') in
        for i=0 to dim-1 do
          for j=0 to dim-1 do
            (!board).(i).(j)<-s.[!cpt];
            cpt := !cpt + 1
          done
        done;
      Some(!board)
  |n ->None

let print board =
  let cpt= ref 0 in
  Iter.iter (fun x ->
            if !cpt = 0 then print_string "{[";
            print_char x;
            print_string " ";
                      incr cpt;
                      if !cpt mod (dim board)=0 && !cpt<dim board*dim board then
            print_char '\n';
            if !cpt== dim board*dim board then
              print_string "]}" ;
                          )
    (Iter.map (fun (i,j) -> (get_letter board i j)) (all_positions board));;