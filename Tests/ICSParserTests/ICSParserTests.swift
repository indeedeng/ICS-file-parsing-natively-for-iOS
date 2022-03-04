//
//  ICSParserTests.swift
//  Indeed
//
//  Created by Sean Patno on 8/5/21.
//  Copyright © 2021 Indeed Inc. All rights reserved.
//

import XCTest
@testable import ICSParser

final class ICSParserTests: XCTestCase {
    
    //Example event exported from iCal
    static let ics1: String = "BEGIN:VCALENDAR\r\nMETHOD:PUBLISH\r\nVERSION:2.0\r\nX-WR-CALNAME:Home\r\nPRODID:-//Apple Inc.//macOS 11.2//EN\r\nX-APPLE-CALENDAR-COLOR:#1D9BF6\r\nX-WR-TIMEZONE:America/Los_Angeles\r\nCALSCALE:GREGORIAN\r\nBEGIN:VTIMEZONE\r\nTZID:America/Los_Angeles\r\nBEGIN:DAYLIGHT\r\nTZOFFSETFROM:-0800\r\nRRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=2SU\r\nDTSTART:20070311T020000\r\nTZNAME:PDT\r\nTZOFFSETTO:-0700\r\nEND:DAYLIGHT\r\nBEGIN:STANDARD\r\nTZOFFSETFROM:-0700\r\nRRULE:FREQ=YEARLY;BYMONTH=11;BYDAY=1SU\r\nDTSTART:20071104T020000\r\nTZNAME:PST\r\nTZOFFSETTO:-0800\r\nEND:STANDARD\r\nEND:VTIMEZONE\r\nBEGIN:VEVENT\r\nCREATED:20210325T232907Z\r\nUID:FE4FF5E8-433B-4810-A2D2-C8508E339318\r\nDTEND;TZID=America/Los_Angeles:20210331T100000\r\nTRANSP:OPAQUE\r\nX-APPLE-TRAVEL-ADVISORY-BEHAVIOR:AUTOMATIC\r\nSUMMARY:New Event\r\nLAST-MODIFIED:20210325T232907Z\r\nDTSTAMP:20210325T232908Z\r\nDTSTART;TZID=America/Los_Angeles:20210331T090000\r\nSEQUENCE:1\r\nEND:VEVENT\r\nEND:VCALENDAR\r\n"
    
    //example from the iCalKit
    static let ics2: String = "BEGIN:VCALENDAR\r\nVERSION:2.0\r\nPRODID:-//hacksw/handcal//NONSGML v1.0//EN\r\nBEGIN:VEVENT\r\nUID:uid1@example.com\r\nDTSTAMP:19970714T170000Z\r\nORGANIZER;CN=John Doe:MAILTO:john.doe@example.com\r\nDTSTART:19970714T170000Z\r\nDTEND:19970715T035959Z\r\nBEGIN:VALARM\r\nTRIGGER:-PT1440M\r\nACTION:DISPLAY\r\nDESCRIPTION:Reminder\r\nEND:VALARM\r\nSUMMARY:Bastille Day Party\r\nEND:VEVENT\r\nBEGIN:VEVENT\r\nUID:uid2@example.com\r\nDTSTAMP:19980714T170000Z\r\nORGANIZER;CN=Jim Doe:MAILTO:jim.doe@example.com\r\nDTSTART:19980714T170000Z\r\nDTEND:19980715T035959Z\r\nSUMMARY:Something completely different\r\nEND:VEVENT\r\nEND:VCALENDAR\r\n"
    
    //example sent from indeed (most important obviously)
    static let ics3: String = "BEGIN:VCALENDAR\r\nPRODID:-//Indeed Inc//Indeed for Employers 1//EN\r\nVERSION:2.0\r\nCALSCALE:GREGORIAN\r\nMETHOD:REQUEST\r\nBEGIN:VEVENT\r\nDTSTAMP:20200721T205028Z\r\nDTSTART:20200721T223000Z\r\nDTEND:20200721T230000Z\r\nSUMMARY:Interview request for seanp\r\nUID:a178e78aec8bda64247163cb55d00fd187740bdb3352@indeed.com\r\nORGANIZER:mailto:chopchophealth9_42s@qa.indeed.tech\r\nATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=TRUE;CN=spatno+push@indeed.com:mailto:spatno+push@indeed.com\r\nDESCRIPTION:\r\nLAST-MODIFIED:20200721T205028Z\r\nLOCATION:zcfgdfagdf\r\nSEQUENCE:1\r\nTRANSP:OPAQUE\r\nSTATUS:CONFIRMED\r\nEND:VEVENT\r\nEND:VCALENDAR\r\n"
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let calendarComponents = ICSParser.load(string: ICSParserTests.ics3)
        
        print("\(calendarComponents)")
        
        XCTAssert(calendarComponents.count == 1)
    }
}
