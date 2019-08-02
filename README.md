# Deadlock in GCD

Please checkout demo first, and I do my best guess for analyzing deadlock.

In the running program, the system is spawning new threads for concurrent test queue, but each thread ends up waiting the cache to read object from memory and get stuck (which I can pause the program from deadlock situation and find out in the stack trace).

Why it get stuck? Because in the concurrent cache queue, `dispatch_sync` can not be executed if `dispatch_barrier_async` exists previously in the queue and waiting to be finished. However `dispatch_barrier_async` can not run because it needs new thread to submit its block onto. Unfortunately, almost each thread has being spawn and taken in the `for loop` parallel call, then end up waiting. 

Since thread is born to starve, the deadlock happens eventually when system run out of threads.

The reason for implementing this `RWCache` is that I want to create a reader/writer lock using GCD, so this demo cache can have single writing and multiple reading functionality. No intention for this to suck into deadlock.

If anything I explained here goes wrong, please leave a github issue and correct me. Appreciated!

![snapshot](https://github.com/huang-kun/Deadlock/blob/master/deadlock_snapshot1.jpg?raw=true)

