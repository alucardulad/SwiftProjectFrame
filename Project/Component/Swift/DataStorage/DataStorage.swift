//
//  DataStorage.swift
//  Assureapt
//
//  Created by HET on 2019/12/31.
//  Copyright © 2019 Etekcity. All rights reserved.
//

import UIKit

class DataStorage {
    
    static let standard = DataStorage()
    private var dataDic: NSMutableDictionary?
    private var path: String?
    
    open func set(_ object: Any?, forKey defaultName: String) {
        dataDic?.setValue(object, forKey: defaultName)
        writeToFile()
    }
    
    open func object(forKey key: String) -> Any? {
        return dataDic?.value(forKey: key)
    }
    
    open func removeObject(forKey defaultName: String) {
        dataDic?.removeObject(forKey: defaultName)
        writeToFile()
    }
    
    private func readToFile() {
        let fileExist = FileManager.default.fileExists(atPath: path!)
        self.dataDic = fileExist ? NSMutableDictionary.init(contentsOfFile: path!) : NSMutableDictionary()
    }
    
    private func writeToFile() {
        objc_sync_enter(dataDic!)
        self.dataDic?.write(toFile: path!, atomically: true)
        objc_sync_exit(dataDic!)
    }
    
    private func valueForPath() {
        let home = NSHomeDirectory() as NSString
        let docPath = home.appendingPathComponent("Documents") as NSString
        let filePath = docPath.appendingPathComponent("DataStorage.plist")
        print(filePath)
        path = filePath
    }
    
    private init() {
        valueForPath()
        readToFile()
    }
}
