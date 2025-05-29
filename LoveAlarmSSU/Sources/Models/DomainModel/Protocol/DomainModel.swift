//
//  DomainModel.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/29/25.
//

protocol DomainModel {
    associatedtype DTO

    var requestDTO: DTO { get }
}
