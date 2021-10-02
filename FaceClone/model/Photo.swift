//
//  Photo.swift
//  FaceClone
//
//  Created by Wesley Marra on 02/10/21.
//

import Foundation

struct Photo: Codable {
    let albumId, id: Int?
    let title: String?
    let url, thumbnailUrl: String?
}
