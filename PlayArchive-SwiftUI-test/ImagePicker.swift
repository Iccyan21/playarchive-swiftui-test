//
//  ImagePicker.swift
//  PlayArchive-SwiftUI-test
//
//  Created by 水原　樹 on 2024/01/02.
//

import SwiftUI
import PhotosUI
// UIKitで見た目を作るもの
struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    // 画像を取得する関数
    class Coordinator: PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]){
            picker.dismiss(animated: true)
            
            for image in results {
                image.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: {(image,error) in
                    if let image = image as? UIImage {
                        self.parent.selectedImage = image
                    }
                })
            }
        }
    }
    
}
