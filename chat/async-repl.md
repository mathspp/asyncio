# Python async REPL

For this part of the course, you'll want to use the Python REPL to play around with async code.
However, the regular Python REPL is synchronous.
You can run coroutines, but you need to use `asyncio.run`, for example.

Python ships with an async-powered REPL that you can start with the command `python -m asyncio`, if you have the Python executable on your path, or with `uv run -m asyncio`, if you run Python through uv.

When you start an async REPL, the initial message will refer to a “asyncio REPL”.
It will also include a message saying you can use the keyword `await` directly.
Finally, it will auto-import the module `asyncio` for you:

![](asyncio_repl.png)

From now on, whenever you are told to use the REPL, you can assume it's the async REPL.
