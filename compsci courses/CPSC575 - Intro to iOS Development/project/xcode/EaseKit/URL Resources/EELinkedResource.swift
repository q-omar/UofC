//
//  EELinkedResource.swift
//  EaseKit
//
//  Created by Douglas Yuen on 2018-05-01.
//  Copyright © 2018 exdee. All rights reserved.
//

import Foundation

public struct EELinkedResource
{
    public var linkID:Int
    public var linkTitle:String
    public var linkDescription:String
    public var linkType:Int
    public var creationDate:Date?
    public var linkURL:URL
    
    public init(theID:Int, theURL:URL, theTitle:String, theDescription:String, theType:Int = -1, theCreation:Date?)
    {
        self.linkID = theID
        self.linkURL = theURL
        self.linkTitle = theTitle
        self.linkDescription = theDescription
        self.linkType = theType
        self.creationDate = theCreation
    }
}
