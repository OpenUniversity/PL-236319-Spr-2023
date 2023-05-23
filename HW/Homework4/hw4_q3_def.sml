datatype 'a seq = Nil | Cons of 'a * (unit -> 'a seq);

fun counter () = let
  val count = ref 0;
  fun aux n () = Cons (n + 1, (
    count := 1 + !count;
    print ("exec: " ^ Int.toString (!count) ^ "\n");
    aux (n + 1)
  ))
in
  (Cons(0, aux 0))
end;
