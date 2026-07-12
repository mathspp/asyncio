# Threads

When you must run a CPU-bound task inside your asynchronous application, your best bet is to run that task in a separate thread with `asyncio.to_thread`.
By using `asyncio.to_thread`, you are able to integrate your CPU-bound task with the rest of your asynchronous code while making sure that your CPU-bound task won't block your main asynchronous application.

So, instead of wrapping `peel_and_slice` with an asynchronous function, you wrap it in `asyncio_to_thread`:

```py
import asyncio

from kitchenkit import *
from kitchenkit.prep import async_cook, async_microwave, peel_and_slice

async def lunch_prep():
    put_on_apron()
    food = await asyncio.gather(
        asyncio.to_thread(peel_and_slice, Avocado()),
        async_microwave(Meatloaf()),
        async_cook(Pasta()),
    )
    serve_food(*food)

if __name__ == "__main__":
    asyncio.run(lunch_prep())
```

Note how the function `peel_and_slice` isn't called with the argument `Avocado()`.
Instead, the argument(s) to `peel_and_slice` are passed as arguments to `to_thread`:

```py
...
asyncio.to_thread(peel_and_slice, Avocado()),
...
```

The thread that gets created will then pass the arguments to the function `peel_and_slice` at the right time.
On your end, `asyncio.to_thread` creates a coroutine, which is what you're passing into the call to `asyncio.gather`.

If you save this code and run it, you'll see that lunch prep takes 10 minutes, which is as fast as you can go, and you'll also see that you're able to get the meatloaf out of the microwave as soon as it's ready:

```text
[00:00] INFO     Let's get cooking! 🧑‍🍳
        INFO     Going to peel and slice the avocado.
        INFO     Going to microwave the meatloaf.
        INFO     What can I do to save time..?
        INFO     Going to cook the pasta.
        INFO     What can I do to save time..?
[00:03] INFO     The meatloaf is ready!
[00:04] INFO     The avocado is ready!
[00:10] INFO     The pasta is ready!
        INFO     Finished cooking in 10 minutes. ✨
        INFO     Now serving: avocado, meatloaf, pasta
```

```{note}
The _exact_ order of the first few prints can change.
What's important is to note that at `[00:03]` you're notified that the meatloaf is ready and at `[00:04]` that the avocado is ready.
```

When working with multiple threads, it is _not_ the event loop that is managing your threads.
So, it is _not_ the event loop that determines when you're working on the thread with the avocado or when you're working on the main thread, where the event loop and the async program is.
But the effect you get is that, while working on the avocado, you'll pause just for long enough to note that the meatloaf is ready at about the right time.
