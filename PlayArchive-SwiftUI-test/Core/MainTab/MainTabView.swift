//
//  MainTabView.swift
//  PlayArchive-SwiftUI-test
//
//  Created by 水原　樹 on 2024/01/01.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    
    // クリックすると移動する処理
    var body: some View {
        TabView(selection: $selectedIndex) {
            HomeView().onTapGesture {
                self.selectedIndex = 0
            }
            .tabItem {
                Image(systemName: "house")
            }.tag(0)
            
            ArchiveView().onTapGesture {
                self.selectedIndex = 1
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
            }.tag(1)
            
            CreateArchiveView().onTapGesture {
                self.selectedIndex = 2
            }
            .tabItem {
                Image(systemName: "bell")
            }.tag(2)
            
            ArchiveView().onTapGesture {
                self.selectedIndex = 3
            }
            .tabItem {
                Image(systemName: "envelope")
            }.tag(3)
            
            
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
