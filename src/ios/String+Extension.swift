//
//  String+Extension.swift
//  File Sample App
//
//  Created by Carlos Correa on 02/02/2021.
//

import Foundation

extension String {
    
    func isValidUrl() -> Bool {
        let regex = "((http|https|ftp)://)?((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
}
