(** Module pour résoudre les grilles de Boggle. *)
val backtrack : Board.t -> Lexicon.t -> Path.t -> int * int -> Path.t Iter.t


val find_all_paths : Board.t -> Lexicon.t -> Path.t Iter.t
(** Étant donnés une grille et un lexique, renvoie un itérateur sur
   tous les chemins possibles dans la grille formant un mot présent
   dans le lexique. *)
