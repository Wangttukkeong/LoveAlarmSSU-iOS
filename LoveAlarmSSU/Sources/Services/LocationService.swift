//
//  LocationService.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/12/25.
//

import Foundation
import CoreLocation
import Combine

final class LocationService: NSObject {

    // LocationService 싱글톤 인스턴스
    static let shared = LocationService()

    // 내부 Subject
    /// 현재 위치 Subject
    private let currentLocationSubject: CurrentValueSubject<CLLocation?, Never>
    /// 권한 Subject
    private let authorizationStatusSubject: CurrentValueSubject<CLAuthorizationStatus, Never>

    // Publisher
    /// 위치 변화 Publisher
    var currentLocationPublisher: AnyPublisher<CLLocation, Never> {
        currentLocationSubject
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    /// 권한 상태 변화 Publisher
    var authorizationStatusPublisher: AnyPublisher<CLAuthorizationStatus, Never> {
        authorizationStatusSubject.eraseToAnyPublisher()
    }

    // 내부 프로퍼티
    private(set) var currentLocation: CLLocation? {
        didSet { currentLocationSubject.send(currentLocation) }
    }
    private(set) var authorizationStatus: CLAuthorizationStatus {
        didSet { authorizationStatusSubject.send(authorizationStatus) }
    }

    /// CLLocationManager 인스턴스
    private let locationManager: CLLocationManager

    private override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus

        currentLocationSubject = CurrentValueSubject<CLLocation?, Never>(nil)
        authorizationStatusSubject = CurrentValueSubject<CLAuthorizationStatus, Never>(authorizationStatus)

        super.init()
        locationManager.delegate = self

        // accuracy(위치 정확도) 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // 백그라운드 위치 업데이트 허용
        locationManager.allowsBackgroundLocationUpdates = true
        // 백그라운드 위치 변화 없을 시에도 추적 중지 방지
        locationManager.pausesLocationUpdatesAutomatically = false
        // 위치 5미터 이상 변화 시 업데이트
        locationManager.distanceFilter = 5
        // 상태바 (Dynamic Island / 노치 / touch id 기종 상태바)에 위치 업데이트 인디케이터 표시
        locationManager.showsBackgroundLocationIndicator = true
    }

    /// 위치 권한 요청 (앱 사용 중 + 백그라운드)
    private func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }

    /// 위치 업데이트 시작
    func startLocationUpdate() {
        // 권한이 허용된 경우에만
        guard authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse else {
            requestAuthorization()
            return
        }
        locationManager.startUpdatingLocation()
    }

    /// 위치 업데이트 중지
    func stopUpdating() {
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else {
            dump(#function); dump("locations empty")
            return
        }
        dump("사용자 위치: \(loc.coordinate)")
        self.currentLocation = loc

    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dump("LocationService error: \(error.localizedDescription)")
    }
}
