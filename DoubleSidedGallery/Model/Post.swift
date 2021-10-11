//
//  Post.swift
//  DoubleSidedGallery
//
//  Created by Danh Tu on 11/10/2021.
//

import Foundation

struct Post: Identifiable, Hashable {
    var id = UUID().uuidString
    var postImage: String
}
