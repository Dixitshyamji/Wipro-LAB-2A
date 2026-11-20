# LAB-2A: Functions and Higher-Order Functions
**Author:** Shyam Ji Dixit  
**Due:** Friday, 6 November  
**Language:** Swift 5.9+

---

## Objective

Decompose logic into reusable functions and demonstrate `map`, `filter`, `reduce`, and `sorted` on real data.

---

## Task 1 — Utility Functions

Four purpose-built functions with clear parameter labels and explicit return types:

| Function | Signature | Purpose |
|---|---|---|
| `calculateMean` | `(of values: [Double]) -> Double?` | Arithmetic mean; returns `nil` for empty input |
| `findMaximum` | `(in values: [Double]) -> Double?` | Largest element; `nil`-safe |
| `isValidEmail` | `(_ email: String) -> Bool` | Structural email validation (one `@`, valid domain) |
| `formatDisplayName` | `(firstName: String, lastName: String) -> String` | Trims + capitalises to "First Last" |

**Key design decisions:**
- Both `calculateMean` and `findMaximum` return `Optional<Double>` rather than crashing or returning `0` on empty input — callers handle the absence explicitly.
- `isValidEmail` splits on `@` with `maxSplits: 1` to handle edge cases like multiple `@` characters.

---

## Task 2 — Transaction Pipeline: filter → map → reduce

```swift
let total = transactions
    .filter  { $0.type == .expense }         // select expenses only
    .map     { formatted summary string }    // transform each to readable text
    .reduce(0.0) { $0 + $1.amount }          // aggregate into one total
```

**Observed output (sample data):**

| Description | Amount (₹) |
|---|---|
| Rent | 15,000 |
| Groceries | 3,200 |
| Electricity Bill | 1,200 |
| Internet Bill | 800 |
| Dining Out | 2,100 |
| **TOTAL EXPENSES** | **22,300** |

The pipeline is fully declarative — no mutable state, no indexing, no off-by-one errors.

---

## Task 3 — Sorting Students

```swift
students.sorted { lhs, rhs in
    if lhs.marks != rhs.marks { return lhs.marks > rhs.marks }
    return lhs.name < rhs.name
}
```

**Sorted Leaderboard (sample):**

| Rank | Name | Marks | Grade |
|---|---|---|---|
| 1 | Dev Patel | 95.0 | A+ |
| 2 | Priya Sharma | 91.5 | A |
| 3 | Sneha Gupta | 91.5 | A |
| 4 | Aisha Khan | 85.0 | B |
| 5 | Amit Verma | 85.0 | B |
| 6 | Kabir Singh | 76.0 | C |
| 7 | Rohit Mehra | 76.0 | C |
| 8 | Meera Nair | 68.5 | D |

**Tie-break observed:** Priya Sharma and Sneha Gupta both scored 91.5 → sorted alphabetically → Priya before Sneha. Same pattern for Kabir/Rohit at 76.0.

---

## Task 4 — Comparing Approaches: Loop vs Higher-Order Functions

Both `processScores_Loop` and `processScores_HOF` produce identical results: they filter scores ≥ 60, scale each by 1.1, and sum the result.

### Code volume

| Approach | Lines (core logic) |
|---|---|
| Loop-based | ~18 |
| HOF-based | 3 |

### Readability Trade-offs

| Dimension | Loop-based | HOF-based |
|---|---|---|
| Intent | HOW (explicit steps) | WHAT (declarative) |
| Mutability | Requires `var` accumulators | All `let`, immutable |
| Side-effect risk | Higher (mutable vars) | Lower |
| Debuggability | Easy to insert breakpoints | Need to split the chain |
| Performance | Single-pass possible | 3 passes (can be chained) |
| Parallelisability | Manual | Easier with async/concurrency |
| Learning curve | Familiar to beginners | Requires HOF fluency |

**Paragraph comparison:**

> The loop-based approach makes every computational step explicit: you see the `for` loop, the `if` condition, the `append`, and the accumulator update on separate lines. This verbosity helps beginners trace the data flow but adds noise for experienced Swift developers. The HOF pipeline (`filter → map → reduce`) reads like a sentence: *keep what passes, transform it, then sum it*. Because no mutable state is introduced, the risk of a stale accumulator or an incorrect index is eliminated entirely. The trade-off is debuggability: inserting a `print` inside a closure is awkward compared to a loop body. For straightforward collection transformations in Swift, the HOF style is idiomatic and preferred; loops remain useful when early-exit semantics (`break`), complex branching, or single-pass performance are required.

---

## Task 5 — Clear Parameter Labels and Return Types

Swift's argument label system separates *external call-site readability* from *internal parameter names*. Every function in this lab follows the rule: **the call site should read like a sentence**.

```swift
greet(user: "Ram Ji Dixit", as: "Student")
clamp(150, between: 0, and: 100)
letterGrade(for: 89.0)
wordCount(in: "Swift is awesome")
apply(to: [1,4,9], transform: sqrt)
percentageChange(from: 200, to: 250)
```

### Test Table

| Function | Input | Expected | Actual |
|---|---|---|---|
| `calculateMean(of:)` | `[85, 92, 78]` | 85.00 | 85.00 ✅ |
| `findMaximum(in:)` | `[3, 7, 2, 9, 4]` | 9.0 | 9.0 ✅ |
| `isValidEmail(_:)` | `"a@b.com"` | true | true ✅ |
| `isValidEmail(_:)` | `"bad@"` | false | false ✅ |
| `formatDisplayName(firstName:lastName:)` | `"ram"/"dixit"` | "Ram Dixit" | "Ram Dixit" ✅ |
| `clamp(_:between:and:)` | `150, 0, 100` | 100.0 | 100.0 ✅ |
| `letterGrade(for:)` | `89.0` | A | A ✅ |
| `wordCount(in:)` | `"Hi there"` | 2 | 2 ✅ |
| `percentageChange(from:to:)` | `200 → 250` | +25.0% | +25.0% ✅ |
| `percentageChange(from:to:)` | `0 → 100` | nil (guarded) | nil ✅ |

---

## Conclusion

This lab demonstrated:

1. **Decomposition** — breaking logic into small, focused, named functions improves testability and reuse.
2. **Higher-order functions** — `filter`, `map`, `reduce`, and `sorted` express intent concisely and eliminate mutable intermediate state.
3. **Parameter labels** — expressive labels (e.g., `between:and:`, `from:to:`) make call sites self-documenting without requiring comments.
4. **Optional returns** — returning `Optional` from `calculateMean` and `findMaximum` forces callers to handle the empty-input case safely, rather than silently returning a sentinel value like `0`.
