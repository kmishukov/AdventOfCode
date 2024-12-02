// reservoir.swift
// Mishukov Konstantin 2022

import Cocoa
import Foundation

func main() {
  readInput()
}

func readInput() {
    // get URL to the the documents directory in the sandbox
    let home = FileManager.default.homeDirectoryForCurrentUser

    // add a filename
    let fileUrl = home
        .appendingPathComponent("input")

    // make sure the file exists
    guard FileManager.default.fileExists(atPath: fileUrl.path) else {
        preconditionFailure("file expected at \(fileUrl.absoluteString) is missing")
    }

    // open the file for reading
    // note: user should be prompted the first time to allow reading from this location
    guard let filePointer:UnsafeMutablePointer<FILE> = fopen(fileUrl.path,"r") else {
        preconditionFailure("Could not open file at \(fileUrl.absoluteString)")
    }

    // a pointer to a null-terminated, UTF-8 encoded sequence of bytes
    var lineByteArrayPointer: UnsafeMutablePointer<CChar>? = nil

    // see the official Swift documentation for more information on the `defer` statement
    // https://docs.swift.org/swift-book/ReferenceManual/Statements.html#grammar_defer-statement
    defer {
        // remember to close the file when done
        fclose(filePointer)

        // The buffer should be freed by even if getline() failed.
        lineByteArrayPointer?.deallocate()
    }

    // the smallest multiple of 16 that will fit the byte array for this line
    var lineCap: Int = 0

    // initial iteration
    var bytesRead = getline(&lineByteArrayPointer, &lineCap, filePointer)


    while (bytesRead > 0) {
        // note: this translates the sequence of bytes to a string using UTF-8 interpretation
        let lineAsString = String.init(cString:lineByteArrayPointer!)

        // do whatever you need to do with this single line of text
        // for debugging, can print it
        //if let line = lineAsString {
          proceedLine(line: lineAsString)
        //}

        // updates number of bytes read, for the next iteration
        bytesRead = getline(&lineByteArrayPointer, &lineCap, filePointer)
    }
}

private func proceedLine(line: String) {
  guard !line.isEmpty else { return }
    print(line)
}

main()
