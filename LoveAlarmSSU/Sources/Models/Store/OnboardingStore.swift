//
//  OnboardingStore.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/28/25.
//

import Foundation

@Observable
final class OnboardingStore {
    // MARK: - Basic
    var emoji: String = ""
    var name: String = ""
    var gender: Gender? = nil
    var selectedYear: Int?
    var basicDisableCondition: Bool {
        emoji.isEmpty || name.isEmpty || gender == nil || selectedYear == nil
    }

    // MARK: - Optional
    var height: String = ""
    var major: String = ""
    let heightRegex = /^[0-9]{3}cm$/
    let majorRegex = /^.*(?:학과|학부)$/
    var optionalDisableCondition: Bool {
        height.wholeMatch(of: heightRegex) == nil || major.wholeMatch(of: majorRegex) == nil
    }

    // MARK: - Category
    let categories = Category.allCases
    var selectedCategories = Set<Category>()

    func mapCategories() {
        let arr = Array(selectedCategories)
        guard let first = arr.first,
              let second = arr.last
        else { return }
        firstCategory = first
        secondCategory = second
        firstSubCategoriesWithHashtags.removeAll()
        firstSubCategoryInputText = ["", ""]
        secondSubCategoriesWithHashtags.removeAll()
        secondSubCategoryInputText = ["", ""]
    }

    // MARK: - SubCategory 1st
    var firstCategory: Category = .exercise
    var firstSubCategories: [SubCategory] { firstCategory.subCategories }
    var firstSubCategoriesWithHashtags: [SubCategoryWithHashtags] = []
    var firstSubCategoryInputText: [String] = ["", ""]

    // MARK: - SubCategory 2nd
    var secondCategory: Category = .fashion
    var secondSubCategories: [SubCategory] { secondCategory.subCategories }
    var secondSubCategoriesWithHashtags: [SubCategoryWithHashtags] = []
    var secondSubCategoryInputText: [String] = ["", ""]
}
