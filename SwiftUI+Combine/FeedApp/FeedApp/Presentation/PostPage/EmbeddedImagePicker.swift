import SwiftUI
import PhotosUI

struct EmbeddedImagePicker: UIViewControllerRepresentable {
  
  @Binding var selectedImage: UIImage?
  
  // MARK: - make Coordinator
  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  // MARK: - make Controller
  func makeUIViewController(context: Context) -> PHPickerViewController {
    var config = PHPickerConfiguration()
    config.filter = .images
    config.selectionLimit = 1
    config.disabledCapabilities = [
      .search,
      .selectionActions,
      .collectionNavigation,
      .stagingArea,
    ]
    
    let picker = PHPickerViewController(configuration: config)
    picker.delegate = context.coordinator
    return picker
  }
  
  // MARK: - udpate Controller
  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    
  }
  
  // MARK: - Coordinator
  class Coordinator: NSObject, PHPickerViewControllerDelegate {
    
    var parent: EmbeddedImagePicker
    
    init(parent: EmbeddedImagePicker) {
      self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      guard let provider = results.first?.itemProvider,
            provider.canLoadObject(ofClass: UIImage.self) else { return }
      
      provider.loadObject(ofClass: UIImage.self) { image, error in
        DispatchQueue.main.async {
          self.parent.selectedImage = image as? UIImage
        }
      }
    }
  }
}
