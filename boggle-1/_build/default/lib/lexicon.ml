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

let rec is_empty { eow; words } =
  eow==false && M.for_all (fun k t -> is_empty t) words


let add lexicon word =
  let rec traverse n t =
     if n < String.length word then
      if M.mem word.[n] t.words then
        let new_d = M.remove word.[n] t.words
        in
          {eow=t.eow;words= (M.add word.[n] (traverse (n+1) (M.find word.[n] t.words)) new_d)}
      else
        {eow=t.eow;words= (M.add word.[n] (traverse (n+1) empty) (t.words))}
    else
        {eow=true;words=(M.add (String.get " " 0) {eow=false;words=M.empty} t.words)}
  in traverse 0 lexicon




let rec to_iter { eow; words } =
  match words with
  | w when w = M.empty -> Iter.singleton " "
  | w when eow -> Iter.cons " " (Iter.flat_map (fun (k,t) -> Iter.map (fun s -> (String.make 1 k) ^ s) (to_iter t)) (M.to_iter w) )
  | w ->  Iter.flat_map (fun (k,t) -> Iter.map (fun s -> (String.make 1 k) ^ s) (to_iter t)) (M.to_iter w)


let letter_suffixes { eow; words } letter =
  if M.mem letter words then
      M.find letter words
  else empty


let rec filter_min_length len { eow; words } =
  let mots = (Iter.filter (fun x -> if String.length(x) > len || String.length(x) = len then true else false)(to_iter { eow; words })) in
      Iter.fold add empty mots


let has_empty_word { eow; words } =
  M.mem " ".[0] words


let load_file f =
  let rec load_channel channel acc =
    match input_line channel with
    | word -> load_channel channel (add acc word)
    | exception End_of_file -> acc
  in
  match open_in f with
  | channel -> Some (load_channel channel empty)
  | exception Sys_error _ -> None
