// ============================================================
// Task 2: Transactions — filter, map, reduce
// ============================================================

import Foundation

// MARK: - Data Model
enum TransactionType: String {
    case income  = "Income"
    case expense = "Expense"
}

struct Transaction {
    let id:          Int
    let description: String
    let amount:      Double          // positive value
    let type:        TransactionType
}

// MARK: - Sample Data
let transactions: [Transaction] = [
    Transaction(id: 1, description: "Salary",           amount: 50000, type: .income),
    Transaction(id: 2, description: "Rent",             amount: 15000, type: .expense),
    Transaction(id: 3, description: "Groceries",        amount: 3200,  type: .expense),
    Transaction(id: 4, description: "Freelance Income", amount: 8000,  type: .income),
    Transaction(id: 5, description: "Electricity Bill", amount: 1200,  type: .expense),
    Transaction(id: 6, description: "Internet Bill",    amount: 800,   type: .expense),
    Transaction(id: 7, description: "Dividends",        amount: 2500,  type: .income),
    Transaction(id: 8, description: "Dining Out",       amount: 2100,  type: .expense),
]

// MARK: - Higher-Order Pipeline

/// Step 1 — filter: keep only expense transactions
func filterExpenses(from transactions: [Transaction]) -> [Transaction] {
    return transactions.filter { $0.type == .expense }
}

/// Step 2 — map: transform each expense into a human-readable summary string
func mapToSummary(transactions: [Transaction]) -> [String] {
    return transactions.map { t in
        String(format: "%-20s ₹%8.2f", (t.description as NSString).utf8String!, t.amount)
    }
}

/// Step 3 — reduce: sum all expense amounts to get the total outflow
func reduceToTotal(transactions: [Transaction]) -> Double {
    return transactions.reduce(0.0) { accumulator, transaction in
        accumulator + transaction.amount
    }
}

// MARK: - Demo
func runTask2() {
    print("\n========== TASK 2: filter → map → reduce ==========\n")

    let expenses      = filterExpenses(from: transactions)
    let summaryLines  = mapToSummary(transactions: expenses)
    let totalExpense  = reduceToTotal(transactions: expenses)

    print("Expense Transactions:")
    print(String(repeating: "-", count: 36))
    summaryLines.forEach { print("  \($0)") }
    print(String(repeating: "-", count: 36))
    print(String(format: "  %-20s ₹%8.2f", "TOTAL EXPENSES", totalExpense))

    // Bonus: total income for comparison
    let totalIncome = transactions
        .filter  { $0.type == .income }
        .map     { $0.amount }
        .reduce(0, +)

    print(String(format: "\n  Net Balance (Income − Expenses): ₹%.2f", totalIncome - totalExpense))

    print("""

  Pipeline used:
    transactions
      .filter  { $0.type == .expense }   // select
      .map     { formatted summary }     // transform
      .reduce(0) { $0 + $1.amount }      // aggregate
""")
}
