# RTTI

---

### motivation

Let's say we would like to implement a garbage collection algorithm, e.g. mark & sweep or stop & copy.

<!--vert-->

### motivation

In order to implement the algorithm, we need a way to find all "reachable" variables from a certain pile of bits.

How do we traverse a network of
data connected to other data?

<!--vert-->

### motivation

For example, a class instance may have fields in it, which may themselves have fields in them.
the same 16 bytes may be interpreted in countless different ways, and when we reach a value, we may not know what's in it!

<!--vert-->
### example
consider the following C `struct`s
```C
struct S1 {
    int x;
};
struct S2 {
    int *ptr;
};
```
<!--vert-->

Assume `sizeof(int) == sizeof(int*) && sizeof(int*) == 8`.

Given an 8 byte long variable, how can we know if it has to be interpreted as `S1` or as `S2`?

<!--vert-->

This is a problem because it shows *we cannot tell apart pointers and data*, making implementing GC impossible.

Conclusion: we must have type information at *runtime*

<!--vert-->

The problem of traversal on networks of objects is not specific to garbage collection algorithms, and recurs in various other places like deep cloning and serialization.

<!--vert-->

It is especially pronounced in languages with dynamic typing - types must be checked in runtime, and therefore, we must save type information so it is available in runtime.

<!--vert-->
Statically-typed languages can check for *type errors* in compile time and from there assume all field accesses are valid.

In dynamically-typed languages, RTTI is necessary for type checking

statically-typed languages can benefit from RTTI too

---

### the solution

<!--vert-->

**RTTI**: Runtime Type Information
- Additional data attached to each cell in memory
- Specifies the type of the data to which it is attached
- Is useful in both statically and dynamically typed languages

<!--vert-->

RTTI is used for:

* Serialization
* Deep-cloning
* Garbage collection

NOTE: these are purposes that require traversal of a type structure that has to be known in runtime

in dynamically-typed languages, also:
* type checking

<!--vert-->

C has a "no hidden costs" policy (also known as *the supermarket principle*) - when a programmer allocates memory, it should be guaranteed that no extra memory is used.
therefore, these languages *do not* have RTTI

> Note that C++ does hold RTTI in some objects, more on that in OOP class

<!--vert-->

This is why these languages **do not, and can not**, have general purpose GC, serialization, cloning or any "deep" operations.
 
<!--vert-->

Let's consider the following snippet regarding a variable `today` which has fields `day`, `month`, `year`:
```javascript
today.day = 35;
```
This snippet is valid Java as well as valid JavaScript. however, when ran, both languages work differently to interpret it.
<!--vert-->
In Java, we first dereference `today`, ignoring RTTI (it is not used for field access in Java), advance by `off(day)` and update the field.

The offset `off(day)` is known in compile-time, because Java is statically-typed.
<!--vert-->
In JavaScript, we also dereference `today`, but we must examine the RTTI to determine `off(day)` to then advance by it and update the field.
this is because JavaScript is dynamically-typed.

NOTE: in this case, C would operate similarly to Java, except it has no RTTI to ignore.

<!--vert-->
JavaScript's dynamic typing causes it to not know the required offsets in compile time. 

This example demonstrates the difference between statically- and dynamically-typed languages in their use of RTTI.
