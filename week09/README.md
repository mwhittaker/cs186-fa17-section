# Week 9: Query Optimization and ER Diagrams

## Admin
- HW4 due one week from Thursday
- Midterm 2 is 2 weeks from today

## Query Optimization Overview
- A query optimizer takes in a relational algebra expression and outputs a
  query plan that implements the relational algebra expression. The query
  optimizer tries to output a query plan with as small of an IO cost as
  possible.
- A naive query optimization algorithm:
    - Step 1: consider all possible query plans
    - Step 2: compute the IO cost of every single query plan
    - Step 3: run the query plan of least cost
- Problem 1: there are a *lot* of query plans
    - e.g. 2 relations => 2 query plans
         /\   /\
        R  S S  R
    - e.g. 3 relations => 12 query plans
          /\    /\    /\    /\
         /\ T  /\ T  T /\  T /\
        R  S  S  R    R  S  S  R
          /\    /\    /\    /\
         /\ S  /\ S  S /\  S /\
        R  T  T  R    R  T  T  R
          /\    /\    /\    /\
         /\ R  /\ R  R /\  R /\
        S  T  T  S    S  T  c  S
    - e.g. 4 relations => 144 query plans
    - e.g. 5 relations => 1,920 query plans
    - e.g. 6 relations => 37,440 query plans
    - e.g. 10 relations => 23,862,988,800 query plans
    - For fun, write a program to compute the number.
- Problem 2: we don't know the exact cost of a query plan
    - We can sometimes compute the cost of a small query plan:
        BNLJ
         /\    [R] + ceil([R][S]/B-2)
        R  S

        BNLJ
         /\    [S] + ceil([R][S]/B-2)
        R  S
    - Sometimes we can't compute the cost of a small query plan:
         SMJ2   [R]ceil(1 + log_{B-1}(ceil([R]/B))) +
         /\     [S]ceil(1 + log_{B-1}(ceil([S]/B))) +
        R  S    ???
    - We can't compute the cost of a bigger query plan:
          /\
         /\ T  ([R] + ceil([R][S]/B-2)) + ([R join S] + ceil([R join S][T]/B-2))
        R  S

## Selectivity Estimation
- Solving problem 2: estimate the size of a join by estimating selectivities

    SELECT *
    FROM R, S
    WHERE R.a = 42

- |R join S| = |R||S| * selectivity(R.a = 42)
- Can compute [R join S] easily

| Predicate | Selectivity                       | Assumption      |
| --------- | --------------------------------- | --------------- |
| c = v     | 1 / NumVals(c)                    | Index on c      |
| c = v     | 1 / 10                            | No index        |
| c1 = c2   | 1 / max(NumVals(c1), NumVals(c2)) | Index on c1, c2 |
| c1 = c2   | 1 / max(NumVals(c1))              | Index on c1     |
| c1 = c2   | 1 / 10                            | No index        |
| c <= v    | (v - low + 1) / (high - low + 1)  | Index on c1     |
| c <= v    | 1 / 10                            | No index        |
| p1 AND p2 | S(p1) * S(p2)                     |                 |
| p1 OR p2  | S(p1) + S(p2) - S(p1)S(p2)        |                 |
| NOT p     | 1 - S(p1)                         |                 |

- Worksheet problem 1

## Sellinger Query Optimization
- Solving problem 1: don't enumerate all plans
    - Only consider left deep trees
          /\    /\
         /\ T  /\ T
        R  S  S  R
          /\    /\
         /\ S  /\ S
        R  T  T  R
          /\    /\
         /\ R  /\ R
        S  T  T  S
    - e.g. 2 relations => 2 left deep query plans
    - e.g. 3 relations => 6 left deep query plans
    - e.g. 4 relations => 24 left deep query plans
    - e.g. 10 relations => 3,628,800 left deep query plans
    - n relations => n! query plans
    - Left-deep trees allow fully pipelined plans
- Solving problem 1: don't enumerate all left deep query plans!
    - Say we know the cost of
         /\         /\
        R  S  and  S  R
    - Say the first costs less; then we only need to consider
          /\                /\
         /\ T              /\ T
        R  S    and not   S  R
    - We only need to know the least expensive join of R and S
    - Interesting orders. Say we know the BNLJ is cheaper

        SMJ(b)
         /\
        R  S

        BNLJ
         /\
        R  S
    - We still need to keep the SMJ around because
           SMJ
           /\
         SMJ T
         /\
        R  S
      might be cheaper than
           BNLJ
           / \
         BNLJ T
         /\
        R  S
- Sellinger query optimization algorithm
    - Maintain a table of the form

    | Relations | Interesting Order | Query Plan                        |
    | --------- | ----------------- | --------------------------------- |
    | R         | (a)               | I_a(R)                            |
    | S         | None              | FTS(R)                            |
    | S         | (b)               | I_b(S)                            |
    | T         | None              | FTS(T)                            |
    | R, S      | None              | BNLJ(FST(R), FTS(S))              |
    | R, T      | None              | BNLJ(FST(R), FTS(T))              |
    | S, T      | None              | BNLJ(FST(S), FTS(T))              |
    | R, S, T   | (a)               | SMJ(BNLJ(FST(S), FTS(T), I_a(R))) |

    - Pass 1: Compute the minimum cost access method for each (relation,
      interesting order) pair. Apply predicates as early as possible.
    - Explain pass 1 R
    - Worksheet question

    - Pass 2: For each (relation, interesting order) pair from pass 1, for
      every other relation, and for every join type, compute the join cost.
      Then, for each (relations, interesting order), retain the cheapest one.
    - Explain pass 2
    - Worksheet question

    - Without interesting orders, we end up considering `sum_{i=0}^{n-1} (n
      choose i)(n - i) = n*2^{n-1}` left deep query plans
