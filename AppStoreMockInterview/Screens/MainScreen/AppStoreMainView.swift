//
//  ContentView.swift
//  AppStoreMockInterview
//
//  Created by Abdusalom on 16/04/2024.
//

import SwiftUI
import SwiftData
import Combine


struct AppStoreMainView: View {
    
    @StateObject var vw = AppStoreModel()
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    if vw.isSearching {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .controlSize(.large)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    if vw.results.isEmpty {
                        VStack(alignment: .center) {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("Please enter your search terms above")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.orange)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    } else {
                        
                        ScrollView {
                            ForEach(vw.results) { result in
                                NavigationLink {
                                    AppDetailView(trackId: result.trackId)
                                } label: {
                                    VStack(spacing: 16) {
                                        TitleInformation(titleName: result.trackName, imageUrl: result.artworkUrl512, genrName: result.primaryGenreName, userRatingCount: result.userRatingCount, averageUserRating: result.averageUserRating)
                                        ScreenshotRow(screenshotUrls: result, geometry: geometry)
                                        
                                    }
                                }
                                .foregroundStyle(Color(.label))
                                .padding(12)
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Search")
            .searchable(text: $vw.searchString)
        }
    }
}




struct TitleInformation: View {
    
    let titleName: String
    let imageUrl: String
    let genrName: String
    let userRatingCount: Int
    let averageUserRating: Double
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .frame(width: 80, height: 80)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(.rect(cornerRadius: 12))
                
            } placeholder: {
                Image(systemName: "globe")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(.rect(cornerRadius: 12))
            }
            
            VStack(alignment: .leading) {
                Text("\(titleName)")
                    .lineLimit(1)
                Text(genrName)
                    .foregroundStyle(.gray)
                HStack(spacing: 1) {
                    ForEach(0..<Int(averageUserRating), id: \.self) { num in
                        Image(systemName: "star.fill")
                            .padding(0)
                    }
                    ForEach(0..<5 - Int(averageUserRating), id: \.self) { num in
                        Image(systemName: "star")
                    }
                    Text("\(userRatingCount.roundedWithAbreviations)")
                        .lineLimit(1)
                }
            }
            Spacer()
     
            Button{
                print("cloud button tapped")
            }label: {
                Image(systemName: "icloud.and.arrow.down")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
                    .padding()
            }
        }
    }
}

struct ScreenshotRow: View {
    
    let screenshotUrls: Result
    
    let geometry: GeometryProxy
    
    
    var body: some View {
        
        ScrollView(.horizontal) {
            
            let width = (geometry.size.width - 4 * 12) / 3
            
            HStack(spacing: 12) {
                
                ForEach(screenshotUrls.screenshotUrls, id: \.self) { screenshots in
                    AsyncImage(url: URL(string: screenshots)) { image in
                        image
                            .resizable()
                            .frame(width: width, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } placeholder: {
                        Rectangle()
                            .frame(width: width, height: 200)
                            .clipShape(.rect(cornerRadius: 8))
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    AppStoreMainView()
}
