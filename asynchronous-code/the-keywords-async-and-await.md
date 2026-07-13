# The keywords `async` and `await`

The functions `cook` and `microwave`, from earlier, are synchronous functions.
They can't be used with `asyncio.run` because they are not compatible with the **asynchronous execution model**.
But the package `kitchenkit` does come with two **asynchronous functions** that _are_ compatible with the asynchronous execution model:
 1. `async_cook`
 2. `async_microwave`

Using the two, you can write a new version of your lunch prep function:

```py
from kitchenkit import *
from kitchenkit.prep import async_cook, async_microwave

async def lunch_prep():
    put_on_apron()
    meatloaf = await async_microwave(Meatloaf())
    pasta = await async_cook(Pasta())
    serve_food(pasta, meatloaf)
```

Note how the keyword `await` is used in the line `meatloaf = await async_microwave(Meatloaf())`.
The usage of the keyword `await` marks the usage of an asynchronous function and tells the event loop that you want to wait for the result of the asynchronous function `async_microwave`.
The result that you _eventually_ get is saved in the variable `meatloaf`.

Next, you use the keyword `await` in `pasta = await async_cook(Pasta())`.
The keyword `await` here tells the event loop that you want to wait for the result of the asynchronous function `async_cook`.
The result that you _eventually_ get is saved in the variable `pasta`.

The keyword `await` can only be used inside asynchronous functions, which is why you need to define the function `lunch_prep` with the keywords `async def`, instead of just `def`.
This turns `lunch_prep` into an **asynchronous function**.
Being an asynchronous function, that means you can't run it by just calling `lunch_prep`.

Open the REPL, define a simple asynchronous function, and then call it:

```pycon
>>> async def f():
...     print("Hello, world!")
...
>>> f()
<coroutine object f at 0x10a23d780>
```

```{note}
A function becomes an **asynchronous function** if you define it with `async def`.
You do not need to use the keyword `await` inside a function for it to be an asynchronous function.
However, if you want to use the keyword `await`, it _must_ be inside an asynchronous function.
```

When you call the asynchronous function `f` you get a **coroutine** object and you don't see the result of the call to `print`.
That's because a coroutine doesn't start running the function.
Instead, it's an object that the event loop can manage.

To run your coroutine, use `asyncio.run`:

```pycon
>>> import asyncio
>>> asyncio.run(f())
Hello, world!
```

In the same way, you can use `asyncio.run` to run the coroutine returned by `lunch_prep`:

```py
import asyncio  # <--

from kitchenkit import *
from kitchenkit.prep import async_cook, async_microwave

async def lunch_prep():
    put_on_apron()
    meatloaf = await async_microwave(Meatloaf())
    pasta = await async_cook(Pasta())
    serve_food(pasta, meatloaf)

if __name__ == "__main__":
    asyncio.run(lunch_prep())  # <--
```

Save the snippet of code above into the file `async_lunch.py` and run it with

```bash
% uv run --with kitchenkit async_lunch.py
```

If you do so, the output will look like this:

```text
(TODO) add output here that should still take 13 seconds
```

The code runs smoothly, but lunch prep is _still_ taking 13 minutes.
Why?

Coroutines can be interleaved with each other.
That's what the keyword `await` is for.
When the event loop hits the keyword `await`, it may switch to _another_ coroutine.
But the body of a single coroutine still runs synchronously, from top to bottom.
If you're executing the line `meatloaf = await ...`, you can't magically jump to the line `pasta = await ...`.

Next up, you'll learn how to actually run `async_cook` and `async_microwave` concurrently.
