
import Foundation
func greet(user name: String, as role: String) -> String {
    return "Hello, \(name)! You are logged in as \(role)."
}

func clamp(_ value: Double, between minimum: Double, and maximum: Double) -> Double {
    return Swift.max(minimum, Swift.min(maximum, value))
}

func letterGrade(for mark: Double) -> String {
    switch mark {
    case 95...:        return "A+"
    case 85..<95:      return "A"
    case 75..<85:      return "B"
    case 65..<75:      return "C"
    case 50..<65:      return "D"
    default:           return "F"
    }
}

func wordCount(in sentence: String) -> Int {
    return sentence
        .split(separator: " ")
        .filter { !$0.isEmpty }
        .count
}
func apply<T, U>(to elements: [T], transform: (T) -> U) -> [U] {
    return elements.map(transform)
}
func percentageChange(from original: Double, to new: Double) -> Double? {
    guard original != 0 else { return nil }
    return ((new - original) / abs(original)) * 100
}
struct TestCase<Input, Output> {
    let label:    String
    let input:    Input
    let expected: Output
    let actual:   Output
}

func runTask5() {
    print("\n========== TASK 5: Clear Parameter Labels & Return Types ==========\n")
    print("greet(user:as:)")
    print("  \(greet(user: "Ram Ji Dixit", as: "Student"))")
    print("  \(greet(user: "Prof. Alice",  as: "Teacher"))\n")
    print("clamp(_:between:and:)")
    print("  clamp(150,  between: 0, and: 100) → \(clamp(150,  between: 0, and: 100))")
    print("  clamp(-10,  between: 0, and: 100) → \(clamp(-10,  between: 0, and: 100))")
    print("  clamp(55.5, between: 0, and: 100) → \(clamp(55.5, between: 0, and: 100))\n")
    print("letterGrade(for:)")
    let marks: [Double] = [97, 89, 80, 70, 55, 40]
    marks.forEach { print(String(format: "  letterGrade(for: %5.1f) → %s", $0, letterGrade(for: $0))) }
    print()
    print("wordCount(in:)")
    let sentences = ["Swift is awesome", "   Hello   world  ", "One"]
    sentences.forEach { print("  wordCount(in: \"\($0)\") → \(wordCount(in: $0))") }
    print()
    print("apply(to:transform:)")
    let numbers = [1, 4, 9, 16, 25]
    let roots   = apply(to: numbers) { sqrt(Double($0)) }
    print("  apply(to: \(numbers), transform: sqrt) → \(roots.map { String(format: "%.1f", $0) })\n")
    print("percentageChange(from:to:)")
    if let pct = percentageChange(from: 200, to: 250) {
        print(String(format: "  200 → 250 : %+.1f%%", pct))
    }
    if let pct = percentageChange(from: 500, to: 400) {
        print(String(format: "  500 → 400 : %+.1f%%", pct))
    }
    print("  0   → 100 : \(String(describing: percentageChange(from: 0, to: 100))) (nil — division by zero guarded)\n")

    print("""
  ┌─────────────────────────────────────────────────────────────────────────┐
  │                         Test Table (Task 5)                             │
  ├──────────────────────────────────┬──────────────┬──────────┬────────────┤
  │ Function                         │ Input        │ Expected │ Actual     │
  ├──────────────────────────────────┼──────────────┼──────────┼────────────┤
  │ calculateMean(of:)               │ [85,92,78]   │ 85.00    │ \(String(format: "%-10.2f", calculateMean(of: [85,92,78]) ?? 0)) │
  │ findMaximum(in:)                 │ [3,7,2,9,4]  │ 9.0      │ \(String(format: "%-10.1f", findMaximum(in: [3,7,2,9,4]) ?? 0)) │
  │ isValidEmail(_:)                 │ a@b.com      │ true     │ \(String(format: "%-10s", isValidEmail("a@b.com") ? "true" : "false"))│
  │ isValidEmail(_:)                 │ bad@         │ false    │ \(String(format: "%-10s", isValidEmail("bad@") ? "true" : "false"))│
  │ formatDisplayName(first:last:)   │ ram / dixit  │ Ram Dixit│ \(formatDisplayName(firstName: "ram", lastName: "dixit").padding(toLength: 10, withPad: " ", startingAt: 0)) │
  │ clamp(_:between:and:)            │ 150, 0, 100  │ 100.0    │ \(String(format: "%-10.1f", clamp(150, between: 0, and: 100))) │
  │ letterGrade(for:)                │ 89.0         │ A        │ \(letterGrade(for: 89).padding(toLength: 10, withPad: " ", startingAt: 0)) │
  │ wordCount(in:)                   │ "Hi there"   │ 2        │ \(String(format: "%-10d", wordCount(in: "Hi there"))) │
  │ percentageChange(from:to:)       │ 200 → 250    │ +25.0%   │ \(percentageChange(from: 200, to: 250).map { String(format: "%+.1f%%", $0) } ?? "nil")       │
  └──────────────────────────────────┴──────────────┴──────────┴────────────┘
""")
}
