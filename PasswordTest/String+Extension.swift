//
//  String+Extension.swift
//  PasswordTest
//
//  Created by Alex Lundquist on 8/19/21.
//

import Foundation

extension String {
	
	func stringFulfillsRegex() -> Bool {
		let textTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*\\W)(?=.*[A-Z])(?=.*[0-9]).{6,}$")
		guard textTest.evaluate(with: self) else {
			return false
		}
		return true
	}
	var special: String {
		return "\(self.components(separatedBy: CharacterSet.alphanumerics).joined().count)"
	}
	var upper: String {
		return "\(self.components(separatedBy: CharacterSet.uppercaseLetters.inverted).joined().count)"
	}
	var lower: String {
		return "\(self.components(separatedBy: CharacterSet.lowercaseLetters.inverted).joined().count)"
	}
	var numbers: String {
		return "\(filter { "0"..."9" ~= $0 }.count)"
	}
	var missing: String {
		let special = (Int(self.special) ?? 0)
		let upper = (Int(self.upper) ?? 0)
		let lower = (Int(self.lower) ?? 0)
		let numbers = (Int(self.numbers) ?? 0)
		var returnSpecial: String {
			if special == 0 {
				return " 1 special,"
			}
			return ""
		}
		var returnUpper: String {
			if upper == 0 {
				return " 1 uppercase,"
			}
			return ""
		}
		var returnLower: String {
			if lower == 0 {
				return " 1 lowercase,"
			}
			return ""
		}
		var returnNumbers: String {
			if numbers == 0 {
				return " 1 number"
			}
			return ""
		}
		return "Missing" + returnSpecial + returnUpper + returnLower + returnNumbers
	}
}
