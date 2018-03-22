module M = struct
  include Map.Make (Char)

  let to_iter s=
    fun k ->
      iter (fun key item -> k (key, item)) s
end

type t = {
  eow : bool;
  words : t M.t;
}

let empty =
  (* Cette valeur vous est donnée, vous n'avez pas besoin de l'écrire
     vous-même. *)
  {
    eow = false;
    words = M.empty;
  }

let is_empty { eow; words } =
  if words=empty.words then true else false

(*let rec is_empty { eow; words } =
  if words=empty.words then true else false*)

(*
let has_empty_word { eow; words } =
  Iter.filter (fun x -> if x=true then true else false )(Iter.map (fun x -> is_empty { false; x }) M.to_iter words)
*)

  (*match (eow,words) with
  |(false,words) when is_empty {eow; words} = true -> true
  |(false,words) -> has_empty_word {words.eow; words}
  |(true,_)->false*)

let add word lexicon =
  let rec traverse n t =
    if n < String.length word then
      match t with
		  	| empty -> {eow= (n=(String.length word)-1); words=(traverse (n+1) empty)}
        | {eow=false; words=dict} when exists (fun (c,tr) -> c = word.[n]) dict ->
            traverse (n+1) (find word.[n] dict)
        | {eow=b; words=dict} -> {eow=false; words= add word.[n] (traverse (n+1) empty)}

	  else empty
  in traverse 0 lexicon

(*
  let rec traverse n lex =
    if n < String.length word then
      let t = ((List.nth 0 (to_rev_list (Iter.map (fun (c,j) -> if word.[n]=c then (c;j) else (c,empty)) (M.to_iter dict.words)))))
      match t with
      | t when is_empty t ->

      | t -> traverse (n+1) t
    else
  in traverse 0 lexicon*)

let rec to_iter { eow; words } =
  failwith "Unimplemented"

let letter_suffixes { eow; words } letter =
  failwith "Unimplemented"

let rec filter_min_length len { eow; words } =
  failwith "Unimplemented"

let load_file f =
  let rec load_channel channel acc =
    match input_line channel with
    | word -> load_channel channel (add word acc)
    | exception End_of_file -> acc
  in
  match open_in f with
  | channel -> Some (load_channel channel empty)
  | exception Sys_error _ -> None
