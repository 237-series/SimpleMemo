//
//  ContentView.swift
//  SimpleMemo
//
//  Created by sglee237 on 2023/02/06.
//

import SwiftUI

struct MemoItem {
    var id=UUID()
    var date=Date()
    var contents:String
}

struct DetailView:View {
    var body: some View {
        Text("Hello, world!")
            .navigationTitle("디테일 화면")
    }
}

struct ListItem : View {
    var body: some View {
        
        VStack( alignment: .leading) {
            Text("각 일기의 제목")
                .font(.title3)
            Text("2023.")
                .foregroundColor(.gray)
        }
        
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section("색션1") {
                    ForEach(0..<3) { num in
                        NavigationLink {
                            DetailView()
                        } label: {
                            ListItem()
                        }
                    }
                }
                
                Group {
                    ForEach(0..<3) { num in
                        NavigationLink {
                            DetailView()
                        } label: {
                            ListItem()
                        }
                    }
                }
                
                
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
