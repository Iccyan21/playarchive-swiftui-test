//
//  CreateArchiveView.swift
//  PlayArchive-SwiftUI-test
//
//  Created by 水原　樹 on 2024/01/01.
//

import SwiftUI

struct CreateArchiveView: View {
    @State private var archive = Archive(title: "", subtitle: "",context:"",isPrivate: false, movies:[])
    @State private var errorMessage: String? = nil
    @State private var isLoading: Bool = false
    
    struct Archive {
        var title: String
        var subtitle: String
        var context: String
        var isPrivate: Bool
        var movies: [Movie]
    }
    struct Movie {
        var videotitle: String
        var video: URL?
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading,spacing: 10){
                Text("アーカイブを作成する")
                    .font(.title)
                TextField("タイトル名",text: $archive.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("\(archive.title.count)/20文字")
                
                TextField("簡単な説明",text:$archive.subtitle)
                Text("\(archive.subtitle.count)/20文字")
                TextEditor(text: $archive.context)
                    .frame(height: 200)
                    .border(Color.gray, width: 1)
                Text("\(archive.context.count)/200文字")
                ForEach(0..<archive.movies.count, id: \.self) { index in
                    MovieInputView(movie: $archive.movies[index])
                }
                
                Button("動画を追加する") {
                    // 動画を追加するロジック
                }
                Toggle("非公開にする",isOn: $archive.isPrivate)
                
                if let errorMessage = errorMessage{
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                Button("作成する"){
                    //作成処理
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

struct MovieInputView: View {
    @Binding var movie: CreateArchiveView.Movie
    
    var body: some View{
        VStack{
            TextField("動画タイトル",text: $movie.videotitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("動画を削除する"){
                //　削除ロジック
            }
        }
    }
}

#Preview {
    CreateArchiveView()
}
