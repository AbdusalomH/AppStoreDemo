//
//  ActivityIndicatioLoading.swift
//  AppStoreMockInterview
//
//  Created by Abdusalom on 19/04/2024.
//

import SwiftUI



struct ActivityIndicatioLoading: UIViewRepresentable  {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        
        let activityIndication = UIActivityIndicatorView(style: .large)
        activityIndication.color = UIColor(Color(.gray))
        activityIndication.startAnimating()
        return activityIndication
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }

}


struct LoadinView: View {
    var body: some View {
        ZStack {
            ActivityIndicatioLoading()
        }
    }
}
