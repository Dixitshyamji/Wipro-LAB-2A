// ============================================================
// Task 4: Loop-based vs Higher-Order-Function solution
//         with readability trade-off explanation
// ============================================================

import Foundation

// Shared data: an array of test scores
let testScores: [Int] = [45, 82, 91, 37, 68, 55, 76, 90, 23, 88]
let passMark = 60

// ─────────────────────────────────────────────────────────────
// APPROACH A — Imperative / Loop-based
// ─────────────────────────────────────────────────────────────

/// Returns only passing scores, scaled by 1.1, summed — using explicit loops.
func processScores_Loop(scores: [Int], passMark: Int) -> (passing: [Int], scaled: [Double], total: Double) {
    var passing: [Int]    = []
    var scaled:  [Double] = []
    var total:   Double   = 0.0

    // Step 1: filter
    for score in scores {
        if score >= passMark {
            passing.append(score)
        }
    }

    // Step 2: map (scale by 10 %)
    for score in passing {
        scaled.append(Double(score) * 1.1)
    }

    // Step 3: reduce (sum)
    for s in scaled {
        total += s
    }

    return (passing, scaled, total)
}

// ─────────────────────────────────────────────────────────────
// APPROACH B — Functional / Higher-Order Functions
// ─────────────────────────────────────────────────────────────

/// Returns only passing scores, scaled by 1.1, summed — using HOFs.
func processScores_HOF(scores: [Int], passMark: Int) -> (passing: [Int], scaled: [Double], total: Double) {
    let passing = scores.filter { $0 >= passMark }
    let scaled  = passing.map   { Double($0) * 1.1 }
    let total   = scaled.reduce(0.0, +)
    return (passing, scaled, total)
}

// MARK: - Demo
func runTask4() {
    print("\n========== TASK 4: Loop vs Higher-Order Functions ==========\n")

    let loopResult = processScores_Loop(scores: testScores, passMark: passMark)
    let hofResult  = processScores_HOF (scores: testScores, passMark: passMark)

    print("Input scores : \(testScores)")
    print("Pass mark    : \(passMark)\n")

    func printResult(label: String, result: (passing: [Int], scaled: [Double], total: Double)) {
        print("[\(label)]")
        print("  Passing scores : \(result.passing)")
        print("  Scaled (×1.1)  : \(result.scaled.map { String(format: "%.1f", $0) })")
        print(String(format: "  Total          : %.2f\n", result.total))
    }

    printResult(label: "Loop-based", result: loopResult)
    printResult(label: "HOF-based ", result: hofResult)

    // Verify both approaches produce the same result
    let match = loopResult.passing == hofResult.passing
             && loopResult.scaled  == hofResult.scaled
             && loopResult.total   == hofResult.total
    print("Results match: \(match ? "✅ Yes" : "❌ No")\n")

    print("""
  ┌─────────────────────────────────────────────────────────────────────┐
  │            Readability Trade-off Comparison                         │
  ├──────────────────┬──────────────────────────┬───────────────────────┤
  │ Dimension        │ Loop-based               │ HOF-based             │
  ├──────────────────┼──────────────────────────┼───────────────────────┤
  │ Lines of code    │ ~18 lines                │ 3 lines               │
  │ Intent clarity   │ HOW (step-by-step)       │ WHAT (declarative)    │
  │ Mutability       │ Requires var accumulator │ All let, immutable    │
  │ Side-effect risk │ Higher (mutable vars)    │ Lower                 │
  │ Debug ease       │ Easy to add print/break  │ Need to split chain   │
  │ Performance      │ Single pass possible     │ 3 passes (can chain)  │
  │ Parallelisable   │ Manual effort            │ Easy with concurrency │
  │ Learning curve   │ Familiar to beginners    │ Requires HOF fluency  │
  └──────────────────┴──────────────────────────┴───────────────────────┘

  Conclusion:
  HOFs win on conciseness and declarative clarity for straightforward
  data transformations. Loops can be preferable when:
    • A single pass is critical for performance on very large data.
    • Complex branching logic makes closures hard to read.
    • Early-exit (break) semantics are needed.
  In Swift idiom, HOFs are strongly preferred for collection pipelines.
""")
}
