open Boggle
open Prelude

type t = unit -> unit

(* Vous pouvez supprimer la fonction suivante une fois le module
   implémenté. *)
let not_implemented f =
  let error msg =
    alert msg;
    failwith msg
  in
  Printf.ksprintf error "%s not implemented !" f
(* Fin de la fonction à supprimer *)

let ( ==> ) elt (action : unit -> unit) =
  let handler = Dom_html.handler begin
    fun evt -> (
         action();
      Js._true)
    end in

  elt##.onclick := handler
  (*not_implemented "( ==> )"*)

let ( => ) id action =
  let elt = Dom_html.getElementById id in
  ( ==> ) elt action
 (*not_implemented "( => )"*)

let reset_board () =
  State.Words.reset();
  Html.Words.display_found();
  State.Board.reset();
  State.Path.reset();
  Html.Path.display();
  Html.Board.display()

  (*not_implemented "reset_board"*)

let display_solutions () =
  Html.Words.display_solutions();
  let a = Dom_html.getElementById "check_word" in
  let opt = Dom_html.CoerceTo.button a in
  let b = Js.Opt.get opt (fun() -> failwith "erreur") in
  b##.disabled := Js._true

let path_add_tile (i, j) () =
  State.Path.add_tile (i, j);
  Html.Path.display()

let check_word () =
  State.Words.check (Path.to_string (State.Board.get()) (State.Path.get()));
  Html.Words.display_found();
  State.Path.reset();
  Html.Path.display()
