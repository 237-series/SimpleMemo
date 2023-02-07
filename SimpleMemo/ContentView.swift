//
//  ContentView.swift
//  SimpleMemo
//
//  Created by sglee237 on 2023/02/06.
//

import SwiftUI

extension Date {
    func string() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: self)
    }
}

struct MemoItem: Identifiable {
    var id=UUID()
    var date=Date()
    var title:String
    var contents:String
}

let dummyList:[MemoItem] = [
    MemoItem(title: "오늘은 신나는 날", contents: ""),
    MemoItem(title: "반가운 오늘", contents: "")
]

let itemList:[String:[MemoItem]] = [
    "2023-01-23": dummyList ,
    "2023-02-01": dummyList
]

struct DetailView:View {
    var body: some View {
        Text("Hello, world!")
            .navigationTitle("디테일 화면")
    }
}

struct ListItem : View {
    @State var memo:MemoItem
    
    var body: some View {
        VStack( alignment: .leading) {
            Text(memo.title)
                .font(.title3)
            Text(memo.date.string())
                .foregroundColor(.gray)
        }
        
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(itemList.map{$0.key}, id:\.self) { headDate in
                    Section(headDate) {
                        ForEach(itemList[headDate]!) { item in
                            NavigationLink {
                                DetailView()
                            } label: {
                                ListItem(memo: item)
                            }
                        }
                    }
                }
//                Section("색션1") {
//                    ForEach(dummyList) { item in
//                        NavigationLink {
//                            DetailView()
//                        } label: {
//                            ListItem(memo: item)
//                        }
//                    }
//                }
                
//                Group {
//                    ForEach(0..<3) { num in
//                        NavigationLink {
//                            DetailView()
//                        } label: {
//                            ListItem()
//                        }
//                    }
//                }
//
//
            }
            .navigationTitle("Main view")
            .toolbar {
                ToolbarItemGroup {
                    Button("Add") {}
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                    

                }
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
