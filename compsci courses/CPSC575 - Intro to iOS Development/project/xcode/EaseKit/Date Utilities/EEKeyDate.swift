//
//  EEKeyDate.swift
//  EaseKit
//
//  Created by Douglas Yuen on 2018-05-22.
//  Copyright © 2018 exdee. All rights reserved.
//

import Foundation

public struct EEKeyDate
{
    public var programID:Int
    public var dateTypeID:Int
    public var connectID:Int
    public var keyDate:Date
    
    public init(theProgramID:Int, theDateTypeID:Int, theConnectID:Int, theDate:Date)
    {
        self.programID = theProgramID
        self.dateTypeID = theDateTypeID
        self.connectID = theConnectID
        self.keyDate = theDate
    }
}
