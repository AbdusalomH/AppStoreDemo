//
//  AppDetailView.swift
//  AppStoreMockInterview
//
//  Created by Abdusalom on 17/04/2024.
//

import SwiftUI


struct AppDetailView: View {
    
    @State var isDetailsOpened = false
    
    @StateObject var md: AppDetailViewModel
    
    let trackId: Int
    
    init(trackId: Int) {
        self._md = .init(wrappedValue: AppDetailViewModel(trackId: trackId))
        self.trackId = trackId
    }
    

    
    
    var body: some View {
   
        GeometryReader { proxy in
            if let _ = md.error {
                Text("Not able to get application details!")
                    .font(.largeTitle)
                    .padding(.vertical)
                    .multilineTextAlignment(.center)
                    .position(CGPoint(x: proxy.size.width/2, y: proxy.size.height/2))
            }
            ScrollView {
                if let appdetails = md.fetchdetails {
                    VStack {
                        HStack {
                            AsyncImage(url: URL(string: appdetails.artworkUrl512)) { image in
                                image
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(.rect(cornerRadius: 12))
                            } placeholder: {
                                Image(systemName: "globe")
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(.rect(cornerRadius: 12))
                            }
                            VStack(alignment: .leading, spacing: 12) {
                                Text("\(appdetails.trackName)")
                                    .font(.title)
                                    .lineLimit(2)
                                
                                Text(appdetails.primaryGenreName)
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                HStack {
                                    Button {
                                        print("download tapped")
                                    } label: {
                                        Image(systemName: "icloud.and.arrow.down")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.blue)
                                            .fontWeight(.bold)
                                    }
                                    Spacer()
                                    
                                    Button {
                                        print("download tapped")
                                    } label: {
                                        Image(systemName: "square.and.arrow.up")
                                            .resizable()
                                            .renderingMode(.original)
                                            .frame(width: 15, height: 20)
                                            .foregroundColor(.blue)
                                            .fontWeight(.bold)
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding(.vertical)
                        .scrollIndicators(.hidden)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("What's New")
                                    .font(.system(size: 24, weight: .semibold))
                                    .padding(.vertical)
                                
                                Spacer()
                                
                                Button {
                                    print("version history")
                                } label: {
                                    Text("Version history")
                                }
                            }
                            Text(appdetails.releaseNotes)
                                .font(.caption)
                            HStack {
                                Spacer()
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("Preview")
                                .font(.system(size: 18, weight: .semibold))
                                .padding(.bottom, 10)
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(appdetails.screenshotUrls, id: \.self) { screenshots in
                                        Button {
                                            isDetailsOpened.toggle()
                                        } label: {
                                            
                                            AsyncImage(url: URL(string: screenshots)) { image in
                                                image
                                                    .resizable()
                                                    .frame(width: 150, height: 300)
                                                    .aspectRatio(contentMode: .fill)
                                                    .clipShape(.rect(cornerRadius: 8))
                                            } placeholder: {
                                                Rectangle()
                                                    .frame(width: 150, height: 300)
                                                    .clipShape(.rect(cornerRadius: 8))
                                            }
                                        }
                                        .foregroundStyle(Color(.label))
                                    }
                                    .fullScreenCover(isPresented: $isDetailsOpened, content: {
                                        PhotoDetails(isDetailsOpened: true, screenshotUrls: appdetails.screenshotUrls)
                                    })
                                }
                            }
                        }
                        .padding(.vertical)
                        VStack(alignment: .leading) {
                            Text("Reviews")
                                .font(.system(size: 18, weight: .semibold))
                                .padding(0)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        ReviewView(trackId: trackId, proxy: proxy)
                            .padding(.vertical)
                            
                        VStack(alignment: .leading, spacing: 20) {
                            
                            Text("Description")
                                .font(.system(size: 20, weight: .semibold))
                            Text(appdetails.description)
                                .font(.caption)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    AppDetailView(trackId: 222332)
}
