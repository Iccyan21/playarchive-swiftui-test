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
    // ライブラリから写真を読み込む
    @State var selectedImage = UIImage()
    @State var showingImagePicker = false
    
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
                
                Image(uiImage: self.selectedImage)
                    .resizable()
                    .frame(width: 300,height: 150)
                
                Button(action: {
                    showingImagePicker = true
                }){
                    Text("写真を読み込む")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(5)
                .disabled(archive.movies.count >= 5)
                // 最大5つまで制限
                .sheet(isPresented: $showingImagePicker, content: {
                    ImagePicker(selectedImage: self.$selectedImage)
                })
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
    private func addMovie() {
        if archive.movies.count < 5 {
            archive.movies.append(Movie(videotitle: "", video: nil))
        } else {
            // ユーザーに通知するための処理（例：アラートを表示）
            print("動画は最大5つまでです。")
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
