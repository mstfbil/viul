# viul

> viul is an impractical and useless language

okay I made this out of pure boredom right. i'm not even gonna bother for a pretty readme. some examples are below for your pleasure.

*this is NOT a serious work.*

## examples

### hello world

```viul
"hello, viul!" .
```

### square of a number

```viul
6 .. * .
```

### if else

```viul
1 { "true" . } { "false" . } ??;
(try changing the 1 to a 0)
```

### markers

```viul
@ (this is a marker)
    <- (this jumps to the last seen marker)
(don't run this tho it's an infinite loop)
```

### print numbers 1 to 5

```viul
1 @ .. 5 <= { .. . ++ <- } ?;
(this practically combines if and marker to make a loop)
```

### print square numbers between 0 and 200

```viul
1 @ .. .. * .. 200 <= { . ++ <- } ?;
```
