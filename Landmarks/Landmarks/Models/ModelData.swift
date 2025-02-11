//
//  ModelData.swift
//  Building lists and navigation
//
//  Created by 심근웅 on 2/10/25.
//

import Foundation

@Observable
class ModelData {
    var landmarks: [Landmark] = load("landmarkData.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    // Resource에 넣은 파일주소 가져오기
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Coudn't find \(filename) in main bundle")
    }
    
    //주소에 있는 파일을 data로 받아오기
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    //받아온 내용을 JSON 데이터로 디코딩 - 어떤형식? : T의 형식
    do {
        let decoer = JSONDecoder()
        return try decoer.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error))")
    }
}
