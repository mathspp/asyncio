# Exercise: echo server

You're going to develop a standalone echo server in the file `server.py`.
When you're done, running the file `server.py` should start a server that waits for connections.
Whenever you connect to your server — for example, from an async REPL —, the data you send to the server should be immediately sent back.

Your file `server.py` should follow this structure:

```py
import asyncio


class Server:
    def __init__(self, host, port):
        ...

    async def connection_callback(self, reader, writer):
        """Implements an echo server.

        Contains an infinite loop that reads data from the reader
        and sends it back to the writer.
        """

    async def run(self):
        """Creates and runs the `asyncio` server.

        Initialises an `asyncio` server with the attributes passed earlier
        and then uses the method `server_forever` to listen for connections.
        """
        ...
        await server.serve_forever()


async def main():
    server = Server("localhost", 7342)
    await server.run()


if __name__ == "__main__":
    asyncio.run(main())
```

```{note}
Take a look at the line of code `await server.serve_forever()` in the method `Server.run`.
In the async REPL, the server is automatically running forever, waiting for connections, because the server is kept alive by the REPL itself.
In here, because you're in a Python file, you're going to need to use the asynchronous method `serve_forever`.
```

Make sure to add plenty of prints in your own code.

When you're done, you can test your server by opening an async REPL and trying to open a connection to this server, sending some data, and checking if you're getting the data back.

```{admonition} Extra challenge
Modify your echo server so it's a “reverse echo server”.
Instead of sending the exact same data back, it should reverse it.
This is tricker than what it sounds, so give it a try and then _test the server_ to check whether it's working or not.
```

You should also test your server by opening 2+ different async REPLs and connecting them to the same server.
Your server should be able to handle multiple connections.
For now, they're all independent.
You're going to fix that soon.

```{admonition} Extra challenge
What happens if your server is running and you close the async REPL with the client?
How can the server detect that a connection was closed by the client?
And how can the server handle the disconnection gracefully?
```
