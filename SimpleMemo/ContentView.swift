//
//  ContentView.swift
//  SimpleMemo
//
//  Created by sglee237 on 2023/02/06.
//

import SwiftUI

struct DetailView:View {
    var body: some View {
        Text("Hello, world!")
            .navigationTitle("디테일 화면")
    }
}

struct ListItem : View {
    var body: some View {
        VStack(alignment: .leading){
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<10) { num in
                    NavigationLink {
                        DetailView()
                    } label: {
                        ListItem()
                    }
                    
                }
            }
            .navigationTitle("Main view")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
