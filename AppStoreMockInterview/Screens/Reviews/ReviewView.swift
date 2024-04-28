//
//  ReviewView.swift
//  AppStoreMockInterview
//
//  Created by Abdusalom on 20/04/2024.
//

import SwiftUI




struct ReviewView: View {
    
    @StateObject var md: ReviewsViewModel
    
    private let proxy: GeometryProxy
    
    
    init(trackId: Int, proxy: GeometryProxy) {
        self.proxy = proxy
        self._md = .init(wrappedValue: .init(trackId: trackId))
    }
    
    var body: some View {
        
        
        ScrollView(.horizontal) {
 
            HStack {
                ForEach(md.entries) { review in
                    VStack(alignment: .leading, spacing: 16 ) {
                        HStack {
                            Text(review.title.label)
                                .font(.system(size: 18, weight: .semibold))
                                .lineLimit(1)
                            Spacer()
                            Text(review.author.name.label)
                                .foregroundStyle(Color(.lightGray))
                                .lineLimit(1)
                        }
                        HStack(spacing:0) {
                            if let rating = Int(review.rating.label) {
                                ForEach(0..<rating, id:\.self) { reting in
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(Color.yellow)
                                }
                                ForEach(0..<5-rating, id:\.self) { reting in
                                    Image(systemName: "star")
                                        .foregroundStyle(Color.yellow)
                                }
                            }
                        }
                        Text(review.content.label)
                        Spacer()
                    }
                    .padding(20)
                    .frame(width: proxy.size.width - 64, height: 220)
                    .background(Color(#colorLiteral(red: 0.3342211246, green: 0.3342211246, blue: 0.3342211246, alpha: 1)))
                    .clipShape(.rect(cornerRadius: 12))
                }
            }
            //.padding()
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    GeometryReader { proxy in
        ReviewView(trackId: 595287172, proxy: proxy)
    }
}
