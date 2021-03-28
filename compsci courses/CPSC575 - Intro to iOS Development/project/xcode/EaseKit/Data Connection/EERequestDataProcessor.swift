//
//  EERequestDataProcessor.swift
//  EaseKit
//
//  Created by Douglas Yuen on 2017-10-19.
//  Copyright © 2017 exdee. All rights reserved.
//

import Foundation
import SwiftyJSON

/*  This class is responsible for holding the methods that convert data from a URL request
 */

public class EERequestDataProcessor
{
    //********************//
    // MARK: - INITIALISERS
    //********************//
    
    public init(){}
    
    //********************//
    // MARK: - INSTANCE METHODS
    //********************//
    
    // From the data passed in, create a JSON object.
    
    public func createJSONFromData(data:Data) -> JSON
    {
        return JSON(data)
    }
    
    public func createJSONArrayFromData(data:Data) -> [JSON]
    {
        return JSON(data).arrayValue
    }
}
