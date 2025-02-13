//
//  KeyboardManager.swift
//  Karyah
//
//  Created by Prance Studio on 13/02/25.
//

import SwiftUI
import Combine

class KeyboardManager: ObservableObject {
    @Published var offset: CGFloat = 0
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addKeyboardObservers()
    }
    
    private func addKeyboardObservers() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    withAnimation {
                        self.offset = -keyboardFrame.height / 2
                    }
                }
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { _ in
                withAnimation {
                    self.offset = 0
                }
            }
            .store(in: &cancellables)
    }
}
