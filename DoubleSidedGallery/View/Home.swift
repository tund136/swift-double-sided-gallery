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
        .ignoresSafeArea()
        .tabViewStyle(.page(indexDisplayMode: .never))
        // Inserting sample post images
        .onAppear {
            for index in 1...9 {
                posts.append(Post(postImage: "post\(index)"))
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
