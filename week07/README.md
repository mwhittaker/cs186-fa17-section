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
- SMJ
    - Cost: `O([R]log_B([R])) + O([S]log_B([S])) + O([R] + |R|[S])` (worst case)
    - Cost: `O([R]log_B([R])) + O([S]log_B([S])) + O([R] + [S])` (likely case)
    - Data dependent: yes
    - Assumptions: equijoin
- SMJ with refinement
    - Cost: `2([R] + [S]) + ([R] + [S])`
    - Data dependent: yes
    - Assumptions:
        - equijoin,
        - more than `2 sqrt([L])` buffer pages where `L` is the relation with
          more pages,
        - join can be done as a stream
- Naive hash join
    - Cost: `[R] + [S]`
    - Data dependent: no
    - Assumptions:
        - equijoins,
        - `[X] < B - 2` where `X` is the relation with fewer pages
- Grace hash join
    - Cost: `2([R] + [S]) + complex` (worst case)
    - Cost: `2([R] + [S]) + ([R] + [S])` (likely case)
    - Data dependent: yes
    - Assumptions:
        - equijoins
        - All partitions fit in memory
        - more than `sqrt([X])` where `X` is the relation with fewer pages
- Hybrid hash join
    - Cost: `([R] + [S]) + (k-1/k)([R] + [S]) + complex` (worst case)
    - Cost: `([R] + [S]) + (k-1/k)([R] + [S]) + (k-1/k)([R] + [S])` (likely case)
    - Data dependent: yes
    - Assumptions:
        - equijoins
        - `B - (k + 1) >= [X]/k` for some `k` where `X` is the relation with
          fewer pages
