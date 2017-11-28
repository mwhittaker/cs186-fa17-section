# Week 14: ARIES

## Admin
- Final is 2 weeks from yesterday
- 268 HW due this Sunday.
- This is the last section!

## Recovery Overview
- Recall our model of a database. We are given a sequence of reads and writes
  that looks something like this:

  T_1: W(A)           C
  T_2:      W(B)        W(D)      C
  T_3:           W(C)        W(E)   W(F) C

- The goal of a recovery algorithm is to ensure that if the database crashes at
  any point in time, the effects of all committed transactions are persisted
  (Durability) and all in-progress transactions are aborted (Atomicity).

## ARIES
- Walk through mwhittaker.github.io/aries demo

## Normal Processing
- Log (everything else hidden)
    - We will log every action that we do
    - Explain LSN, txn id, type, page id, before and after contents, prevLSN.
- Transaction Table (DPT, BP, Disk hidden)
    - We record the status and lastLSN of every transaction
    - Note that when a transaction commits, and ends, it is removed from the
      transaction table
- DPT, BP, Disk (nothing hidden)
- Checkpoint saves dirty page table, and transaction table

- Things to note:
    - DPT, TT, BP kept in memory
    - Some of the log in memory, some of the log on disk
    - Checkpoints save DPT and TT, not BP

## Crash
- Things to note:
    - All in-memory data structures are lost.

## Analysis
- Begins at the last checkpoint, restores the saved dirty page table and
  transaction table
- Update the dirty page table and transaction table
- Do not touch buffer pool or disk
- Mark all transactions at the end of analysis as aborted

- Things to note:
    - Analysis begins at the latest checkpoint
    - Updates DPT and TT, but not BP or disk

## Redo
- Things to note:
    - Start at the smallest recLSN in the DPT
    - If no flushes, only touches the buffer pool (if flushes, could affect DPT
      and BP)
    - Condition 1: Page is not in dirty page table
    - Condition 2: Page in DPT with greater recLSN
    - Condition 3: pageLSN on disk is greater than or equal to LSN

## Undo
- Calculate loser transactions and start undoing them
- Note that transaction table and buffer pool are updated
- At the end of undo, the transaction table is empty
- Note that the buffer pool ends up in the state we want. T1's actions are
  persisted and the other transactions' effects are reverted.

- Things to note:
    - Undo aborted actions in reverse order

## Extra Time
- Worksheet
