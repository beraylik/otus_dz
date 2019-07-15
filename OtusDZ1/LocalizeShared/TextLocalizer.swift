//
//  TextLocalizer.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 15/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

struct TextLocalizer {
    
    // MARK: - Properties
    
    let localeCode: Locale
    
    private let dateRegex = #"(?:(?:(?:0?[13578]|1[02])(\/|-|\.)31)\1|(?:(?:0?[1,3-9]|1[0-2])(\/|-|\.)(?:29|30)\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|(?:0?2(\/|-|\.)29\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|(?:(?:0?[1-9])|(?:1[0-2]))(\/|-|\.)(?:0?[1-9]|1\d|2[0-8])\4(?:(?:1[6-9]|[2-9]\d)?\d{2})"#
    
    // Unit regex
    private let masureRegexLenght = #"(\d+)(?:,|.(\d+))?(\s*)(mm|sm|kM|m|in|ft|yd|mi)\b"#
    private let masureRegexVolume = #"(\d+)(?:,|.(\d+))?(\s*)(cup|pt|qt|gal|mL|L)\b"#
    private let masureRegexMass = #"(\d+)(?:,|.(\d+))?(\s*)(mg|g|kg|oz|lb|L)\b"#
    private let masureRegexTemp = #"(\d+)(?:,|.(\d+))?(\s*)(K|°C|°F|)\b"#
    
    // MARK: - Initialization
    
    init(localeCode: String) {
        self.localeCode = Locale(identifier: localeCode)
    }
    
    // MARK: - Interactions
    
    func localizeText(_ text: String) -> String {
        var resultText = text
        
        let dates = findMatches(in: text, with: dateRegex)
        for dateString in dates {
            let stringArray = dateString.components(separatedBy: CharacterSet.decimalDigits.inverted)
            guard stringArray.count == 3 else { continue }
            var components = DateComponents()
            components.month = Int(stringArray[0])
            components.day = Int(stringArray[1])
            components.year = Int(stringArray[2])
            guard let date = Calendar.current.date(from: components) else { continue }
            let localized = localizeDate(date)
            resultText = resultText.replacingOccurrences(of: dateString, with: localized)
        }
        
        // Length
        let lenghts = findMatches(in: text, with: masureRegexLenght)
        for item in lenghts {
            let parts: [String] = item.split(separator: " ").map { String($0) }
            guard parts.count == 2 else { continue }
            print(parts)
            guard let value: Double = Double(parts[0]) else { continue }
            let measure = Measurement(value: value, unit: unitForSymbol(parts[1]))
            let localized = localizeUnit(measure)
            resultText = resultText.replacingOccurrences(of: item, with: localized)
        }
        
        print(resultText)
        return resultText
    }
    
    // MARK: - Helpers
    
    private func unitForSymbol(_ symbol: String) -> Unit {
        switch symbol {
        case "mm": return UnitLength.millimeters
        case "m": return UnitLength.meters
        case "sm": return UnitLength.centimeters
        case "kM": return UnitLength.kilometers
        case "in": return UnitLength.inches
        case "ft": return UnitLength.feet
        case "yd": return UnitLength.yards
        case "mi": return UnitLength.miles
        default:
            return Unit(symbol: symbol)
        }
    }
    
    private func localizeDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = localeCode
        formatter.setLocalizedDateFormatFromTemplate("dMMMMyEEEE")
        return formatter.string(from: date)
    }
    
    private func localizeUnit<T: Unit>(_ measurment: Measurement<T>) -> String {
        let formatter = MeasurementFormatter()
        formatter.locale = localeCode
        return formatter.string(from: measurment)
    }
    
    private func findMatches(in text: String, with pattern: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            let matchesStr: [String] = matches.map { match in
                return String(text[Range(match.range, in: text)!])
            }
            return matchesStr
        } catch let error {
            print(error)
        }
        return []
    }
    
}
