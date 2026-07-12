# Asynchronous code execution

Take a look at the snippet of code shown below:

```py
def f():
    s = "How are you?"
    print(s)

def g():
    print("Hello!")

g()
f()
print("Nice talking to you! Bye!")
```

The snippet of code above has a handful of lines of code.
If you save that code into a file and run it, what's the output you get?

Running this piece of code, you get the output

```text
Hello!
How are you?
Nice talking to you! Bye!
```

The output looks like this because the code runs **synchronously**: sequentially, one line at a time, and going from top to bottom.
When Python runs your script, it does the following actions:

 1. defines the function `f`
 2. defines the function `g`
 3. calls the function `g`
 4. calls the function `f` (and, in turn, runs each line in the body of `f` one at a time and in order)
 5. prints a final message

With **asynchronous** code execution, you introduce flexibility in your code to not always run in sequence, allowing you to interleave the execution of different pieces of code.
But when would you interleave the execution of different pieces of code?
