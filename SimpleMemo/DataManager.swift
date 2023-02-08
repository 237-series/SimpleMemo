//
//  DataManager.swift
//  SimpleMemo
//
//  Created by sglee237 on 2023/02/08.
//

import Foundation


let dummyList:[MemoItem] = [
    MemoItem(title: "오늘은 신나는 날", contents: ""),
    MemoItem(title: "반가운 오늘", contents: "")
]

class DataManager:ObservableObject {
    static let DATA_LIST_KEY = "DATA_LIST_KEY"
    
    static let shared = DataManager()
    
    @Published var dataList:[MemoItem] = []
    
    init() {
        if let data = UserDefaults.standard.value(forKey: DataManager.DATA_LIST_KEY) as? Data {
            let dataListFrom = try? PropertyListDecoder().decode([MemoItem].self, from: data)
            if let list = dataListFrom {
                dataList = list
            }
        }
    }
    
    
    //func getList(Category acCate:AccountCategory) -> [AccountData] {
    func getList() -> [MemoItem] {
//        if dataList.isEmpty {
//            return dummyList
//        }
//        
        var returnList:[MemoItem] = dataList
        /*if acCate != .none {
            returnList = []
            for acData in acDataList {
                if acData.category == acCate {
                    returnList.append(acData)
                }
            }
        }*/
        return returnList
    }
    
    func dataSync() -> Bool {
        // Add Save List
        UserDefaults.standard.set(try? PropertyListEncoder().encode(dataList), forKey: DataManager.DATA_LIST_KEY)
        return UserDefaults.standard.synchronize()
    }
    
    //func add(AccountData acData:AccountData?) -> Bool {
    func add(MemoItem item:MemoItem?)-> Bool {
        // Add LocalList
        if let data = item {
            dataList.append(data)
            
            // Add Save List
            return dataSync()
        }
        
        return false
    }
    
    func save(MemoItem aItem:MemoItem?)-> Bool {
        if let data = aItem {
            for (idx, (item)) in dataList.enumerated() {
                if item.id.hashValue == data.id.hashValue {
                    dataList[idx] = data
                }
            }
            
        }
        
        return false
    }
    
    func remove(_ indexSet:IndexSet) -> Bool {
        dataList.remove(atOffsets: indexSet)
        return dataSync()
    }
    
    func move(from source:IndexSet, to destination:Int ) ->Bool {
        dataList.move(fromOffsets: source, toOffset: destination)
        return dataSync()
    }
}
