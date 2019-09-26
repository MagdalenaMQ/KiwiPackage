//
//  Kiwi.swift
//  Oranges
//
//  Created by Magda on 26/09/2019.
//  Copyright © 2019 Magda. All rights reserved.
//

import Foundation
import UIKit
import Futura

public struct Kiwi {
    public static func makeKiwiColor(on view: UIView) {
        view.backgroundColor = .systemGreen
    }
    
    public static func getKiwiImageData(from urlString: String) -> Future<Data> {
        
        let url = URL(string: urlString)
        let promise: Promise<Data> = .init()
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                promise.break(with: error)
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                promise.break(with: ResponseError.wrongStatusCode)
            } else if let imageData = data {
                promise.fulfill(with: imageData)
            } else {
                promise.cancel()
            }
        }.resume()
        
        return promise.future
    }
}

enum ResponseError: Error {
    case wrongStatusCode
}
