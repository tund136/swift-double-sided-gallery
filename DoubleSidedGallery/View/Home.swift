//
//  Home.swift
//  DoubleSidedGallery
//
//  Created by Danh Tu on 11/10/2021.
//

import SwiftUI

struct Home: View {
    // Posts
    @State var posts: [Post] = []
    
    // Current Image
    @State var currentPost: String = ""
    
    @State var fullPreview: Bool = false
    
    var body: some View {
        // Double Side Gallery
        TabView(selection: $currentPost) {
            ForEach(posts) { post in
                // Getting screen size for image
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    Image(post.postImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
                .tag(post.id)
                .ignoresSafeArea()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .onTapGesture {
            withAnimation {
                fullPreview.toggle()
            }
        }
        // Top detail view
        .overlay(
            HStack {
                Text("Gallery Pic")
                    .font(.title2.bold())
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "square.and.arrow.up.fill")
                        .font(.title2)
                }
            }
                .foregroundColor(Color.white)
                .padding()
                .background(BlurView(style: .systemUltraThinMaterialDark).ignoresSafeArea())
            // Hiding top bar
                .offset(y: fullPreview ? -150 : 0)
            ,
            alignment: .top
        )
        // Bottom image view
        .overlay(
            // Scroll View reader to navigate to current image
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(posts) { post in
                            Image(post.postImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 60)
                                .cornerRadius(10)
                            // Showing ring for current image
                                .padding(2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color.white, lineWidth: 2)
                                        .opacity(currentPost == post.id ? 1 : 0)
                                )
                                .id(post.id)
                                .onTapGesture {
                                    withAnimation {
                                        currentPost = post.id
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 80)
                .background(BlurView(style: .systemUltraThinMaterialDark).ignoresSafeArea())
                // While CurrentPost changing moving the current image view to center of scroll view
                .onChange(of: currentPost) { _ in
                    withAnimation {
                        proxy.scrollTo(currentPost, anchor: .bottom)
                    }
                }
            }
            // Hiding bottom bar
                .offset(y: fullPreview ? 150 : 0),
            alignment: .bottom
        )
        // Inserting sample post images
        .onAppear {
            for index in 1...9 {
                posts.append(Post(postImage: "post\(index)"))
            }
            
            currentPost = posts.first?.id ?? ""
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
