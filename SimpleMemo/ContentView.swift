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


struct DetailView:View {
    @State var contents:String = ""
    var body: some View {

        VStack(alignment: .leading){
            TextField("메모 내용을 입력하세요", text: $contents, axis: .vertical)
            Spacer()
        }
        .padding()
//        .navigationTitle("디테일 화면")
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
    @State var itemList:[MemoItem] = dummyList

    func removeItem(at indexSet:IndexSet) {
        itemList.remove(atOffsets: indexSet)
    }

    func moveList(from source:IndexSet, to destination:Int ) {
        itemList.move(fromOffsets: source, toOffset: destination)
    }

    func addItem() {
        itemList.append(MemoItem(title: "새로운 메모", contents: ""))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(itemList) { item in
                    NavigationLink {
                        DetailView()
                    } label: {
                        ListItem(memo: item)
                    }
                }
                .onDelete(perform: removeItem)
                .onMove(perform: moveList)
//                ForEach(itemList.map{$0.key}, id:\.self) { headDate in
//                    Section(headDate) {
//                        ForEach(itemList[headDate]!) { item in
//                            NavigationLink {
//                                DetailView()
//                            } label: {
//                                ListItem(memo: item)
//                            }
//                        }
//                        .onDelete { IndexSet in
//
//                        }
//                    }
//                }
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
                    EditButton()
                    Button("+") {addItem()}
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
