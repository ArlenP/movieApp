//
//  ConfigManager.swift
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//

import Foundation

struct ConfigManager {
    static var apiKey: String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["API_KEY"] as? String else {
            fatalError("API_KEY not found in Config.plist")
        }
        return key
    }
}
