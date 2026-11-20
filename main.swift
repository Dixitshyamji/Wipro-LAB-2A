import Foundation

let studentName: String    = "Shyam Dixit"
let rollNumber:  Int       = 101
var marks: [String: Int]   = [
    "Mathematics" : 88,
    "Science"     : 76,
    "English"     : 92,
    "History"     : 65,
    "Computer"    : 95
]
var attendancePercentage: Double = 85.5    
let passingMark: Int             = 40      
let subjectMarks: [Int] = Array(marks.values)
let total:    Int    = subjectMarks.reduce(0, +)
let average:  Double = Double(total) / Double(subjectMarks.count)
let maxMarks: Int    = 100 * subjectMarks.count
let percentage: Double = (Double(total) / Double(maxMarks)) * 100.0
let isPassed: Bool = subjectMarks.allSatisfy { $0 >= passingMark }
let status: String = isPassed ? "PASS" : "FAIL"


let sum        = 88 + 76          
let diff       = 95 - 65          
let product    = 5 * 20           
let quotient   = 92 / 4           
let remainder  = 92 % 10       
print("── Arithmetic Operators ──────────────────────")
print("88 + 76 = \(sum),  95 - 65 = \(diff)")
print("5 × 20  = \(product),  92 / 4 = \(quotient),  92 %% 10 = \(remainder)")
print("\n── Comparison Operators ──────────────────────")
print("total > 300  : \(total > 300)")
print("average == 50: \(average == 50)")
print("passingMark <= average: \(Double(passingMark) <= average)")
let goodAttendance = attendancePercentage >= 75.0
let overallOK = isPassed && goodAttendance          
let needsSupport = !isPassed || !goodAttendance     
print("\n── Logical Operators ─────────────────────────")
print("isPassed && goodAttendance → \(overallOK)")
print("!isPassed || !goodAttendance → \(needsSupport)")
var tempScore = total
tempScore += 10  
tempScore -= 5    
tempScore *= 1    
print("\n── Compound-Assignment Operators ─────────────")
print("After += 10, -= 5 on total(\(total)): tempScore = \(tempScore)")

var optionalGrade: String? = nil
let displayGrade = optionalGrade ?? "Grade Not Assigned"
print("\n── Nil-Coalescing Operator ───────────────────")
print("optionalGrade ?? default → \"\(displayGrade)\"")

var grade: String

if percentage >= 90 {
    grade = "A+"
} else if percentage >= 80 {
    grade = "A"
} else if percentage >= 70 {
    grade = "B"
} else if percentage >= 60 {
    grade = "C"
} else if percentage >= 50 {
    grade = "D"
} else {
    grade = "F"
}

let remark: String
switch grade {
case "A+": remark = "Outstanding"
case "A":  remark = "Excellent"
case "B":  remark = "Good"
case "C":  remark = "Average"
case "D":  remark = "Below Average"
default:   remark = "Fail – Needs Improvement"
}

print("\n╔══════════════════════════════════════════╗")
print("║         STUDENT GRADE REPORT             ║")
print("╠══════════════════════════════════════════╣")
print(String(format: "║  Name        : %-26s║", studentName))
print(String(format: "║  Roll Number : %-26d║", rollNumber))
print("╠══════════════════════════════════════════╣")
for (subject, mark) in marks.sorted(by: { $0.key < $1.key }) {
    print(String(format: "║  %-12s: %3d / 100                   ║", subject, mark))
}
print("╠══════════════════════════════════════════╣")
print(String(format: "║  Total       : %3d / %d              ║", total, maxMarks))
print(String(format: "║  Average     : %6.2f                  ║", average))
print(String(format: "║  Percentage  : %6.2f%%                 ║", percentage))
print(String(format: "║  Attendance  : %6.2f%%                 ║", attendancePercentage))
print(String(format: "║  Grade       : %-26s║", grade))
print(String(format: "║  Remark      : %-26s║", remark))
print(String(format: "║  Status      : %-26s║", status))
print("╚══════════════════════════════════════════╝")

print("\n── Boundary Value Validation ─────────────────")

func validateMarks(_ m: Int, subject: String) {
    switch m {
    case 0:
        print("\(subject): \(m) → Zero marks (boundary lower)")
    case 1..<passingMark:
        print("\(subject): \(m) → Failing mark (below threshold \(passingMark))")
    case passingMark:
        print("\(subject): \(m) → Exactly passing (boundary)")
    case (passingMark + 1)...99:
        print("\(subject): \(m) → Valid passing mark")
    case 100:
        print("\(subject): \(m) → Perfect score (boundary upper)")
    default:
        print("\(subject): \(m) → ⚠️  INVALID mark (out of 0–100 range)")
    }
}

func validateAttendance(_ a: Double) {
    if a < 0 || a > 100 {
        print("Attendance: \(a)% → ⚠️  INVALID (must be 0–100)")
    } else if a < 75 {
        print("Attendance: \(a)% → Below required 75% threshold")
    } else {
        print("Attendance: \(a)% → Valid")
    }
}
validateMarks(0,   subject: "Math")        
validateMarks(39,  subject: "Science")     
validateMarks(40,  subject: "English")     
validateMarks(75,  subject: "History")     
validateMarks(100, subject: "Computer")    
validateMarks(-5,  subject: "Art")         
validateMarks(105, subject: "PE")          

validateAttendance(0.0)    
validateAttendance(74.9)   
validateAttendance(75.0)   
validateAttendance(100.0)  
validateAttendance(-1.0)   
validateAttendance(101.0)  
