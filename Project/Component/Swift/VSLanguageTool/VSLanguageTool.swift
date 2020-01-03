//
//  VSLanguageTool.swift
//  Assureapt
//
//  Created by HET on 2019/12/31.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

class VSLanguageTool {

    static let instance = VSLanguageTool()
    private let appLanguage = "appLanguage"
    private var bundle: Bundle?
    public var languageCode: String?
    public var language: String?
    public var supportLanguages: [[String: String]]?
    
    public func getString(forKey: String) -> String {
        if bundle != nil {
            return NSLocalizedString(forKey, tableName: "Localizable", bundle: bundle!, comment: "")
        } else {
            return NSLocalizedString(forKey, tableName: "Localizable", comment: "")
        }
    }
    
    public func newLanguage(languageCode: String) {
        guard languageCode != self.languageCode else {
            DataStorage.standard.set(self.languageCode, forKey: appLanguage)//数据存储
            return
        }
        var code = languageCode
        if supportBy(languageCode: languageCode) == false {
            code = "en"
        }
        let path = Bundle.main.path(forResource: code, ofType: "lproj")
        self.bundle = Bundle.init(path: path!)
        self.languageCode = code
        DataStorage.standard.set(self.languageCode, forKey: appLanguage)//数据存储
    }
    
    private func codeCover(languageCode: String) -> String {
        if supportBy(languageCode: languageCode) {
            return languageCode
        }
        return "en"
    }
    
    private func supportBy(languageCode: String) -> Bool {
        for dic in supportLanguages! {
            if languageCode == dic["languageCode"] {
                return true
            }
        }
        return false
    }
    
    private init() {
        supportLanguages = [["language": "English", "languageCode": "en"],
                           ["language": "Deutsch", "languageCode": "de"],
                           ["language": "日本語", "languageCode": "ja"],
                           ["language": "French", "languageCode": "fr"],
                           ["language": "Italian", "languageCode": "it"],
                           ["language": "Spanish", "languageCode": "es"]]
        
        self.languageCode = DataStorage.standard.object(forKey: appLanguage) as? String
        if languageCode == nil {
            let deviceLanguageCode = NSLocale.preferredLanguages[0]
            self.languageCode = codeCover(languageCode: deviceLanguageCode)
        }
        newLanguage(languageCode: languageCode!)
    }
}
