# CPU-bound tasks

So far, you've been writing async code with **I/O-bound** tasks.
A task is **I/O-bound** if the time it takes to complete depends mostly on waiting for something external, like the user providing input or a server responding to a request.
In the cooking analogy, you're waiting for the food items to be ready.

Typical applications also contain **CPU-bound** tasks.
A task is **CPU-bound** if the time it takes to complete depends mostly on your CPU doing work, like crunching some numbers or processing some data.
In the cooking analogy, an example of a CPU-bound task could be peeling and slicing some food.

Suppose that you want to add some avocado to your lunch.
To prepare the avocado, you need to peel and slice it.
While you're peeling and slicing, you are _busy_ working, your hands are occupied, and you can't do anything else.
Because you're busy doing meaningful work, you won't be able to switch tasks while you're taking care of the avocado.

The module `kitchenkit.prep` provides a synchronous function called `peel_and_slice`.
(CPU-bound work is typically synchronous.)
How can you modify your previous code to add avocado to your meal while keeping the lunch prep time as short as possible?

Because the function `peel_and_slice` is synchronous, you can't add it inside `asyncio.gather`.
One possibility is to add it before `asyncio.gather`:

```py
from kitchenkit import *
from kitchenkit.prep import async_cook, async_microwave, peel_and_slice

async def lunch_prep():
    put_on_apron()
    avocado = peel_and_slice(Avocado())
    food = await asyncio.gather(
        async_microwave(Meatloaf()),
        async_cook(Pasta()),
    )
    serve_food(*food, avocado)
```

If you modify the function `lunch_prep` to call `peel_and_slice` before `asyncio.gather`, running the code should now produce this output:

```text
(TODO) add output here, should take 14 minutes
```

Lunch prep is now taking 14 minutes instead of 10 because you're spending 4 minutes peeling and slicing the avocado before you let the event loop take care of the meatloaf and the pasta.
Your task management looks like this:

![An arrow represents time and two rectangles that are left-aligned represent the 3m and the 10m it takes to microwave the meatloaf and cook the pasta, respectively. To their left, a completely filled rectangle takes 4m to represent the avocado.](pre_avocado_async_lunch.png)

The red block on the left corresponds to working on the avocado, which is time during which you can't do anything else.

You could also try calling `peel_and_slice` _after_ `asyncio.gather`, but that amounts to moving the red rectangle to the right end of the diagram.

Ideally, you'd want the avocado rectangle to be inside the two other hollow rectangles:

![An arrow represents time and two rectangles that are left-aligned represent the 3m and the 10m it takes to microwave the meatloaf and cook the pasta, respectively. Also aligned, but completely filled, is a rectangle representing the 4m it takes to prepare the avocado.](avocado_async_lunch.png)

To have the avocado task rectangle inside the other two task rectangles, you might be tempted to wrap `peel_and_slice` inside an asynchronous function:

```py
async def prep_avocado():
    return peel_and_slice(Avocado())
```

Once the asynchronous function `prep_avocado` is defined, you can call it and schedule the resulting coroutine inside `asyncio.gather`, together with the coroutines for the meatloaf and the pasta:

```py
import asyncio

from kitchenkit import *
from kitchenkit.prep import async_cook, async_microwave, peel_and_slice

async def prep_avocado():
    return peel_and_slice(Avocado())

async def lunch_prep():
    put_on_apron()
    food = await asyncio.gather(
        prep_avocado(),
        async_microwave(Meatloaf()),
        async_cook(Pasta()),
    )
    serve_food(*food)

if __name__ == "__main__":
    asyncio.run(lunch_prep())
```

If you save this code in `avocado.py` and run it, you'll get the following output:

```text
[00:00] INFO     Let's get cooking! 🧑‍🍳
        INFO     Going to peel and slice the avocado.
[00:04] INFO     The avocado is ready!
        INFO     Going to microwave the meatloaf.
        INFO     What can I do to save time..?
        INFO     Going to cook the pasta.
        INFO     What can I do to save time..?
[00:07] INFO     The meatloaf is ready!
[00:14] INFO     The pasta is ready!
        INFO     Finished cooking in 14 minutes. ✨
        INFO     Now serving: avocado, meatloaf, pasta
```

But this code wasn't right!
Lunch is still taking 14 minutes to cook because you're starting with the avocado and that's blocking all the other work.

As an attempt to fix this, you can move the coroutine `prep_avocado()` to the bottom of the call to `asyncio.gather`:

```py
...
food = await asyncio.gather(
    async_microwave(Meatloaf()),
    async_cook(Pasta()),
    prep_avocado(),  # <--
)
...
```

And this might _look_ like it fixes it...
If you run this modified version, output looks like this:

```text
[00:00] INFO     Let's get cooking! 🧑‍🍳
        INFO     Going to microwave the meatloaf.
        INFO     What can I do to save time..?
        INFO     Going to cook the pasta.
        INFO     What can I do to save time..?
        INFO     Going to peel and slice the avocado.
[00:04] INFO     The avocado is ready!
        INFO     The meatloaf is ready!
[00:10] INFO     The pasta is ready!
        INFO     Finished cooking in 10 minutes. ✨
        INFO     Now serving: meatloaf, pasta, avocado
```

Note that you only became aware that the meatloaf was ready at minute 4, 1 minute _after_ it was _actually_ ready.
That's because taking care of the avocado is a CPU-bound task that is keeping you very busy, preventing you from checking the other items:

The CPU-bound avocado task is **blocking**.
While you're on that red rectangle, you can't do anything else.
That's why you only realise the meatloaf is ready 1 minute too late:

![](async_lunch_late_meatloaf.png)

When you have CPU-bound tasks, or blocking work, you can use a different mechanism to make sure the asynchronous part of the application remains responsive.
That's what you'll learn about next.
