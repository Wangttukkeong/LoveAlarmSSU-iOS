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
    static func getInterest() async throws -> [Interest] {
        let data = try await provider.request(.getInterest)
        let responseDTO = try JSONDecoder().decode([InterestResponseDTO].self, from: data)
        let domainModel = responseDTO.compactMap(\.domainModel)
        return domainModel
    }

    static func putInterest(_ body: [CreateInterestRequestDTO]) async throws -> [Interest] {
        let data = try await provider.request(.putInterest(body: body))
        let responseDTO = try JSONDecoder().decode([InterestResponseDTO].self, from: data)
        let domainModel = responseDTO.compactMap(\.domainModel)
        return domainModel
    }

    // MARK: - Location
    static func getLocation() async throws -> Location {
        let data = try await provider.request(.getLocation)
        let responseDTO = try JSONDecoder().decode(LocationResponseDTO.self, from: data)
        let domainModel = responseDTO.domainModel
        return domainModel
    }

    static func getNearbyAll() async throws -> [NearbyUser] {
        let data = try await provider.request(.getNearbyAll)
        let responseDTO = try JSONDecoder().decode([NearByUserResponse].self, from: data)
        let domainModel = responseDTO.compactMap(\.domainModel)
        return domainModel
    }

    static func getNearbyMatch() async throws -> [NearbyUser] {
        let data = try await provider.request(.getNearbyMatch)
        let responseDTO = try JSONDecoder().decode([NearByUserResponse].self, from: data)
        let domainModel = responseDTO.compactMap(\.domainModel)
        return domainModel
    }

    static func putLocation(_ body: CreateLocationRequestDTO) async throws -> Location {
        let data = try await provider.request(.putLocation(body: body))
        let responseDTO = try JSONDecoder().decode(LocationResponseDTO.self, from: data)
        let domainModel = responseDTO.domainModel
        return domainModel
    }

    // MARK: - User
    static func getUser() async throws -> User {
        let data = try await provider.request(.getUser)
        let responseDTO = try JSONDecoder().decode(UserResponseDTO.self, from: data)
        let domainModel = responseDTO.domainModel
        return domainModel
    }

    static func postUser(_ body: CreateUserRequestDTO) async throws -> User {
        dump(body)
        let data = try await provider.request(.postUser(body: body))
        dump(data)
        let responseDTO = try JSONDecoder().decode(UserResponseDTO.self, from: data)
        let domainModel = responseDTO.domainModel
        return domainModel
    }

    static func patchUser(_ body: UpdateUserRequestDTO) async throws -> Bool {
        _ = try await provider.request(.patchUser(body: body))
        return true
    }

    static func deleteUser() async throws -> Bool {
        _ = try await provider.request(.deleteUser)
        return true
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
    case postUser(body: CreateUserRequestDTO)
    case patchUser(body: UpdateUserRequestDTO)
    case deleteUser
}

extension APIClient: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.lovealarm.yourssu.com")!
    }

    var path: String {
        var id: String { UserDefaults.standard.string(forKey: "uuidString") ?? "" }
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
        case .postUser:
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
        case .postUser:
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
        case .postUser(let body):
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
                    dump(error.response?.description)
                    dump(String(data: error.response?.data ?? Data(), encoding: .utf8))
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

