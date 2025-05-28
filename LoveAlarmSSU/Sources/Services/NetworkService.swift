//
//  NetworkService.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/13/25.
//

import Foundation
import Moya

enum APIClient {
    // interest-controller
    case getInterest(id: String)
    case putInterest(id: String, body: [String: Any])

    // location-controller
    case getLocation(id: String)
    case getNearbyAll(id: String)
    case getNearbyMatch(id: String)
    case putLocation(id: String, body: [String: Any])

    // user-controller
    case getUser(id: String)
    case signUp(body: CreateUserRequestDTO)
    case patchUser(id: String, body: C)
    case deleteUser(id: String)
}

extension APIClient: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.lovealarm.yourssu.com")!
    }

    var path: String {
        switch self {
        case .getInterest(let id):
            return "/interest/\(id)"
        case .putInterest(let id, _):
            return "/interest/update/\(id)"
        case .getLocation(let id):
            return "/location/\(id)"
        case .getNearbyAll(let id):
            return "/location/nearby/all/\(id)"
        case .getNearbyMatch(let id):
            return "/location/nearby/match/\(id)"
        case .putLocation(let id, _):
            return "/location/update/\(id)"
        case .getUser(let id):
            return "/user/\(id)"
        case .signUp:
            return "/user/sign-up"
        case .patchUser(let id, _):
            return "/user/update/\(id)"
        case .deleteUser(let id):
            return "/user/withdrawal/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getInterest,
             .getLocation,
             .getNearbyAll,
             .getNearbyMatch,
             .getUser:
            return .get
        case .signUp:
            return .post
        case .putInterest,
             .putLocation:
            return .put
        case .patchUser:
            return .patch
        case .deleteUser:
            return .delete
        }
    }

    var task: Task {
        switch self {
        case .signUp(let body),
             .putInterest(_, let body),
             .putLocation(_, let body),
             .patchUser(_, let body):
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
        case .getInterest,
             .getLocation,
             .getNearbyAll,
             .getNearbyMatch,
             .getUser,
             .deleteUser:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
