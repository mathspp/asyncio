# Using the streams

To communicate between two processes you use the objects `StreamReader` and `StreamWriter` that you saw printed on the REPLs.

## Writing messages

If you have an object of the type `StreamWriter`, you can send messages by using the method `write`.
The method `write` expects bytes, not a string, and immediately after using it you should await the method `drain`.
So, in practice, writing some data will look like this:

```py
data = "Hello, world!\n"
stream.write(data.encode())
await stream.drain()
```

```{note}
The method `drain` is a lower-level detail that has to do with buffering.
At its core, you can say that the line `await stream.drain()` just makes sure you'll be able to write to the stream again.
```

## Reading messages

Objects of the type `StreamReader` have four different asynchronous methods that allow you to read data.
To make life easier for you, you can stick to using the asynchronous method `readline`, which reads a full line from the stream.

## Creating an echo server

Now that you know about the relevant stream methods, you can create a simple echo server in the REPL.
Close your two REPLs and open them again.

In one, you're going to define a connection callback that runs an infinite loop.
The loop will try to read a line from the reader stream and immediately writes it back to the writer stream:

```py
import asyncio

async def connection_callback(reader, writer):
    print("Connection made!")

    while True:
        data = await reader.readline()
        print(f"Got {data = }. Sending back.")
        writer.write(data)
        await writer.drain()

await asyncio.start_server(connection_callback, "localhost", 7342)
```

Paste that code into one of the REPLs to make the server.

In another, you can paste the following code:

```py
import asyncio

reader, writer = await asyncio.open_connection("localhost", 7342)
```

Once you do, you should immediately see the message `"Connection made!"` in the server REPL.

Now, in the client REPL, where you just opened a connection, you can try sending a message:

```pycon
>>> writer.write(b"Hello, world!\n")
>>> await writer.drain()
```

Make sure you're sending _bytes_ and that your message ends with a newline.

Once you send a full line, the server should report that it received some data and that it's sending it back.
In the client REPL, you can read that data back:

```pycon
>>> data = await reader.readline()
>>> print(data)
b'Hello, world!\n'
```

You just managed to create a simple echo server, connect to it, and then send data to it and read from it.

Believe it or not, you already possess all the knowledge and information required to create a chat app.
It won't be easy, but you already have all the required pieces.
The next sections will provide some guidance to help you write the chat server and chat client that enable a multi-user chatroom.
