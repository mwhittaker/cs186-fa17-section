# Week 8: Joins and Parallel Query Evaluation

## Admin
- HW3 was due today before lecture
- HW4 (query optimization) comes out soon
- Midterm 2 is 3 weeks away

## Basics
- Shared {memory, disk, nothing}
- Inter-query vs intra-query parallelism
- Inter-operator (pipeline) vs intra-operator (partition) parallelism

## Partitioning
- Draw three pictures, one for each type of partitioning
- For each operation, indicate whether we have to contact one node, multiple
  nodes, or all nodes (in the expected case)

|                        | Range on R.x | Hash on R.x | Round-Robin |
| ---------------------- | ------------ | ----------- | ----------- |
| SELECT * FROM R        | all          | all         | all         |
| WHERE R.x < 10         | some         | all         | all         |
| R.x = 10               | one          | one         | all         |
| Insert; no primary key | one          | one         | one         |
| Insert; x primary key  | one          | one         | all         |
| Insert; y primary key  | all          | all         | all         |

## Parallel Hash Join and Sort Merge Join
- Reds(suit, num)
- Blacks(suit, num)
- SELECT * FROM Reds R, Black B WHERE R.num = B.num

- Single person hash join (4 buckets)
- Distributed hash join (2 sources, 2 destinations, 4 buckets)
- Single person sort (4-way merge)
- Distributed sort (4 sources, 4 destinations, 4-way merge)

## Query Optimization
- High-level overview: SQL -> RA -> Plan

    SELECT R.a, T.d
    FROM R, S, T
    WHERE R.b = S.b AND S.c = T.c AND R.a = 10

- Motivation for optimizations
    - Pushing selects: SELECT * FROM R, S WHERE R.a = 42
        - R and S huge, but R.a = 42 empty
    - Pushing projects: SELECT R.a FROM R ORDER BY R.a
        - R has a lot of columns
    - Join order: SELECT * FROM R, S, T WHERE R.b = S.b AND S.c = T.c
        - (R join S) join T == 5*5 + 5*5*5
        - R join (S join T) == 5*5
        - Worse if R and S are huge and T is small

        R
        1 1
        2 1
        3 1
        4 1
        5 1

        S
        1 1
        1 2
        1 3
        1 4
        1 5

        T
        0 0
        0 0
        0 0
        0 0
        0 0
    - Join algorithm: pretty obvious
