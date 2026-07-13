# Asynchronous code

This section will teach you how to write, read, and run **asynchronous code**.
Asynchronous code requires you to think about your program flow in a _non-linear_ way, which can prove to be quite challenging in production-scale applications.

To make async code as simple as possible, and to _ease_ you into the right way of thinking about asynchronous code, you'll start by understanding what async code is through some cooking analogies.
Then, you'll write your first lines of async code making use of `kitchenkit`, a package developed specifically to help you learn how to write asynchronous code and to use `asyncio`.

## Learning objectives

The learning objectives for this section are:

 - understanding the differences between synchronous and asynchronous code
 - knowing how to write simple asynchronous programs using `kitchenkit`, the module `asyncio`, and the keywords `async` and `await`
