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
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
