# Exercise: chat client

Now, you're going to develop a standalone client in the file `client.py`.
When you're done, running the file `client.py` should connect you to the server from the file `server.py`.

The client requires a bit more work because you need to have two coroutines running at the same time:
 - one that asks the user for input to send
 - another that reads data to print to the user

Your file `client.py` should follow this structure:

```py
import asyncio

class Client:
    def __init__(self, username, host, port):
        ...

    async def read_loop(self):
        """Asynchronous function that implements a read loop.

        In an infinite loop, reads lines from the server and prints them
        for the user.
        """

    async def write_loop(self):
        """Asynchronous function that implements a write loop.

        In an infinite loop, uses the built-in `input` to ask the user
        for input and writes it to the underlying writer stream.
        When writing the data, always prepends it with the username.
        For example, if the user writes 'Hello, world!', the client writes
        the message 'my_username: Hello, world!'.
        """

    async def run(self):
        """Runs the client.

        Opens a connection to the server, immediately sends a message with
        _only_ the username, and then schedules the coroutines
        `write_loop` and `read_loop` to run. Since they're infinite loops,
        that sets the client to run forever.
        """


async def main():
    client = Client("your_username", "localhost", 7342)
    await client.run()


if __name__ == "__main__":
    asyncio.run(main())
```

For your client, it's important that the method `run` starts by sending a single line with _just_ the client username to the server.
This is so that the client identifies itself before the server.
Similarly, you want the write loop to prefix each message with your username.

Right now, the server is an echo server so it doesn't make a difference.
But it's going to be relevant in the next step, when you adapt the server to handle multiple users.

When you're done, you can test your client by opening the echo server from the previous exercise and then this client.
Your client should be able to connect to the echo server, you should be able to write messages, and you should see the messages being printed right back at you.

```{admonition} Extra challenge
How can you let the user specify the username from the command line?
```
