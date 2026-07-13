# Exercise: chat server

In this final exercise you're going to modify your echo server so it's actually a suitable server for your chat application.

If you think about it, in a chatroom, the server is similar to an echo server.
However, you don't want to echo a message to the user that wrote it.
Instead, you want to broadcast it to _everyone else_.
For this to be possible, you need to make each connection callback aware of the other connections that are alive, which is why the server is a class in the first place.

You're going to modify the file `server.py` to follow this structure:

```py
import asyncio


class Server:
    def __init__(self, host, port):
        ...
        # Map usernames to writers.
        self.connections = {}

    async def broadcast(self, sender, content):
        """Sends a message to every connection except the original sender.

        Traverses through all the available connections and writes the given
        content to that connection, unless that's the original sender.
        """

    async def connection_callback(self, reader, writer):
        """Implements a chatroom server.

        When a new connection is established, immediately reads the username
        sent from that new connection and saves it.
        Then, starts an infinite loop to read messages and to broadcast them
        to the other connections as they come in.
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

Make sure to add plenty of prints in your code to help you understand what's happening in your code.

When you're finished, you should be able to run your server, start 2 or 3 clients with different usernames, and then writing a message in one client should immediately show it in the server and in the other clients.

```{admonition} Extra challenge
What happens if your server is running and you close the async REPL with the client?
How can the server detect that a connection was closed by the client?
And how can the server handle the disconnection gracefully?
```
