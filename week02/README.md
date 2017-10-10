# Week 2: SQL + Files

## Background
- Questions
- SQL Recap
    - Simple SELECT-FROM-WHERE queries
    - DISTINCT
    - ORDER BY
    - LIMIT
    - Aggregates
    - GROUP BY
    - Joins
        - inner
        - natural
        - left outer
        - right outer
        - full outer
    - LIKE
    - Set operators
        - UNION
        - INTERSECT
        - EXCEPT
        - IN
        - NOT IN
        - EXISTS
        - NOT EXISTS
        - > all
        - > any
    - Subqueries
        - Non-correlated
        - Correlated
    - Views
        - Inserting and deleting from views
    - Common table expressions

## NULLs
- NULLs
- Left outer join kitten brain teaser

## File Organization
- If you haven't noticed yet, databases are persistent. You can shut off your
  machine and come back and the data is still there.
- Persistent pair example.
- Database is the same as the pair except we're storing a table instead of a
  pair. The operations are to add, remove, and update tuples instead of just
  incrementing stuff.
- Take 1: Store a number and then a big fat long sequence of records
    - RecordId is a index
    - Problem: record crosses page border requires two page fetches
- Take 2: Don't store records across page boundaries
    - Problem: deletion forces us to move everything
- Take 3: Store a bitmap
    - Problem: we don't know how big the bitmap should be
- Take 4: Store a linked list of pages, each with its own bitmap
    - Problem: insertion requires a long walk
- Take 5: Store two linked lists of pages, each with its own bitmap
    - Problem: still slow
- Take 6: Store a linked list of directories
    - Problem: variable length records
- Take 7: directory in each page instead of bitmap
    - Good
- One last thing, storing records (pair of strings instead of pair of ints)
    - Delimiter
    - Directory at front of record

## Survey with feedback!
