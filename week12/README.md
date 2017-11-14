# Week 12: Transactions and Concurrency Control

## Admin
- Midterm regrade requests due Friday
- HW5 (last homework) due next Tuesday

## Transactions
- A __transaction__ is a sequence of reads and writes to specific tuple ids.
- Concretely, here is what a transaction looks like in SQL:

    CREATE TABLE R (tuple_id text PRIMARY KEY, val integer);
    INSERT INTO R VALUES ('x', 0), ('y', 0), ('z', 0);

    BEGIN TRANSACTION
    x = SELECT val from R WHERE tuple_id = 'x';
    UPDATE R SET val = x + 1 WHERE tuple_id = 'y';
    COMMIT

- We can think of these txns more abstractly like this: R(x, 0), W(y, 1).
    - R(x, 0) and W(y, 1) are __operations__
    - R(x, 0) corresponds to the SELECT query
    - W(y, 1) corresponds to the UPDATE query
- If we don't care about the specific values, we can write it as R(x), W(y)
- We might also have multiple transactions issuing reads and writes to a
  database at the same time. We'll subscript the reads and writes with the
  transaction id. e.g. W_1(x), R_2(y)
- A sequence of operations is called a __history__:
    - e.g. W_1(x), W_2(x), W_2(y), R_1(x)
    - W(x)
    -      W(x)
    -      W(y)
    - R(x)

## Concurrency
- Assume multiple users want to concurrently execute transactions.
- Executing multiple transactions concurrently can improve the throughput and
  reduce the latency of the database.

## Problems with Concurrency?
- When transactions execute concurrently, it becomes hard to reason about your
  code. For example, invariants can be broken.
- Write-Write (overwriting uncommitted data)
    - Invariant: x = y
    - W(x)
    -       W(x)
    -       W(y)
    - W(y)
- Write-Read (dirty read)
    - Invariant: x = y
    - W(x)
    -       R(x)
    -       R(y)
    - W(y)
- Read-Write (unrepeatable read)
    - Invariant: if x == 0, then z == 0
    - R(x)
    -       W(x)
    - W(z)

## Serializability and Conflict Serializability
- To allow for concurrent transactions without giving programmers a headache,
  we'd like to make some guarantees about how we interleave transactions.
- We say a history is __serial__ if every transactions' operations are grouped
  together. Corresponds to running the transactions one at a time.
- We say a history is __serializable__ if it is "equivalent" to some serial
  execution. Talk to me after class about this definition; tightening down a
  formal definition can be tough. e.g. see lecture notes about view
  serializability.

- Instead, we'll formalize conflict serializability.
- Say two operations __conflict__ if they are of the form:
    - W_i(x), W_j(x) i != j
    - R_i(x), W_j(x) i != j
    - W_i(x), R_j(x) i != j
- Say two histories are __conflict equivalent__ if they have the same
  operations and order of conflicting operations.
- A history is __conflict serializable__ if it is conflict equivalent to some
  serial schedule.
- Precedence graph
    - Node for every transaction
    - An edge from i to j if there exists an operation O_i that precedes O_j in
      the history.
- An example:
    - W(x)
            R(y)
                   R(x)
            R(z)
            W(z)
      R(z)
      W(x)
                   R(z)
      C
            C
                   C
- Worksheet problem 1
- Conflict serializability implies serializability. That is, to clients, a
  conflict serializable schedule appears as if the clients had just been run
  one by one.

## Two-Phase Locking
- Every tuple is associated with a lock
- Before you read an item, you try to acquire the lock in shared mode
- Before you write an item, you try to acquire the lock in exclusive mode
- The lock is either held in shared mode or exclusive mode
- Multiple transactions can hold a lock in shared mode at a time
- Only one transaction can hold a lock in exclusive mode at a time

- Example
    - W(x) R(y) R(x)
      R(z) R(z) R(z)
      W(x) W(z)
    - 1 2 3 2 2 1 2_commit 1 1 1_commit 3 3 3_commit
    - Draw history as we go
    - Draw conflict graph at the end
    - Challenge students to construct an execution which is not conflict
      serializable

- Why does this work?
    - If two transactions have a conflicting operation, one will block when it
      goes to

- Why two phase?
    - Challenge students to construct an execution which is not conflict
      serializable
    - Can do the one from before by acquiring and immediately releasing locks.

## Deadlock Prevention and Detection
- Deadlock
    - W(x) W(y)
      W(y) W(x)
    - Run students through and hit deadlock

- Deadlock Prevention
    - Make deadlock impossible
    - Wound-wait: higher priority transactions kill transactions that hold
      locks it wants; lower priority transactions wait (higher priority
      transcations never wait for lower priority transcations; this prevents
      cycles)
    - Wait-die: higher priority transactions wait; lower priority transactions
      kill themselves (lower priority transactions never wait for higher
      priority transactions; this prevents cycles)

- Wound-wait; T1 priority
    - W_1(x), W_2(y), W_1(y)[kill], C1, ...
- Wait-die; T1 priority
    - W_1(x), W_2(y), W_1(y)[wait], W_2(x)[die], W_1(y), ...

## Multiple Granularity Locking
- Likely not enough time.
