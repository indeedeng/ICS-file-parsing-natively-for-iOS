//
//  ICSEnums.swift
//  Indeed
//
//  Created by Sean Patno on 4/7/21.
//  Copyright © 2021 Indeed Inc. All rights reserved.
//

import Foundation
import EventKit

///https://tools.ietf.org/html/rfc5545#section-8.3.1
public enum ICSComponentType: String {
    case calendar = "VCALENDAR"
    case event = "VEVENT"
    case todo = "VTODO"
    case journal = "VJOURNAL"
    case freebusy = "VFREEBUSY"
    case timezone = "VTIMEZONE"
    case alarm = "VALARM"
    case standard = "STANDARD"
    case daylight = "DAYLIGHT"
}

///https://tools.ietf.org/html/rfc5545#section-8.3.2
public enum ICSPropertyType: String {
    
    case beginComponent = "BEGIN"
    case endComponent = "END"
    
    case calendarScale = "CALSCALE"///e.g. GREGORIAN, which is the default
    case method = "METHOD"
    case productIdentifier = "PRODID"
    case version = "VERSION"
    case attachment = "ATTACH"
    case categories = "CATEGORIES"
    case classification = "CLASS"
    case comment = "COMMENT"
    case description = "DESCRIPTION"
    case geographicPosition = "GEO"
    case location = "LOCATION"
    case percentComplete = "PERCENT-COMPLETE"//integer value 0-100
    case priority = "PRIORITY"//integer value 0-9, 0 is undefined, 1 is highest priority
    case resources = "RESOURCES"
    case status = "STATUS"
    case summary = "SUMMARY"
    case completed = "COMPLETED"
    case endTime = "DTEND"
    case dueTime = "DTDUE"
    case startTime = "DTSTART"
    case duration = "DURATION"
    case freeBusyTime = "FREEBUSY"
    case timeTransparency = "TRANSP"
    case timeZoneIdentifier = "TZID"
    case timeZoneName = "TZNAME"
    case timeZoneOffsetFrom = "TZOFFSETFROM"
    case timeZoneOffsetTo = "TZOFFSETTO"
    case timeZoneUrl = "TZURL"
    case attendee = "ATTENDEE"
    case contact = "CONTACT"
    case organizer = "ORGANIZER"
    case recurrenceID = "RECURRENCE-ID"
    case relatedTo = "RELATED-TO"
    case url = "URL"
    case uniqueIdentifier = "UID"
    case exceptionDateTimes = "EXDATE"
    case recurrenceDateTimes = "RDATE"
    case recurrenceRule = "RRULE"
    case alarmAction = "ACTION"
    case alarmRepeat = "REPEAT"
    case alarmTrigger = "TRIGGER"
    case created = "CREATED"
    case timestamp = "DTSTAMP"
    case lastModified = "LAST-MODIFIED"
    case sequence = "SEQUENCE"//integer, basICSly revision number
    case requestStatus = "REQUEST-STATUS"
    //TODO: X- types (user defined properties)
    
    //TODO: map of data types
}

///https://tools.ietf.org/html/rfc5545#section-3.8.1.11
public enum ICSStatus: String {
    
    //in all types
    case cancelled = "CANCELLED"
    
    //event statuses
    case tentative = "TENTATIVE"
    case confirmed = "CONFIRMED"
    
    //to-do status
    case needsAction = "NEEDS-ACTION"
    case completed = "COMPLETED"
    case inProgress = "IN-PROCESS"
    
    //journal statuses
    case draft = "DRAFT"
    case final = "FINAL"
    
    public var eventStatus: EKEventStatus {
        switch self {
        case .cancelled:
            return .canceled
        case .tentative:
            return .tentative
        case .confirmed:
            return .confirmed
        default:
            return .none
        }
    }
}

///https://tools.ietf.org/html/rfc5545#section-8.3.3
public enum ICSParameter: String {
    case alternativeTextRepresentation = "ALTREP"
    case commonName = "CN"
    case calendarUserType = "CUTYPE"
    case delegatedFrom = "DELEGATED-FROM"
    case delegatedTo = "DELEGATED-TO"
    case directory = "DIR"
    case inlineEncoding = "ENCODING"
    case formatType = "FMTTYPE"
    case freeBusyType = "FBTYPE"
    case language = "LANGUAGE"
    case membership = "MEMBER"
    case participationStatus = "PARTSTAT"
    case recurrenceRange = "RANGE"
    case alarmTriggerRelationship = "RELATED"
    case relationshipType = "RELTYPE"
    case participationRole = "ROLE"
    case rsvpExpectation = "RSVP"
    case sentBy = "SENT-BY"
    case timezoneIdentifier = "TZID"
    case value = "VALUE"
}

///https://tools.ietf.org/html/rfc5545#section-8.3.4
public enum ICSDataType: String {
    case binary = "BINARY"
    case boolean = "BOOLEAN"
    case calAddress = "CAL-ADDRESS"
    case date = "DATE"
    case dateTime = "DATE-TIME"
    case duration = "DURATION"
    case float = "FLOAT"
    case integer = "INTEGER"
    case period = "PERIOD"
    case recur = "RECUR"
    case text = "TEXT"
    case time = "TIME"
    case uri = "URI"
    case utcOffset = "UTC-OFFSET"
}

///https://tools.ietf.org/html/rfc5545#section-8.3.5
public enum ICSUserType: String {
    case individual = "INDIVIDUAL"
    case group = "GROUP"
    case resource = "RESOURCE"
    case room = "ROOM"
    case unknown = "UNKNOWN"
    
    public var ekParticipantType: EKParticipantType {
        switch self {
        case .individual:
            return .person
        case .group:
            return .group
        case .resource:
            return .resource
        case .room:
            return .room
        case .unknown:
            return .unknown
        }
    }
}

///https://tools.ietf.org/html/rfc5545#section-8.3.6
public enum ICSFreeBusyTimeType: String {
    case free = "FREE"
    case busy = "BUSY"
    case busyUnavailable = "BUSY-UNAVAILABLE"
    case busyTentative = "BUSY-TENTATIVE"
    
    public var ekAvailability: EKEventAvailability {
        switch self {
        case .free:
            return .free
        case .busy:
            return .busy
        case .busyUnavailable:
            return .unavailable
        case .busyTentative:
            return .tentative
        }
    }
}

///https://tools.ietf.org/html/rfc5545#section-8.3.7
public enum ICSParticipantStatus: String {
    
    case needsAction = "NEEDS-ACTION"
    case completed = "COMPLETED"
    case delegated = "DELEGATED"
    case accepted = "ACCEPTED"
    case declined = "DECLINED"
    case inProcess = "IN-PROCESS"
    case tentative = "TENTATIVE"
    
    public var partipantStatus: EKParticipantStatus {
        switch self {
        case .needsAction:
            return .pending//i assume this is the right one, it was the only other one besides unknown
        case .completed:
            return .completed
        case .delegated:
            return .delegated
        case .accepted:
            return .accepted
        case .declined:
            return .declined
        case .inProcess:
            return .inProcess
        case .tentative:
            return .tentative
        }
    }
}

///https://tools.ietf.org/html/rfc5545#section-8.3.8
public enum ICSRelationshipType: String {
    case child = "CHILD"
    case parent = "PARENT"
    case sibling = "SIBLING"
}

///https://tools.ietf.org/html/rfc5545#section-8.3.9
public enum ICSParticipantRole: String {
    case required = "REQ-PARTICIPANT"
    case optional = "OPT-PARTICIPANT"
    case nonParticipant = "NON-PARTICIPANT"
    case chair = "CHAIR"
    
    public var ekParticipantRole: EKParticipantRole {
        switch self {
        case .required:
            return .required
        case .optional:
            return .optional
        case .nonParticipant:
            return .nonParticipant
        case .chair:
            return .chair
        }
    }
}

///https://tools.ietf.org/html/rfc5545#section-8.3.10
public enum ICSAction: String {
    case audio = "AUDIO"
    case display = "DISPLAY"
    case email = "EMAIL"
    case procedure = "PROCEDURE"
}

///https://tools.ietf.org/html/rfc5545#section-8.3.11
public enum ICSClassification: String {
    case publicClass = "PUBLIC"
    case privateClass = "PRIVATE"
    case confidential = "CONFIDENTIAL"
}
