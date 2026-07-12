# Running multiple tasks

When you have two or more coroutines that you want to run concurrently, you can submit them to the event loop at the same time.
By doing so, the event loop will be able to switch between the multiple tasks you submit instead of running each one in sequence.

One way to run `async_cook` and `async_microwave` concurrently is by using the function `asyncio.gather`.
The function `asyncio.gather` accepts multiple coroutines as arguments.
It will schedule all the coroutines to be handled by the event loop and _then_ you can use the keyword `await` to fetch the _aggregated_ results of the coroutines passed in.

For your lunch prep example, the code looks like this:

```py
import asyncio

from kitchenkit import *
from kitchenkit.prep import async_cook, async_microwave

async def lunch_prep():
    put_on_apron()
    gathered_prep = asyncio.gather(
        async_microwave(Meatloaf()),
        async_cook(Pasta()),
    )
    food = await gathered_prep
    serve_food(*food)

if __name__ == "__main__":
    asyncio.run(lunch_prep())  # <--
```

The snippet above assigned the result of calling `gather` to the variable `gathered_prep` and _then_ used the keyword `await` on the variable `gathered_prep` to show that scheduling the coroutines and waiting for them to finish are two separate steps.
It is entirely possible to do both things together:

```py
async def lunch_prep():
    put_on_apron()
    food = await asyncio.gather(
        async_microwave(Meatloaf()),
        async_cook(Pasta()),
    )
    serve_food(*food)
```

Update the file `async_lunch.py` with _either_ version of `lunch_prep` and run it with

```bash
% uv run --with kitchenkit async_lunch.py
```

Now, the output looks like this:

```text
(TODO) include output that should complete in 10s
```

The total prep time is now 10 minutes, which shows that you were able to effectively handle the meatloaf and the pasta concurrently.
Congratulations!

Up next, you're going to solve some exercises to check your understanding so far.
