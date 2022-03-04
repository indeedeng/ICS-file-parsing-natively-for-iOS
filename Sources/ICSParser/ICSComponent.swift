//
//  ICSComponent.swift
//  
//
//  Created by Sean Patno on 8/5/21.
//

import Foundation
import EventKit

public struct ICSProperty {
    public var propertyType: ICSPropertyType
    public var parameters: [ICSParameter: String] = [:]//should the string be some generic or super type as well?
    public var value: String//TODO: make this a generic? casting the string into what it should be
}

public class ICSComponent {
    public let componentType: ICSComponentType
    public var properties: [ICSProperty] = []
    public var subComponents: [ICSComponent] = []
    
    init(type: ICSComponentType) {
        self.componentType = type
    }
    
    @available(iOS 13.0, *)
    var ekObject: EKObject {
        
        switch componentType {
        case .alarm:
            break
        case .calendar:
            break
        case .event:
            break
        case .todo:
            break
        case .daylight:
            break
        case .freebusy:
            break
        case .journal:
            break
        case .timezone:
            break
        case .standard:
            break
        }
        
        return EKEvent()
    }
}
