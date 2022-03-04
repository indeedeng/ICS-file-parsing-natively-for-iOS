//
//  ICSParser.swift
//  Indeed
//
//  Created by Sean Patno on 8/5/21.
//  Copyright © 2021 Indeed Inc. All rights reserved.
//

import Foundation

//https://tools.ietf.org/html/rfc5545
public class ICSParser {
    /// Loads the content of a given string.
    ///
    /// - Parameter string: string to load
    /// - Returns: List of containted `Calendar`s
    public static func load(string: String) -> [ICSComponent] {
        let icsContent = string.components(separatedBy: .newlines)
        let parser = ICSParserUtility(icsContent)
        return parser.parse()
    }

    /// Loads the contents of a given URL. Be it from a local path or external resource.
    ///
    /// - Parameters:
    ///   - url: URL to load
    ///   - encoding: Encoding to use when reading data, defaults to UTF-8
    /// - Returns: List of contained `Calendar`s.
    /// - Throws: Error encountered during loading of URL or decoding of data.
    /// - Warning: This is a **synchronous** operation! Use `load(string:)` and fetch your data beforehand for async handling.
    public static func load(url: URL, encoding: String.Encoding = .utf8) throws -> [ICSComponent] {
        let data = try Data(contentsOf: url)
        guard let string = String(data: data, encoding: encoding) else { return [] }
        return load(string: string)
    }

    static let dateFormatter1: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
        return dateFormatter
    }()
    
    static let dateFormatter2: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss"
        return dateFormatter
    }()
}

internal class ICSParserUtility {
    let icsContent: [String]

    init(_ ics: [String]) {
        icsContent = ics
    }
    
    func parse() -> [ICSComponent] {
        
        var components: [ICSComponent] = []
        
        var currentComponent: ICSComponent?
        var parentComponent: ICSComponent?
        
        for line in icsContent {
            
            guard let colonIndex = line.firstIndex(of: ":") else { continue }
            
            var propertyKey = String(line[..<colonIndex])
            let propertyValue = String(line[line.index(after: colonIndex)...])
            
            var attributeString: String?
            
            if let semiIndex = propertyKey.firstIndex(of: ";") {
                let tempString = propertyKey
                propertyKey = String(tempString[..<semiIndex])
                attributeString = String(tempString[tempString.index(after: semiIndex)...])
            }
            
            guard let propertyType = ICSPropertyType(rawValue: propertyKey) else { continue }
            
            switch propertyType {
            case .beginComponent:
                guard let componentType = ICSComponentType(rawValue: propertyValue) else { continue }
                let newComponent = ICSComponent(type: componentType)
                
                if let current = currentComponent {
                    parentComponent = current
                    current.subComponents.append(newComponent)
                } else {
                    components.append(newComponent)
                }
                
                currentComponent = newComponent
            case .endComponent:
                currentComponent = parentComponent
                parentComponent = nil//TODO: this doesn't allow for more nesting? need proper recursion
            default:
                var property = ICSProperty(propertyType: propertyType, value: propertyValue)
                
                if let attrString = attributeString {
                    let attributes = attrString.components(separatedBy: ";")
                    for attribute in attributes {
                        
                        guard let equalIndex = attribute.firstIndex(of: "=") else { continue }//error?
                        let attributeKey = String(attribute[..<equalIndex])
                        let attributeValue = String(attribute[attribute.index(after: equalIndex)...])
                        
                        guard let parameterType = ICSParameter(rawValue: attributeKey) else { continue }//error? unsupported parameter?
                        
                        property.parameters[parameterType] = attributeValue
                    }
                }
                
                currentComponent?.properties.append(property)
            }
        }
        
        return components
    }

    /*func read() throws -> [iCalCalendar] {
        var completeCal = [iCalCalendar?]()

        // Such state, much wow
        var inCalendar = false
        var currentCalendar: iCalCalendar?
        var inEvent = false
        var currentEvent: iCalEvent?
        var inAlarm = false
        var currentAlarm: iCalAlarm?

        for (_, line) in icsContent.enumerated() {
            switch line {
            case "BEGIN:VCALENDAR":
                inCalendar = true
                currentCalendar = iCalCalendar(withComponents: nil)
                continue
            case "END:VCALENDAR":
                inCalendar = false
                completeCal.append(currentCalendar)
                currentCalendar = nil
                continue
            case "BEGIN:VEVENT":
                inEvent = true
                currentEvent = iCalEvent()
                continue
            case "END:VEVENT":
                inEvent = false
                currentCalendar?.append(component: currentEvent)
                currentEvent = nil
                continue
            case "BEGIN:VALARM":
                inAlarm = true
                currentAlarm = iCalAlarm()
                continue
            case "END:VALARM":
                inAlarm = false
                currentEvent?.append(component: currentAlarm)
                currentAlarm = nil
                continue
            default:
                break
            }

            guard let (key, value) = line.toKeyValuePair(splittingOn: ":") else {
                // print("(key, value) is nil") // DEBUG
                continue
            }

            if inCalendar && !inEvent {
                currentCalendar?.addAttribute(attr: key, value)
            }

            if inEvent && !inAlarm {
                currentEvent?.addAttribute(attr: key, value)
            }

            if inAlarm {
                currentAlarm?.addAttribute(attr: key, value)
            }
        }

        return completeCal.compactMap({ $0 })
    }*/
}

