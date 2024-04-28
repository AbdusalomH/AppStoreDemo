//
//  PhotoDetails.swift
//  AppStoreMockInterview
//
//  Created by Abdusalom on 18/04/2024.
//

import SwiftUI

struct PhotoDetails: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var isDetailsOpened: Bool
    
    let screenshotUrls: [String]
    
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                VStack() {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .symbolRenderingMode(.monochrome)
                            .foregroundStyle(Color(.label))
                            .padding(.trailing)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(screenshotUrls, id: \.self) { screen in
                            let width = geometry.size.width - 64
                            
                            AsyncImage(url: URL(string: screen)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: width, height: 550)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: width, height: 550)
                                    .foregroundStyle(Color(.label))
                            }
                        }
                    }
                    .padding(.horizontal, 32)
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                
            }
        }
        .gesture(
            DragGesture()
                .onChanged { change in
                    if change.translation.height > 40 {
                        dismiss()
                    }
                }
        )
    }
}

#Preview {
    PhotoDetails(isDetailsOpened: false, screenshotUrls: ["123","123"])
}
