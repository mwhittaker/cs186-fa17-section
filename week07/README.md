# Week 7: Joins and Parallel Query Evaluation

## Admin
- HW2 grade disputes due today
- Midterm regrade requests due tomorrow
- Class survey

## Joins
- Sort
    - Cost: `2[R](1 + ceil(log_{B-1}(ceil([R]/B))))`
    - Data dependent: no
    - Assumptions: none
- SNLJ
    - Cost: `[R] + |R|[S]`
    - Data dependent: no
    - Assumptions: none
- PNLJ
    - Cost: `[R] + [R][S]`
    - Data dependent: no
    - Assumptions: none
- BNLJ
    - Cost: `[R] + ceil([R]/B-2)[S]`
    - Data dependent: no
    - Assumptions: none

- INLJ
    - Cost: `[R] + \sum_{t \in R}(index cost + num matching pages)`
    - Data dependent: yes
    - Assumptions: index on S' join keys, equijoin or range join
    - Clustered vs unclustered
    - R(x, y) = {(0,0), (1,1), (4,4)}
    - S(x, y) = {(1,0), (1,1), (1,2), (3,0), (3,1), (3,2), (4,0), (4,1), (4,2), (4,3)}
    - No question for sake of time.

- SMJ
    - Cost: `O([R]log_B([R])) + O([S]log_B([S])) + O([R] + |R|[S])` (worst case)
    - Cost: `O([R]log_B([R])) + O([S]log_B([S])) + O([R] + [S])` (likely case)
    - Data dependent: yes
    - Assumptions: equijoin
    - R(x,y) = {(0,0), (10,10), (20,20), (20,20), (30,30)}
    - S(y,z) = {(5,0),(6,0),(10,0),(10,1),(15,0),(20,0),(20,1),(20,2),(20,3),(40,3)}
    - Worst case performance?
    - 10 buffer pages, R(x, y) is 100 pages, S(y, z) is 50 pages, y is a
      foreign key into S. What is the time for sort merge join?
      `2*100*(1 + ceil(log_9(10))) + 2*50*(1 + ceil(log_9(5))) + 100 + 50`

- Naive hash join
    - Cost: `[R] + [S]`
    - Data dependent: no
    - Assumptions:
        - equijoins,
        - `[X] < B - 2` where `X` is the relation with fewer pages
    - Carefully walk through the -2 thing
    - R(x, y) = {(1,1), (2,1), (3,3)}
    - S(y, z) = {(0,0), (0,1), (1,0), (1,1), (2,0), (2,1), (4,0), (4,1)}

- Grace hash join
    - Cost: `2([R] + [S]) + complex` (worst case)
    - Cost: `2([R] + [S]) + ([R] + [S])` (likely case)
    - Data dependent: yes
    - Assumptions:
        - equijoins
        - All partitions fit in memory
        - more than `sqrt([X])` where `X` is the relation with fewer pages
    - Recursive case; different hash function
    - R(x,y) = {(0,0), (1,1), (2,2), (3,2), (3,3), (4,4)}
    - S(y,z) = {(0,0), (0,1), (0,2), (2,0), (2,1), (4,0), (4,1), (5,0), (6,0)}
    - B = 5
    - Q1, Q2, Q3 (with 8 instead of 9)

## Extra Time
- Hybrid hash join
    - Cost: it's complicated
    - Data dependent: yes
    - B=12, [R] = 50, [S] = 100
    - Q4, Q5

- SMJ with refinement
    - Cost: `2([R] + [S]) + ([R] + [S])`
    - Data dependent: yes
    - Assumptions:
        - equijoin,
        - more than `2 sqrt([L])` buffer pages where `L` is the relation with
          more pages,
        - join can be done as a stream
    - R(x,y) = {(2,2), (5,5), (3,3), (1,1), (6,6), (4,4)}
    - S(x,y) = {(5,0), (2,0), (3,0), (0,0)}
