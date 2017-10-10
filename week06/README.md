# Week 6: Relational Algebra

## Admin
- HW2 grades released; grading dispute form online
- Midterm graded; will be returned soon
- HW3 released today; due two weeks from today
- Fill out the survey if you want to give feedback

## Homework 3
- Brief walkthrough of the code
- `IntIterator.java` iterator example

## Relational Algebra
- Brief review
    - relation
    - select
    - project
    - rename
    - cross product
    - join
    - intersection
    - union
    - difference
- http://dbis-uibk.github.io/relax/calc.htm# and short demo
- Division with example:
    - R / S is the largest relation such that (R / S) join S is a subset of R.

    R
    a 1
    a 2
    a 3
    b 2
    b 3
    c 1

    S
    1
    2

    R / S
    a
- `(pi a R) - (pi a ((pi a R) join (S) - R))`
- `0f7501b579a3d728afe1a89e6341b273`
- Connection between SQL and relational algebra

    SELECT a, c
    FROM R, (SELECT b AS c FROM S) as T
    WHERE b > 0

## Joins
- Review SNLJ (Question 1)
- Review PNLJ
- Review BNLJ (Question 3)
