import Foundation

// Returns true if the word is a palindrome
func checkIsPalindrome(_ word: String) -> Bool {
    // Initialize min and max, and convert word to array
    let chars = Array(word.lowercased())
    var min = 0
    var max = chars.count - 1
    // Move min and max towards center while comparing min and max indices
    while min < max {
        if chars[min] != chars[max] {
            // Return false because inconsistency was found
            return false
        }
        min += 1
        max -= 1
    }
    // Return true because not broken
    return true
}

// Reads a file into an array of lines
func fileToArray(_ filename: String) -> [String] {
    do {
        // Get file content and split into lines
        let content = try String(contentsOfFile: filename, encoding: .utf8)
        let lines = content.components(separatedBy: .newlines)
        return lines.filter { !$0.isEmpty }
    } catch {
        // Inform user about file read error
        print("\nError: File not found or could not be read.")
        return []
    }
}

// Returns 2D array: [palindromes, non-palindromes]
func checkFile(_ filename: String) -> [[String]] {
    // Get lines from file and initialize
    // palindrome/non palindrome containers
    let lines = fileToArray(filename)
    var palindromes: [String] = []
    var nonPalindromes: [String] = []
    
    // Add palindromes/non palindromes
    for line in lines {
        if checkIsPalindrome(line) {
            palindromes.append(line)
        } else {
            nonPalindromes.append(line)
        }
    }
    //Return all palindromes and non palindromes in 2d array
    return [palindromes, nonPalindromes]
}

// Calculates average length of words in an array
func averageLength(_ words: [String]) -> Double {
    // Return 0 if empty
    if words.isEmpty { return 0 }

    // Return total / count (average)
    var total = 0
    for word in words {
        total += word.count
    }
    return Double(total) / Double(words.count)
}

// Writes the palindrome and non-palindrome lists to a file
func writeToFile(_ filename: String, information: [[String]]) {
    // Initialize palindromes/non palindromes
    let palindromes = information[0]
    let nonPalindromes = information[1]
    
    // Add data to output in grid layout
    var output = "Palindromes (avg length: \(averageLength(palindromes))): "
    output += palindromes.joined(separator: ", ")
    output += "\nNon-Palindromes (avg length: \(averageLength(nonPalindromes))): "
    output += nonPalindromes.joined(separator: ", ")
    
    // Write output to file or print file write error
    do {
        try output.write(toFile: filename, atomically: true, encoding: .utf8)
    } catch {
        print("There was an error writing to file \(filename)")
    }
}

// File name vars
let inputFileName = "palindromes.txt"
let outputFileName = "output.txt"

// Let user know file is being read
print("Reading file \(inputFileName)...")

// Get information (palindromes/non palindromes)
let information = checkFile(inputFileName)
let palindromes = information[0]
let nonPalindromes = information[1]

// Tell user that file has been read successfully
print("File was read successfully, results:")

// Display data in 2d grid
print("\nPalindromes (avg length: \(averageLength(palindromes))): ", terminator: "")
print(palindromes.joined(separator: ", "))

print("\nNon-Palindromes (avg length: \(averageLength(nonPalindromes))): ", terminator: "")
print(nonPalindromes.joined(separator: ", "))

// Write to file
print("\nNow writing to file \(outputFileName)...")
writeToFile(outputFileName, information: information)
