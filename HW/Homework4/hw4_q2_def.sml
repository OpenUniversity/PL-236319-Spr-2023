datatype 'a tree =
    Nil
  | Br of 'a * ('a tree) * ('a tree);

datatype ('a, 'b) union = type1 of 'a | type2 of 'b;