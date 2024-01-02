//
//  CreateArchiveView.swift
//  PlayArchive-SwiftUI-test
//
//  Created by 水原　樹 on 2024/01/01.
//

import SwiftUI
import AVFoundation

struct CreateArchiveView: View {
    @State private var archive = Archive(title: "", subtitle: "", context: "", isPrivate: false, movies: [])
    @State private var errorMessage: String? = nil
    @State private var isLoading: Bool = false
    @State private var selectedImage = UIImage()
    @State private var showingVideoPicker = false
    @State private var selectedVideo: AVAsset? // 追加された動画用の状態変数
    
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
                
                
                Image(uiImage: self.selectedImage)
                    .resizable()
                    .frame(width: 300,height: 150)
                
                Button(action: {
                    showingVideoPicker = true
                }) {
                    Text("動画を読み込む")
                }
                // 省略: その他のビューコンポーネント
                .sheet(isPresented: $showingVideoPicker, content: {
                    VideoPicker(selectedVideo: $selectedVideo)
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
        if let video = selectedVideo, archive.movies.count < 5 {
            // AVAssetからURLを取得し、Movie構造体を作成して追加
            if let videoURL = (video as? AVURLAsset)?.url {
                archive.movies.append(Movie(videotitle: "新しい動画", video: videoURL))
            }
        } else {
            // エラーメッセージや制限に関する処理
        }
    }
}

#Preview {
    CreateArchiveView()
}
