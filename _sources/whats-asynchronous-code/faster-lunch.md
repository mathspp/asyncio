# Faster lunch

In the synchronous version of your lunch prep, you can represent the whole endeavour as the following diagram:

![An arrow represents time and two non-overlapping rectangles represent the 3m and the 10m it takes to microwave the meatloaf and cook the pasta, respectively.](sync_lunch.png)

The two rectangles represent the tasks of microwaving the meatloaf and cooking the pasta, but they're hollow because you're not really busy during those times.
The microwave is occupied, and the pasta is in the pot, but you're free to go and do something else.

So, instead of waiting for the meatloaf to be ready, you can start cooking the pasta while you're waiting for the meatloaf, effectively creating an overlap in the waiting time of the two tasks:

![An arrow represents time and two rectangles that are left-aligned represent the 3m and the 10m it takes to microwave the meatloaf and cook the pasta, respectively.](async_lunch.png)

You can start microwaving the meatloaf and cooking the pasta at the same time so that the time waiting for the meatloaf _overlaps_ with the time waiting for the pasta.
That's how you can speed up the process as a whole, even though you can't speed up any of the individual tasks.[^1]

[^1]: Strictly speaking, you _can't_ put the meatloaf in the microwave and the pasta in the pot at the exact same time. And things also don't happen at _the exact same time_ in code. But the time spent waiting is so much larger than the time spent starting the tasks that you can pretend they're starting at the same time.

The question now becomes “What's the code equivalent of managing my time better?”
