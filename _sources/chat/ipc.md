# Inter-process communication

The module `asyncio` provides high-level tools that enable **IPC**, **inter-process communcation**.
In other words, the module `asyncio` has objects you can use to allow two programs to communicate with each other.

To have two programs that communicate, you need a **server** and a **client**.
The **server** is the program that is waiting for others to connect, and the **client** is the program that connects to the server.

## Creating a server

The module `asyncio` has the function `start_server` that allows you to create a server.
This server will wait for other programs to connect and will then do whatever you configure it to do.
In order to configure the server, you must provide three arguments:
 1. a connection callback — whatever this is
 2. the host for the server
 3. the port the server will listen on

The host and the port are the pieces of information that determine where your server lives and how clients can find you.
But it's the connection callback that determines what your server will be able to do.

For now, open an async REPL and paste this code:

```py
import asyncio

def connection_callback(*args):
    print(f"Inside the connection callback with {args = }.")

await asyncio.start_server(connection_callback, "localhost", 7342)
```

It's _very_ important that you _paste_ the code in an async REPL.
If you save the code as a file or if you paste it in a regular REPL, it won't work because of the keyword `await` outside an asynchronous function.

When you run the code, you'll see an object of the type `Server` being printed.
You just started a server that is waiting for clients to connect.

## Creating a client

To create a client, you use the function `asyncio.open_connection`, which only requires the host and the port from the server to connect to.

Open a new async REPL, without closing the previous one, and paste this code:

```py
import asyncio

await asyncio.open_connection("localhost", 7342)
```

As soon as you do, you should see some output in _both_ REPLs!
In the REPL with the server, you should your printed message and then some output mentioning a `StreamReader` and a `StreamWriter`.
In the REPL where you just opened the connection, you should also see some output mentioning the same two types of objects.

These stream readers and stream writers are the high-level objects that the module `asyncio` provides for you to communicate between processes.
Next, you'll learn how to use them.
