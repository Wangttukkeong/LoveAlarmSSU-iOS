//
//  NetworkService.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/13/25.
//

import Foundation
import Moya

struct NetworkService {
    private static let provider = MoyaProvider<APIClient>()

    // MARK: - Interest
    static func getInterest() async throws -> Data {
        try await provider.request(.getInterest)
    }

    static func putInterest(_ body: [CreateInterestRequestDTO]) async throws -> Data {
        try await provider.request(.putInterest(body: body))
    }

    // MARK: - Location
    static func getLocation() async throws -> Data {
        try await provider.request(.getLocation)
    }

    static func getNearbyAll() async throws -> Data {
        try await provider.request(.getNearbyAll)
    }

    static func getNearbyMatch() async throws -> Data {
        try await provider.request(.getNearbyMatch)
    }

    static func putLocation(_ body: CreateLocationRequestDTO) async throws -> Data {
        try await provider.request(.putLocation(body: body))
    }

    // MARK: - User
    static func getUser() async throws -> Data {
        try await provider.request(.getUser)
    }

    static func signUp(_ body: CreateUserRequestDTO) async throws -> Data {
        try await provider.request(.signUp(body: body))
    }

    static func patchUser(_ body: UpdateUserRequestDTO) async throws -> Data {
        try await provider.request(.patchUser(body: body))
    }

    static func deleteUser() async throws -> Data {
        try await provider.request(.deleteUser)
    }
}


enum APIClient {
    // interest-controller
    case getInterest
    case putInterest(body: [CreateInterestRequestDTO])

    // location-controller
    case getLocation
    case getNearbyAll
    case getNearbyMatch
    case putLocation(body: CreateLocationRequestDTO)

    // user-controller
    case getUser
    case signUp(body: CreateUserRequestDTO)
    case patchUser(body: UpdateUserRequestDTO)
    case deleteUser
}

extension APIClient: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.lovealarm.yourssu.com")!
    }

    var path: String {
        var id: String { UserDefaults.standard.string(forKey: "userId") ?? "" }
        switch self {
        case .getInterest:
            return "/interest/\(id)"
        case .putInterest:
            return "/interest/update/\(id)"
        case .getLocation:
            return "/location/\(id)"
        case .getNearbyAll:
            return "/location/nearby/all/\(id)"
        case .getNearbyMatch:
            return "/location/nearby/match/\(id)"
        case .putLocation:
            return "/location/update/\(id)"
        case .getUser:
            return "/user/\(id)"
        case .signUp:
            return "/user/sign-up"
        case .patchUser:
            return "/user/update/\(id)"
        case .deleteUser:
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
        case .getInterest,
             .getLocation,
             .getNearbyAll,
             .getNearbyMatch,
             .getUser,
             .deleteUser:
            return .requestPlain
        case .putInterest(let body):
            return .requestJSONEncodable(body)
        case .putLocation(let body):
            return .requestJSONEncodable(body)
        case .signUp(let body):
            return .requestJSONEncodable(body)
        case .patchUser(let body):
            return .requestJSONEncodable(body)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    var validationType: ValidationType { .successCodes }
}

extension MoyaProvider {
    func request(_ target: Target) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case let .success(response):
                    continuation.resume(returning: response.data)
                case let .failure(error):
                    dump(error.response?.statusCode)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

