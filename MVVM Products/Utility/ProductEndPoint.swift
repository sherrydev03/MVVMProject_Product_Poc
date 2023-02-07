//
//  ProductEndPoint.swift
//  MVVM Products
//
//  Created by  Macbook on 03/02/23.
//
import Foundation

enum ProductEndPoint {

    case newProducts // Module - GET
}

//https://run.mocky.io/v3/2f06b453-8375-43cf-861a-06e95a951328

extension ProductEndPoint: EndPointType {

    var path: String {
        switch self {
        case.newProducts:
            return "v3/2f06b453-8375-43cf-861a-06e95a951328"
        }
    }

    var baseURL: String {
        switch self {
        case .newProducts:
            return "https://run.mocky.io/"
        }
    }

    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }

    var method: HTTPMethods {
        switch self {
        case .newProducts:
            return .get
        }
    }

    var body: Encodable? {
        switch self {
        case .newProducts:
            return nil
        }
    }

    var headers: [String : String]? {
        APIManager.commonHeaders
    }
}
