// ============================================================
// Task 3: Sort students by marks (descending), then by name (ascending) for ties
// ============================================================

import Foundation

// MARK: - Data Model
struct Student {
    let name:  String
    let marks: Double
    let grade: String
}

// MARK: - Sample Data
let students: [Student] = [
    Student(name: "Priya Sharma",   marks: 91.5, grade: "A"),
    Student(name: "Amit Verma",     marks: 85.0, grade: "B"),
    Student(name: "Sneha Gupta",    marks: 91.5, grade: "A"),
    Student(name: "Rohit Mehra",    marks: 76.0, grade: "C"),
    Student(name: "Aisha Khan",     marks: 85.0, grade: "B"),
    Student(name: "Dev Patel",      marks: 95.0, grade: "A+"),
    Student(name: "Meera Nair",     marks: 68.5, grade: "D"),
    Student(name: "Kabir Singh",    marks: 76.0, grade: "C"),
]

// MARK: - Sorting Function
/// Sorts students by marks descending; breaks ties alphabetically by name ascending.
/// - Parameter students: The unsorted array of Student records.
/// - Returns: A new array sorted by (marks DESC, name ASC).
func sortStudents(_ students: [Student]) -> [Student] {
    return students.sorted { lhs, rhs in
        if lhs.marks != rhs.marks {
            return lhs.marks > rhs.marks    // primary: higher marks first
        }
        return lhs.name < rhs.name          // secondary: alphabetical name
    }
}

// MARK: - Display Helper
func printLeaderboard(_ students: [Student]) {
    let header = String(format: "%-4s %-22s %6s  %s", "Rank", "Name", "Marks", "Grade")
    let divider = String(repeating: "─", count: 44)
    print(divider)
    print(header)
    print(divider)
    for (index, student) in students.enumerated() {
        print(String(format: "%-4d %-22s %6.1f  %s",
                     index + 1,
                     student.name,
                     student.marks,
                     student.grade))
    }
    print(divider)
}

// MARK: - Demo
func runTask3() {
    print("\n========== TASK 3: Sorted Student Leaderboard ==========\n")

    print("Original order:")
    printLeaderboard(students)

    let sorted = sortStudents(students)
    print("\nSorted (marks ↓, name ↑ for ties):")
    printLeaderboard(sorted)

    print("""

  Sort key: lhs.marks > rhs.marks  // primary  — descending marks
             lhs.name  < rhs.name  // secondary — ascending name (tie-break)
  Priya Sharma and Sneha Gupta both scored 91.5 → Priya comes first (P < S alphabetically).
  Rohit Mehra and Kabir Singh both scored 76.0 → Kabir comes first (K < R alphabetically).
""")
}
