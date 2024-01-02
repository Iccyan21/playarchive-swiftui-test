//
//  ImagePicker.swift
//  PlayArchive-SwiftUI-test
//
//  Created by 水原　樹 on 2024/01/02.
//

import SwiftUI
import PhotosUI
import AVFoundation

struct VideoPicker: UIViewControllerRepresentable {
    @Binding var selectedVideo: AVAsset?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .videos // 動画を選択するために変更
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: VideoPicker
        
        init(parent: VideoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let result = results.first, result.itemProvider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) else { return }
            
            result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { url, error in
                guard let url = url, error == nil else { return }
                
                // AVAssetを使用して動画を読み込む
                let asset = AVAsset(url: url)
                DispatchQueue.main.async {
                    self.parent.selectedVideo = asset
                }
            }
        }
    }
}

