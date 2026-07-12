# The event loop

There is a very important member of this kitchen analogy.
For you to be able to manage your time in the kitchen better, you need to overlap the waiting times, like the diagram shows:

![An arrow represents time and two rectangles that are left-aligned represent the 3m and the 10m it takes to microwave the meatloaf and cook the pasta, respectively.](async_lunch.png)

But this can only be done if there's a chef managing you in the kitchen.
When you put the meatloaf in the microwave, you know you'll be _waiting_ for it.
So, you turn to the chef and ask if there's anything else you could do while you're _waiting_.
The chef looks around and tells you to go take care of the pasta.

You go put the pasta in the pot and then you know you'll be _waiting_ for the pasta.
So, you turn to the chef and ask if there's anything else you could do while you're _waiting_.
The chef looks around and tells you there's nothing to do for now.
So, you're left there twiddling your thumbs.

A bit later, the chef tells you to go check on your meatloaf, since the microwave is done.
You plate the meatloaf and then you turn to the chef and ask what you're supposed to do.
Since there's nothing else to do, you're left there twiddling your thumbs.

A bit later, the chef tells you to go check on your pasta, since it's cooked already.
You plate the pasta and then you're ready to eat.

In your asynchronous code, the chef — the entity responsible for bossing you around and telling you what to work on — is the **event loop**.
That's why you need a module like `asyncio`:
the module defines an **event loop** that you can use to run your tasks.

But there's something else you need to pay attention to.
The chef can only tell you to go work on something else when you say you're _waiting_ for a task.
If you're busy chopping carrots, you can't stop that because you're not _waiting_ for something.
You're actively working.

In Python terms, the chef can only tell you to work on something else when you use the keyword `await`.
You can read it as “I'm going to (a)wait for this, so let me check if there's anything else I could be doing.”
You'll learn more about the keyword `await` next.
