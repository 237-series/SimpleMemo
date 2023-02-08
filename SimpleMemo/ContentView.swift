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
    
    func fullString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: self)
    }
}

struct MemoItem: Identifiable, Codable {
    var id=UUID()
    var date=Date()
    var title:String
    var contents:String
}



struct DetailView:View {
    @Environment(\.dismiss) private var dismiss
    @Binding var memoItem:MemoItem
    
    var body: some View {

        VStack(alignment: .leading){
            TextField("타이틀 입력", text: $memoItem.title)
                .font(.title)
            Text($memoItem.date.wrappedValue.fullString())
            TextField("메모 내용 입력", text: $memoItem.contents, axis: .vertical)
                .padding()
            //TextField("메모 내용을 입력하세요", text: $contents, axis: .vertical)
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup {
                Button {
                    saveMemo()
                } label: {
                    Image(systemName: "checkmark.circle")
                }

            }
        }
    }
    
    func saveMemo() {
        let manager:DataManager = DataManager.shared
        manager.dataList = manager.dataList
        DataManager.shared.dataSync()
        
        dismiss()
    }
}

struct ListItem : View {
    @State var memo:MemoItem
    
    var body: some View {
        VStack( alignment: .leading) {
            Text(memo.title)
                .font(.title3)
            Text(memo.date.fullString())
                .foregroundColor(.gray)
        }
        
    }
}

struct ContentView: View {
    @StateObject var manager:DataManager = DataManager.shared
    @State var itemList:[MemoItem] = dummyList

    func removeItem(at indexSet:IndexSet) {
        //itemList.remove(atOffsets: indexSet)
        manager.remove(indexSet)
    }

    func moveList(from source:IndexSet, to destination:Int ) {
        //itemList.move(fromOffsets: source, toOffset: destination)
        manager.move(from: source, to: destination)
    }

    func addItem() {
//        itemList.append(MemoItem(title: "새로운 메모", contents: ""))
        manager.add(MemoItem: MemoItem(title: "새로운 메모", contents: ""))
    }
    

    var body: some View {
        NavigationView {
            List(manager.dataList.indices, id:\.self) { idx in
                NavigationLink {
                    DetailView(memoItem: $manager.dataList[idx])
                } label: {
                    ListItem(memo: manager.dataList[idx])
                }
                
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
                    Button {
                        addItem()
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
                /*
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                    

                }*/
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
