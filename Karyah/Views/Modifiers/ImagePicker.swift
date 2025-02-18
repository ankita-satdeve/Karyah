//
//  ImagePicker.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//

import SwiftUI
import UIKit
import TOCropViewController

struct ImagePickerWithCrop: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    @StateObject private var userProfileViewModel = UserProfileViewModel()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate, TOCropViewControllerDelegate {
        let parent: ImagePickerWithCrop
        
        init(_ parent: ImagePickerWithCrop) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                let cropViewController = TOCropViewController(image: image)
                cropViewController.delegate = self
                picker.present(cropViewController, animated: true)
            }
        }
        
//        func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
//            parent.selectedImage = image
//            cropViewController.dismiss(animated: true) {
//                self.parent.presentationMode.wrappedValue.dismiss()
//            }
//        }
        
        func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
            parent.selectedImage = image
            parent.userProfileViewModel.tempProfilePhoto = image  // Keep temporary image
            cropViewController.dismiss(animated: true) {
                self.parent.presentationMode.wrappedValue.dismiss()
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
}
