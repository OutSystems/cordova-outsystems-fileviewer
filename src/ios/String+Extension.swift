//
//  String+Extension.swift
//  File Sample App
//
//  Created by Carlos Correa on 02/02/2021.
//

import Foundation

extension String {
    
    func isValidUrl() -> Bool {
        let regex = "http[s]?://(([^/:.[:space:]]+(.[^/:.[:space:]]+)*)|([0-9](.[0-9]{3})))(:[0-9]+)?((/[^?#[:space:]]+)([^#[:space:]]+)?(#.+)?)?"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
}
