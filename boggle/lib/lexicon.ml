module M = struct
  include Map.Make (Char)

  let to_iter s =
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

let has_empty_word { eow; words } =
  failwith "Unimplemented"

let rec is_empty { eow; words } =
  if words=empty.words then true else false

let add word lexicon =
  failwith "Unimplemented"

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
