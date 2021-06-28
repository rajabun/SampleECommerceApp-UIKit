//
//  HomeRequest.swift
//  SampleECommerceApp-UIKit
//
//  Created by Muhammad Rajab Priharsanto on 27/06/21.
//

import Foundation

enum APIError:Error
{
    case noDataAvailable
    case canNotProcessData
}

class HomeRequest
{
    var resourceURL: URL
    let getHome = "https://private-4639ce-ecommerce56.apiary-mock.com/home"
    
    init()
    {
        guard let resourceURL = URL(string: getHome)
        else
        {
            fatalError()
        }
        self.resourceURL = resourceURL
        print("init berhasil")
    }
}
