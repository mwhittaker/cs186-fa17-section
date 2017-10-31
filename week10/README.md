# Week 10: Functional Dependencies

## Admin
- HW4 due on Thursday
- Midterm 2 next Tuesday

## Functional Dependencies
- Recall what a function is.
    - Plot of f(x) = x [function]
    - Plot of f(x) = abs(x) [function]
    - Plot of f(x) = sideways abs [not a function]
    - You give me an x, I give you a unique y
* Given a relation R with attribute set A, a *functional dependency* f is a
  pair X, Y subsets of A written X -> Y. We say *R satisfies f* if the
  attributes Y are a function of the attributes X.
    - aka if two tuples have the same value of X attributes, then they have the
      same value of the Y attributes.
    - aka if you give me the X attributes, there's a unique set of Y
      attributes.
    - An example:
        {a, b} -> {c, d}
        | a | b | c | d |
        | 1 | 2 | 3 | 4 |
        | 1 | 2 | ? | ? |
- Question 2

## Inference and Closures
* Given a set F of *functional dependencies*, say F implies a functional
  dependency f, written F |= f, if every relation that satisfies all the
  functional dependencies in F also satisfies f.
- An example:
    {A -> B, B -> C} |= A -> C
    | a | b | c |
    | 1 | 2 | 3 |
    | 1 | ? | ? |
- To determine whether F |= X -> Y, we can think of starting with X and
  deriving Y using the functional dependencies in F. For example, given F = {A
  -> BC, B -> EF, C -> GH}, does F |= A -> EG? Yes.
- Exercise:
    - F |= B -> G?
    - F |= BC -> EG?
    - F |= AB -> EG?
    - F |= A -> A?

* The *closure* of a set F of functional dependencies, written F+, is the set
  of all functional dependencies f such that F |= f. That is, F+ = {f}{F |= f}.
- Exercise: Given attributes A, B, C and F = {A -> B, B -> A}, compute F+.
    - A -> A
    - A -> B
    - A -> AB
    - B -> B
    - B -> A
    - B -> AB
    - AB -> A
    - AB -> B
    - AB -> AB
    - C -> C
- Given a set F of functional dependencies and an attribute set X, the
  *attribute closure* of X (written X+) is the set of all attributes Y such
  that X -> Y is in F+.
- Example:
    - A+ = AB
    - B+ = AB
    - C+ = C
- Worksheet question 1.
- Worksheet question 3.
- A set of attributes X is a superkey if X+ is the set of all attributes. A
  candidate key is a minimal superkey.

## Armstrong's Axioms and Proof Systems
- Given a set of functional dependencies F and a functional dependency f, how
  do we know that F |= f? You'd have to write down a proof and check the
  validity of the proof. Checking such a proof is hard and can lead to
  mistakes.
- Instead, we'll introduce a *proof system* to help us reason about showing F
  |= f.
- Armstrong's Axioms
    1. Reflexivity. If X is a superset of Y, then X -> Y.
    2. Augmentation. If X -> Y, then XZ -> YZ.
    3. Transitivity. If X -> Y and Y -> Z, then X -> Z.
* Given a set of functional dependencies F, we say F proves a functional
  dependency f, written F |- f, if we can construct a proof of f using only F
  and Armstrong's Axioms.
- What's a proof?
- Example: if X -> Y and X -> Z, then X -> YZ

                    X -> Z
                    ------- aug
      X -> Y        X -> XZ
      ------- aug  --------- aug
      X -> XY      XY -> XYZ        YZ <= XYZ
      ---------------------- trans  --------- refl
            X -> XYZ                XYZ -> YZ
            --------------------------------- trans
                         X -> YZ

- Armstrong's axioms are
    - Sound: F |- f => F |= f
    - Complete: F |= f => F |- f
- Exercises
    - T/F Adding an axiom to Armstrong's axioms could break soundness? T
    - T/F Adding an axiom to Armstrong's axioms could break completeness? F
    - T/F Removing an axiom to Armstrong's axioms could break soundness? F
    - T/F Removing an axiom to Armstrong's axioms could break completeness? T

## Normal Forms
- A relation is in BCNF if for every non-trivial fd X -> Y (Y attribute) that R
  satisfies, X is a superkey.
- Lossless-join decomposition of R into X and Y if pi_X(R) join pi_Y(R) = R
- BCNF decomposition algorithm. If not in BCNF, choose FD X -> Y with X, Y
  disjoint. Divide into R - X and XY. Recurse.
- Normal form Q1.
- Dependency preserving. (F_X cup F_Y)+ = F+
- Normal form Q2.
