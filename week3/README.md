# Week 3: Files + B+ Trees

## Admin
- Show https://github.com/mwhittaker/cs186-fa17-section directory and remind
  people to fill out the feedback from from last week.

## Files Recap
- Organizing pages in a file: linked list vs directory
- Organizing records in a page: bitmap vs slotted page
- Organized columns in a record: fixed length vs variable length
- Complete File Organization Question 2 on worksheet.

Given a file with `B` pages, how many IOs do the following operations take in
expectation? Assume

    - a range search reads `R` pages
    - equality search keys are drawn uniformly at random from the file, and
    - a sorted file is condensed after a deletion.

|                  | Heap File  | Sorted File          |
| ---------------- | ---------- | -------------------- |
| scan             | `B`        | `B`                  |
| equality search  | `0.5B`     | `log_2(B)`           |
| range search     | `B`        | `log_2(B) + R`       |
| insert           | `2`        | `log_2(B) + 2 * B/2` |
| delete           | `0.5B + 1` | `log_2(B) + 2 * B/2` |

## Homework 2
- Show homework on GitHub.
- Open the homework in a terminal; show directory structure.
- `mvn clean compile` and `mvn clean test`.
- Launch Eclipse.
    - File > Import > Existing Maven Projects > Browse
    - Ctrl-s to save.
    - Ctrl-b to build.
    - Right click > Run As > JUnit Test
    - WE WILL BUILD WITH MAVEN
- Walk through `common`, then `databox`, `table, and then `io` with example.
    - Write `Writer.java`.
    - Run `Writer.java`.
    - hexdump file.
    - Write `Reader.java`.
    - Run `Reader.java`.

## B+ Trees
- A B+ tree is self-balancing tree that maps keys to values.
- Kind of like a binary search tree but every node has more than two children.
- Inner nodes store keys.
- Leaves store keys and values.
- Leaves have sibling pointers.
- Order of the tree

                                (30)
             (10 20)                           (40 50)
    (1 2 3) (10 11 12) (20 21 22) (30 31 32) (40 41 42) (50 51 52)

- Search example
- Insert 4, insert 5, keep inserting
- Remove example
- In databases, the keys will be the entries of a column and the values will be
  the record ids of the corresponding records. This allows us to find records
  faster.

    | x  | y  |
    | -- | -- |
    | 30 | 30 | (0, 0)
    | 20 | 20 | (0, 1)
    | 10 | 10 | (1, 0)
    | 40 | 40 | (1, 1)

    Page 0              Page 1
    +-------------------+-------------------+
    | 30 | 30 | 20 | 20 | 10 | 10 | 40 | 40 |
    +-------------------+-------------------+

                      (30)
    (10:(1,0), 20:(0,1)) (30:(0,0), 40:(1,1))

## Homework 2
- Walk through `index` directory.
    - `BPlusTree`
    - `BPlusNode`
    - `InnerNode`
    - `LeafNode`
    - Walk through action items for them

## Admin
- Week 3 survey
