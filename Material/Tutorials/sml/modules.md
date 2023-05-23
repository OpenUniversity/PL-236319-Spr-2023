# Standard ML

## modules

---

### structures

A structure is a collection of bindings

```sml
structure MyModule = struct
    (*bindings*)
end
```

These are our modules in SML, or better considered as module implementations.

> Somewhat like a namespace in c++;

<!--vert-->

### structures

A module may contain any kind of binding:

```sml
structure MyModule = struct
    val answer = 42
    exception Failure of int
    type key = int
    fun foo x = x
end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### modules usage

Outside a module, we may refer to a binding like so:

```sml
MyModule.answer;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### modules usage

```sml
open MyModule;
answer;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

* Used to get direct access to the bindings of a module (kind of like `using namespace` in C++)
* Considered bad style

---

### signatures

A signature includes the types of the bindings in a module

```sml
signature SIGNAME = sig
    (*types for bindings*)
end

structure ModuleName :> SIGNAME = struct
    (*bindings*)
end
```

> Somewhat like a header file in C++

<!--vert-->

### signatures

```sml
signature MATHLIB = sig
    val pi: real
    val deg2rad: real -> real
end;

structure MathLib :> MATHLIB = struct
    val pi = 3.14
    fun deg2rad x = x / 180.0 * pi
end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### signatures

When a structure is matched to a signature, the compiler checks that it satisfies the signature requirements:

```sml
signature CONSTANTS = sig
    val pi: real
    val e: real
end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
structure MathConstants :> CONSTANTS = struct
    val pi = 3.14
end; (*ERROR*)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

```sml
structure MathConstants :> CONSTANTS = struct
    val pi = 3
    val e = 2.71
end; (*ERROR*)
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

---

### signature matching

```sml
structure Foo :> BAR
```

The compiler checks that:
* Every type in `BAR` is provided in `Foo` as specified
* Every val binding in `BAR` is provided in `Foo`
* Every exception in `BAR` is provided in `Foo`


<!--vert-->

### signature matching

```sml
structure Foo :> BAR
```

`Foo` may have more bindings than specified by `BAR`, however they are not accessible from outside the module
---

### functors

A functor is a parameterized module

```sml
functor Functor (Module: SIG) =
  struct
    (*bindings*)
  end;
```
> Somewhat like a template in C++

<!--vert-->

### functors

Applying a functor to a module creates a new module:

```sml
structure FModule = Functor(Module);
```

> Somewhat like a template instantiation in C++

<!--vert-->

### functors - exapmle

```sml
signature ORDERED_TYPE = sig
  type t
  val compare: t * t -> order
end;

structure Int' = struct
  type t = int
  val compare = Int.compare
end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### functors - example

```sml
functor SortedList (Elt: ORDERED_TYPE) = struct
  fun add x [] = [x]
    | add x (hd :: tl) = case Elt.compare (x, hd) of
        EQUAL => hd::tl
      | LESS => x :: hd :: tl
      | GREATER => hd :: (add x tl)
  (*more functions*)
end;
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### functors - example

```sml
structure SortedIntList = SortedList(Int');

open SortedIntList;
add 5 (add 6 (add 2 (add 4 (add 3 (add 1 [])))));
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->

<!--vert-->

### functors - example

```sml
structure SortedStringList = SortedList(struct
  type t = string
  val compare = String.compare
end);
open SortedStringList;
add "abc" (add "hij" (add "efg" (add "nop" (add "klm" []))));
```
<!-- .element: data-thebe-executable-sml data-language="text/x-ocaml" -->
