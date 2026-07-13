# Managing tasks

When you call a function, the whole function runs from top to bottom.
It's only after the function returns that you can do something else.
But this model of execution — the **synchronous model of execution** —, won't cut it.
This is why it took you 13 minutes to prepare your lunch.

To be able to interleave your lunch prep tasks, they need to be defined differently.
Microwaving the meatloaf and cooking the pasta can't be regular functions.
They must be a different type of object that allows you to _switch_ to a different task during certain key moments.

Asynchronous code is single-threaded, so the task switching isn't obtained by having multiple threads working on multiple tasks.
So, how does that work?

Imagine you're preparing your lunch with the help of a chef.
You're doing all the work, but none of the thinking.
You only do what the chef tells you to do.

When you get to the kitchen, this is what happens:

 1. you tell the chef you want to prepare some meatloaf and some pasta
 2. the chef nods and tells you to put the meatloaf in the microwave
 3. when you do, you know you'll be left waiting, so you ask the chef if there's anything else you can do in the meantime
 4. the chef tells you to start cooking the pasta
 5. when you do, you know you'll be left waiting, so you ask the chef if there's anything else you can do in the meantime
 6. the chef tells you there's nothing to do and so you wait, twiddling your thumbs
 7. when the microwave dings, the chef tells you to go grab the meatloaf
 8. after you do, you ask the chef if there's anything else you can do in the meantime
 9. the chef tells you there's nothing to do and so you wait, twiddling your thumbs
 10. when the pasta is ready, the chef tells you to go grab the pasta
 11. your lunch is ready to eat

The chef is the one _managing_ the tasks you're working on.
In the context of asynchronous code, the chef is called an **event loop**:
the loop that runs your tasks and switches between them when appropriate.

The standard library comes with the module `asyncio`, a module that provides a way to run an **event loop**.
To run some tasks in an event loop, you can use the aptly named function `run` from the module `asyncio`.
But what do you pass to that function?
