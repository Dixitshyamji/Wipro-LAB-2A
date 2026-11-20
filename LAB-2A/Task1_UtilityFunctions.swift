
import Foundation
func calculateMean(of values: [Double]) -> Double? {
    guard !values.isEmpty else { return nil }
    let sum = values.reduce(0.0, +)
    return sum / Double(values.count)
}

func findMaximum(in values: [Double]) -> Double? {
    return values.max()
}


func isValidEmail(_ email: String) -> Bool {
    let parts = email.split(separator: "@", maxSplits: 1, omittingEmptySubsequences: false)
    guard parts.count == 2 else { return false }
    let local  = parts[0]
    let domain = parts[1]
    guard !local.isEmpty else { return false }
    let domainParts = domain.split(separator: ".", omittingEmptySubsequences: false)
    guard domainParts.count >= 2,
          domainParts.allSatisfy({ !$0.isEmpty }) else { return false }
    return true
}


func formatDisplayName(firstName: String, lastName: String) -> String {
    let first = firstName.trimmingCharacters(in: .whitespaces).capitalized
    let last  = lastName.trimmingCharacters(in: .whitespaces).capitalized
    return "\(first) \(last)"
}

func runTask1() {
    print("========== TASK 1: Utility Functions ==========\n")

    let scores: [Double] = [85, 92, 78, 95, 88]
    if let mean = calculateMean(of: scores) {
        print(String(format: "Mean of %@ = %.2f", scores.map(String.init).joined(separator: ", "), mean))
    }
    print("Mean of [] = \(calculateMean(of: []) as Any)")   // nil

    if let max = findMaximum(in: scores) {
        print("Maximum in scores = \(max)")
    }
    print("Maximum in [] = \(findMaximum(in: []) as Any)")  // nil

    let emails = ["user@example.com", "bad@", "@no-local.com", "nodomain", "a@b.c"]
    print("\nEmail Validation:")
    emails.forEach { print("  \($0.padding(toLength: 20, withPad: " ", startingAt: 0)) → \(isValidEmail($0) ? "✅ valid" : "❌ invalid")") }

    print("\nDisplay Name:")
    print("  formatDisplayName(firstName: \" shyam\", lastName: \"dixit \") → \(formatDisplayName(firstName: " shyam", lastName: "dixit "))")
    print("  formatDisplayName(firstName: \"RAM JI\", lastName: \"DIXIT\")  → \(formatDisplayName(firstName: "RAM JI", lastName: "DIXIT"))")
}
