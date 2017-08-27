---
title: urn/set
---
# urn/set
This module implements hash sets as backed by hash maps, optionally
with a custom hash function.

## `(element? set val)`
*Defined at lib/urn/set.lisp:36:1*

Check if `VAL` is an element of `SET`.

### Example:
```cl
> (element? (set-of 1 2 3) 1)
out = true
```

## `(insert set &vals)`
*Defined at lib/urn/set.lisp:67:1*

Build a copy of `SET` with VALs inserted.

### Example
```cl
> (insert (set-of 1 2 3) 4 5 6)
out = «hash-set: 1 2 3 4 5 6»
```

## `(insert! set &vals)`
*Defined at lib/urn/set.lisp:48:1*

Insert `VALS` into `SET`.

### Example
```cl
> (define set (set-of 1 2 3))
out = «hash-set: 1 2 3»
> (insert! set 4)
out = «hash-set: 1 2 3 4»
> set
out = «hash-set: 1 2 3 4»
```

## `(intersection a b)`
*Defined at lib/urn/set.lisp:103:1*

The set of values that occur in both `A` and `B`.

### Example:
```cl
> (intersection (set-of 1 2 3) (set-of 3 4 5))
out = «hash-set: 3»
```

## `make-set`
*Defined at lib/urn/set.lisp:6:1*

Create a new, empty set with the given `HASH-FUNCTION`. If no
hash function is given, [`make-set`](lib.urn.set.md#make-set) defaults to using object
identity, that is, [`id`](lib.prelude.md#id-x).

**Note**: Comparison for sets also compares their hash function
with pointer equality, meaning that sets will only compare equal
if their hash function is _the same object_.

### Example
```
> (make-set id)
out = «hash-set: »
```

## `(set->list set)`
*Defined at lib/urn/set.lisp:133:1*

Convert `SET` to a list. Note that, since hash sets have no specified
order, the list will not nescessarily be sorted.

## `(set-of &values)`
*Defined at lib/urn/set.lisp:121:1*

Create the set containing `VALUES` with the default hash function.

### Example:
```cl
> (set-of 1 2 3)
out = «hash-set: 1 2 3»
```

## `(union a b)`
*Defined at lib/urn/set.lisp:84:1*

The set of values that occur in either `A` or `B`.

### Example:
```cl
> (union (set-of 1 2 3) (set-of 4 5 6))
out = «hash-set: 1 2 3 4 5 6»
```

## Undocumented symbols
 - `$set` *Defined at lib/urn/set.lisp:6:1*
 - `(set? r_751)` *Defined at lib/urn/set.lisp:6:1*