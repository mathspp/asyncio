# Preparing lunch is I/O bound

Preparing your lunch is an example of an I/O-bound task in the real world.

Suppose that you're having meatloaf and pasta for lunch.
You need to boil the pasta for 10 minutes and you need to microwave the meatloaf for 3 minutes.
How long does it take you to prepare your lunch?

The answer is _13 minutes_.
Here's how you can use Python to check this:

```py
from kitchenkit import *
from kitchenkit.prep import cook, microwave

def main():
    put_on_apron()
    meatloaf = microwave(Meatloaf())
    pasta = cook(Pasta())
    serve_food(pasta, meatloaf)

if __name__ == "__main__":
    main()
```

The package `kitchenkit`, used above, allows you to simulate your lunch prep.
It's a package designed as a pedagogical tool for learning `asyncio`, so you'll use it often in this course.

You can save the code in the file `lunch.py` and then use uv to run it _with_ the dependency on `kitchenkit`:

```bash
% uv run --with kitchenkit lunch.py
```

If you do so, the output will looks like this:

```text
[00:00] INFO     Let's get cooking! 🧑‍🍳
        INFO     Going to microwave the meatloaf.
[00:03] INFO     The meatloaf is ready!
        INFO     Going to cook the pasta.
[00:13] INFO     The pasta is ready!
        INFO     Finished cooking in 13 minutes. ✨
        INFO     Now serving: meatloaf, pasta
```

The timestamps on the left show why it takes 13 minutes to get your lunch ready.
First, you microwave the meatloaf.
Then, you just stand there, waiting for the microwave to finish.
You only turn your attention to the pasta _after_ the meatloaf is done.

Microwaving the meatloaf and cooking the pasta are akin to I/O-bound tasks because you're just standing there, waiting for the food to be ready.
There's nothing you can do to speed the process up.

Or is it?
While you can't speed up any of the _individual tasks_, your lunch prep as a whole can be faster.
In fact, you can get your lunch ready in just 10 minutes.
But how?

That's where asynchronous code execution comes into play.
