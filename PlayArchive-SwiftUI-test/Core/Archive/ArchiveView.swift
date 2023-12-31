//
//  ArchiveView.swift
//  PlayArchive-SwiftUI-test
//
//  Created by 水原　樹 on 2023/12/31.
//

import SwiftUI

struct ArchiveView: View {
    @State private var searchQuery: String = ""
    
    // 仮のデータモデル
    struct Archive {
        var userid: Int
        var title: String
        var isPrivate: Bool
        var context: String
        var createdAt: String
    }
    
    // 仮のデータ
    let archives = [
        Archive(userid: 1, title: "Title 1", isPrivate: false, context: "Description 1", createdAt: "Date 1"),
        Archive(userid: 2, title: "Title 2", isPrivate: true, context: "Description 2", createdAt: "Date 2"),
        // 他のアーカイブも同様に追加...
    ]
    
    var body: some View {
        VStack {
            searchAndCreateSection
            archiveList
        }
        .padding()
    }
    
    private var searchAndCreateSection: some View {
        HStack {
            TextField("Archiveを検索する", text: $searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading, 10)
            
            Spacer()
            
            NavigationLink(destination: ContentView(), label: {
                Text("New")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            })
        }
        .padding(.bottom, 20)
    }
    
    private var archiveList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(archives, id: \.userid) { archive in
                    ArchiveRow(archive: archive)
                }
            }
            .padding()
        }
        .background(Color.gray.opacity(0.1))
    }
}

struct ArchiveRow: View {
    let archive: ArchiveView.Archive
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                NavigationLink(destination: Text(archive.title)) {
                    Text(archive.title)
                        .font(.headline)
                        .foregroundColor(.blue)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                
                Spacer()
                
                Text(archive.isPrivate ? "Private" : "Public")
                    .padding(.horizontal, 10)
                    .padding(.vertical, 2)
                    .background(archive.isPrivate ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .font(.caption)
                    .cornerRadius(20)
            }
            
            Text(archive.context)
                .font(.body)
                .foregroundColor(.secondary)
            
            Text(archive.createdAt)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct ArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveView()
    }
}

