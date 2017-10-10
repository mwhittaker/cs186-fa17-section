# Week 4: B+ Trees + Buffer Manager

## Admin
- Show https://github.com/mwhittaker/cs186-fa17-section directory and remind
  people to fill out the feedback from from last week.

## B+ Trees
- Insert 10, 20, 30, 40, 50 into tree of order 1.

1. What is the maximum number of entries an order 1 tree of depth 2 can hold?
2. What is the maximum number of entries an order d tree of depth k can hold?
3. How many elements can we insert into this tree before we have to increase
   the depth?
4. What is the minimum number of entries an order 1 tree of depth 2 can hold?
5. What is the minimum number of entries an order d tree of depth k can hold?
6. What is the minimum number of elements we can insert into this tree to
   increase its depth?
7. Can you devise a sequence of insertions to get a depth 2 order-1 tree with 4
   elements?

1. Solution
    - level 0: 2d
    - level 1: (2d) * (2d + 1)
    - level 2: (2d) * (2d + 1)(2d + 1) = 2 * (3)(3) = 18
2. Solution
    - 2d * (2d+1)^k
3. Solution
    - Max 18 elements, we have 5 elements, so we can insert 13 more elements.
4. Solution
    - level 0: 1
    - level 1: d * 2
    - level 2: d * (2)(d+1) = 4
5. Solution
    - d * 2d^{k-1}
6. Solution
    - 4: 60, 70, 80, 90
7. Solution
    - No, it's impossible. At least one leaf will have d+1 entries.

- Additional topics
    - Bulk loading
    - Multiple columns in the key
    - Key compression
    - Alternative 1, 2, and 3
    - Clustered and unclustered indexes

## Buffer Manager
- Draw a picture of pages on disk and a small number of pages in memory.
- Show B+ tree pages being read into memory, modified, and written back to
  disk.
- Don't actually have to write it back to memory yet.
- What happens when we run out of pages in memory, we need to kick out a page
  in memory.
- Pin counts help prevent kicking something out that's being touched by someone
  else.
- Replacement policies help us choose which unpinned page to replace.
- LRU, MRU, clock
    - Exercise 2

## Extra Time
- Exercise 1

## Admin
- Week 4 survey
