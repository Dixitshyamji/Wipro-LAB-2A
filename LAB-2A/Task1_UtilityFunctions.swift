// ============================================================
// Task 1: Utility Functions
//   • calculateMean(of:)
//   • findMaximum(in:)
//   • isValidEmail(_:)
//   • formatDisplayName(firstName:lastName:)
// ============================================================

import Foundation

// MARK: - 1a. Calculate Mean
/// Returns the arithmetic mean of a non-empty array of Doubles.
/// - Parameter values: The collection of numeric values.
/// - Returns: The mean, or nil if the array is empty.
func calculateMean(of values: [Double]) -> Double? {
    guard !values.isEmpty else { return nil }
    let sum = values.reduce(0.0, +)
    return sum / Double(values.count)
}

// MARK: - 1b. Find Maximum
/// Returns the largest value in a non-empty array of Doubles.
/// - Parameter values: The collection of numeric values.
/// - Returns: The maximum value, or nil if the array is empty.
func findMaximum(in values: [Double]) -> Double? {
    return values.max()
}

// MARK: - 1c. Validate Email-like Input
/// Performs a basic structural validation of an email address.
/// Rules: contains exactly one '@', a non-empty local part,
///        a domain with at least one '.', and a non-empty extension.
/// - Parameter email: The raw string to validate.
/// - Returns: `true` if the string looks like a valid email.
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

// MARK: - 1d. Format Display Name
/// Builds a display-ready full name from a first name and last name.
/// Trims whitespace and capitalises each component.
/// - Parameters:
///   - firstName: The person's given name.
///   - lastName:  The person's family name.
/// - Returns: A formatted "First Last" string.
func formatDisplayName(firstName: String, lastName: String) -> String {
    let first = firstName.trimmingCharacters(in: .whitespaces).capitalized
    let last  = lastName.trimmingCharacters(in: .whitespaces).capitalized
    return "\(first) \(last)"
}

// MARK: - Demo
func runTask1() {
    print("========== TASK 1: Utility Functions ==========\n")

    // Mean
    let scores: [Double] = [85, 92, 78, 95, 88]
    if let mean = calculateMean(of: scores) {
        print(String(format: "Mean of %@ = %.2f", scores.map(String.init).joined(separator: ", "), mean))
    }
    print("Mean of [] = \(calculateMean(of: []) as Any)")   // nil

    // Maximum
    if let max = findMaximum(in: scores) {
        print("Maximum in scores = \(max)")
    }
    print("Maximum in [] = \(findMaximum(in: []) as Any)")  // nil

    // Email validation
    let emails = ["user@example.com", "bad@", "@no-local.com", "nodomain", "a@b.c"]
    print("\nEmail Validation:")
    emails.forEach { print("  \($0.padding(toLength: 20, withPad: " ", startingAt: 0)) → \(isValidEmail($0) ? "✅ valid" : "❌ invalid")") }

    // Display name
    print("\nDisplay Name:")
    print("  formatDisplayName(firstName: \" shyam\", lastName: \"dixit \") → \(formatDisplayName(firstName: " shyam", lastName: "dixit "))")
    print("  formatDisplayName(firstName: \"RAM JI\", lastName: \"DIXIT\")  → \(formatDisplayName(firstName: "RAM JI", lastName: "DIXIT"))")
}
