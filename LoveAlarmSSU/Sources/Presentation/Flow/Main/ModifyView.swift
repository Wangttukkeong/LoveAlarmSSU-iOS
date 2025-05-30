//
//  ModifyView.swift
//  LoveAlarmSSU
//
//  Created by 박현수 on 5/30/25.
//

import SwiftUI

struct ModifyView: View {
    enum TabIdx {
        case profile
        case category1
        case category2
    }
    @Environment(AppStore.self) var appStore
    @Environment(AppCoordinator.self) var appCoordinator
    @State var tabIndex: TabIdx = .profile

    @FocusState private var emojiFocusState: Bool
    @FocusState private var nicknameFocusState: Bool
    @FocusState private var heightFocusState: Bool
    @FocusState private var departmentFocusState: Bool

    @State private var selectedYear: String?

    @State private var firstCategoryinterests: [Interest] = []
    @State private var secondCategoryinterests: [Interest] = []
    @State private var user = User()
    @State private var firstCategory: Category?
    @State private var secondCategory: Category?

    let heightRegex = /^[0-9]{3}cm$/
    let majorRegex = /^.*(?:학과|학부)$/
    var optionalDisableCondition: Bool {
        user.height.wholeMatch(of: heightRegex) == nil || user.department.wholeMatch(of: majorRegex) == nil
    }

    var disableCondition: Bool {
        user.emoji.isEmpty ||
        user.nickname.isEmpty ||
        user.gender == nil ||
        (user.height.wholeMatch(of: heightRegex) == nil && !user.height.isEmpty) ||
        (user.department.wholeMatch(of: majorRegex) == nil && !user.department.isEmpty) ||
        firstCategory == nil ||
        secondCategory == nil
    }

    let allCategories = Category.allCases

    var body: some View {
        VStack(spacing: 0) {
            railTab()
            switch tabIndex {
            case .profile:
                profileSection()
            case .category1:
                category1Section()
            case .category2:
                category2Section()
            }
            LAActionButton(
                config: .single(
                    title: "수정하기",
                    action: { modifyUser() },
                    disableCondition: disableCondition,
                    subLabel: nil
                )
            )
        }
        .onAppear {
            self.user = appStore.user
            let firstCategory = appStore.user.interests.first?.category ?? .exercise
            let secondCateogry = appStore.user.interests.last?.category ?? .fashion
            self.firstCategory = firstCategory
            self.secondCategory = secondCateogry
            self.firstCategoryinterests = appStore.user.interests.filter { $0.category == firstCategory }
            self.secondCategoryinterests = appStore.user.interests.filter { $0.category == secondCateogry }
            if user.birthdate.count >= 4 { self.selectedYear = String(user.birthdate.prefix(4)) }
        }
        .withBackground(LAColor.BG.Root.regular)
        .withNavigationBar(.rootPage(text: "프로필 수정"))
    }

    func railTab() -> some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                Text("프로필")
                    .font(LAFont.body, weight: tabIndex == .profile ? .strong : .weak)
                    .foregroundStyle(tabIndex == .profile ? LAColor.Content.base : LAColor.Content.disabled)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                Rectangle().fill(tabIndex == .profile ? LAColor.Content.base : LAColor.Content.disabled).frame(height: tabIndex == .profile ? 2 : 1)
            }
            .onTapGesture { withAnimation { tabIndex = .profile } }
            VStack(spacing: 0) {
                HStack(spacing: 8) {
                    Text("취향 1")
                        .font(LAFont.body, weight: tabIndex == .category1 ? .strong : .weak)
                        .foregroundStyle(tabIndex == .category1 ? LAColor.Content.base : LAColor.Content.disabled)
                        .padding(.vertical, 16)
                    if let firstCategory = firstCategory {
                        LABadge(
                            text: firstCategory.displayValue,
                            textColor: LAColor.Content.additive,
                            backgroundColor: LAColor.BG.Fill.regular
                        )
                    }
                }
                .fixedSize()
                Rectangle().fill(tabIndex == .category1 ? LAColor.Content.base : LAColor.Content.disabled).frame(height: tabIndex == .category1 ? 2 : 1)
            }
            .onTapGesture { withAnimation { tabIndex = .category1 } }
            VStack(spacing: 0) {
                HStack(spacing: 8) {
                    Text("취향 2")
                        .font(LAFont.body, weight: tabIndex == .category2 ? .strong : .weak)
                        .foregroundStyle(tabIndex == .category2 ? LAColor.Content.base : LAColor.Content.disabled)
                        .padding(.vertical, 16)
                    if let secondCategory = secondCategory {
                        LABadge(
                            text: secondCategory.displayValue,
                            textColor: LAColor.Content.additive,
                            backgroundColor: LAColor.BG.Fill.regular
                        )
                    }
                }
                .fixedSize()
                Rectangle().fill(tabIndex == .category2 ? LAColor.Content.base : LAColor.Content.disabled).frame(height: tabIndex == .category2 ? 2 : 1)
            }
            .onTapGesture { withAnimation { tabIndex = .category2 } }
        }
        .padding(.horizontal, 8)
    }

    func profileSection() -> some View {
        ScrollView {
            LASectionHeader(text: "필수 프로필", font: LAFont.subhead, weight: .strong)
                .padding(.top, 6)
            LAInputField(
                config: .single(
                    isFocused: $emojiFocusState,
                    title: "나를 표현하는 이모티콘",
                    placeholder: "예시) 🥰",
                    text: $user.emoji,
                    subLabel: "키보드에서 이모티콘을 자유롭게 입력해주세요!"
                )
            )
            .onChange(of: user.emoji) { _, newValue in
                if let firstEmoji = newValue.filter(\.isEmoji).first {
                    user.emoji = String(firstEmoji)
                } else {
                    user.emoji = ""
                }
            }
            LAInputField(config: .single(isFocused: $nicknameFocusState, title: "닉네임", placeholder: "예시) 김숭실", text: $user.nickname))
            LAOptionPicker(config: .doubleVertical, contents: Gender.allCases, labelKeyPath: \.displayValue, subLabelKeyPath: nil, selection: $user.gender)
            YearPicker(selectedYear: $selectedYear) { str in
                dump("str")
                dump(str)
                dump(user.birthdate)
                user.birthdate = str
                dump(user.birthdate)
            }
            LADivider(size: .small)
            LASectionHeader(text: "선택 프로필", font: LAFont.subhead, weight: .strong)
            LAInputField(
                config: .single(
                    isFocused: $heightFocusState,
                    title: "키",
                    placeholder: "예시) 165cm",
                    text: $user.height
                )
            )
            LAInputField(
                config: .single(
                    isFocused: $departmentFocusState,
                    title: "학과 (혹은 학부)",
                    placeholder: "예시) 컴퓨터학부",
                    text: $user.department
                )
            )
        }
    }

    func category1Section() -> some View {
        ScrollView {
            LASectionHeader(text: "필수 프로필", font: LAFont.subhead, weight: .strong)
                .padding(.top, 6)
            LeftAlignedFlowLayout(xSpacing: 8, ySpacing: 8) {
                ForEach(allCategories) { category in
                    LAChip(
                        text: category.displayValue,
                        isSelected: firstCategory == category,
                        font: .callout,
                        weight: .weak,
                        color: LAColor.Semantic.Brand.strong,
                        backgroundColor: LAColor.Semantic.Brand.regular,
                        selectedFont: .callout,
                        selectedWeight: .strong,
                        selectedColor: LAColor.Content.elevated,
                        selectedBackgroundColor: LAColor.Semantic.Brand.strong
                    )
                    .onTapGesture {
                        if firstCategory == category {
                            firstCategory = nil
                            firstCategoryinterests.removeAll()
                        } else {
                            firstCategory = category
                            firstCategoryinterests.removeAll()
                        }
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)



            if let firstCategory = firstCategory {
                LASectionHeader(text: "자세한 취향 분류", font: LAFont.subhead, weight: .strong)

                LeftAlignedFlowLayout(xSpacing: 8, ySpacing: 8) {
                    ForEach(firstCategory.subCategories) { subCategory in
                        LAChip(
                            text: "#\(subCategory.displayValue)",
                            isSelected: firstCategoryinterests.contains { $0.subCategory.transferValue == subCategory.transferValue },
                            font: LAFont.callout,
                            weight: .weak,
                            color: LAColor.Content.disabled,
                            backgroundColor: LAColor.BG.Fill.regular,
                            selectedFont: .callout,
                            selectedWeight: .strong,
                            selectedColor: LAColor.Content.inverted,
                            selectedBackgroundColor: LAColor.BG.Fill.inverted
                        )
                        .onTapGesture {
                            withAnimation {
                                if firstCategoryinterests.contains(where: { $0.subCategory.transferValue == subCategory.transferValue }) {
                                    firstCategoryinterests.removeAll { $0.subCategory.transferValue == subCategory.transferValue }
                                } else {
                                    if firstCategoryinterests.count >= 2 { return }
                                    firstCategoryinterests.append(.init(category: firstCategory, subCategory: subCategory))
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
            }

            if !firstCategoryinterests.isEmpty {
                LADivider(size: .small)

                LASectionHeader(
                    text: "취향 해시태그",
                    font: .subhead,
                    weight: .strong,
                    subTitleConfig: .init(
                        text: "10자 이내로 작성해주세요",
                        font: .footnote,
                        weight: .weak
                    )
                )

                ForEach(firstCategoryinterests.indices, id: \.self) { interestIdx in
                    LADivider(size: .small)
                    LASectionHeader(
                        text: firstCategoryinterests[interestIdx].subCategory.displayValue,
                        font: .footnote,
                        weight: .weak
                    )
                    LeftAlignedFlowLayout(xSpacing: 8, ySpacing: 8) {
                        ForEach(firstCategoryinterests[interestIdx].hashtags.indices, id: \.self) { hashtagIdx in
                            LAInputChip(
                                config: .existing(
                                    text: $firstCategoryinterests[interestIdx].hashtags[hashtagIdx],
                                    onDelete: {
                                        firstCategoryinterests[interestIdx].hashtags.remove(at: hashtagIdx)
                                    }
                                )
                            )
                        }
                        if firstCategoryinterests[interestIdx].hashtags.count < 2 {
                            LAInputChip(
                                config: .input(
                                    text: $firstCategoryinterests[interestIdx].subCategory.inputText,
                                    placeholder: "#해시태그를_입력해주세요",
                                    onSubmit: {
                                        firstCategoryinterests[interestIdx].hashtags.append(firstCategoryinterests[interestIdx].subCategory.inputText)
                                        firstCategoryinterests[interestIdx].subCategory.inputText = ""
                                    }
                                )
                            )
                            .onChange(of: firstCategoryinterests[interestIdx].subCategory.inputText) { _, newValue in
                                if newValue.count > 10 { firstCategoryinterests[interestIdx].subCategory.inputText = String(newValue.prefix(10)) }
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                }
            }
        }
    }
    func category2Section() -> some View {
        ScrollView {
            LASectionHeader(text: "필수 프로필", font: LAFont.subhead, weight: .strong)
                .padding(.top, 6)
            LeftAlignedFlowLayout(xSpacing: 8, ySpacing: 8) {
                ForEach(allCategories) { category in
                    LAChip(
                        text: category.displayValue,
                        isSelected: secondCategory == category,
                        font: .callout,
                        weight: .weak,
                        color: LAColor.Semantic.Brand.strong,
                        backgroundColor: LAColor.Semantic.Brand.regular,
                        selectedFont: .callout,
                        selectedWeight: .strong,
                        selectedColor: LAColor.Content.elevated,
                        selectedBackgroundColor: LAColor.Semantic.Brand.strong
                    )
                    .onTapGesture {
                        if secondCategory == category {
                            secondCategory = nil
                            secondCategoryinterests.removeAll()
                        } else {
                            secondCategory = category
                            secondCategoryinterests.removeAll()
                        }
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)



            if let secondCategory = secondCategory {
                LASectionHeader(text: "자세한 취향 분류", font: LAFont.subhead, weight: .strong)

                LeftAlignedFlowLayout(xSpacing: 8, ySpacing: 8) {
                    ForEach(secondCategory.subCategories) { subCategory in
                        LAChip(
                            text: "#\(subCategory.displayValue)",
                            isSelected: secondCategoryinterests.contains { $0.subCategory.transferValue == subCategory.transferValue },
                            font: LAFont.callout,
                            weight: .weak,
                            color: LAColor.Content.disabled,
                            backgroundColor: LAColor.BG.Fill.regular,
                            selectedFont: .callout,
                            selectedWeight: .strong,
                            selectedColor: LAColor.Content.inverted,
                            selectedBackgroundColor: LAColor.BG.Fill.inverted
                        )
                        .onTapGesture {
                            withAnimation {
                                if secondCategoryinterests.contains(where: { $0.subCategory.transferValue == subCategory.transferValue }) {
                                    secondCategoryinterests.removeAll { $0.subCategory.transferValue == subCategory.transferValue }
                                } else {
                                    if secondCategoryinterests.count >= 2 { return }
                                    secondCategoryinterests.append(.init(category: secondCategory, subCategory: subCategory))
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
            }

            if !secondCategoryinterests.isEmpty {
                LADivider(size: .small)

                LASectionHeader(
                    text: "취향 해시태그",
                    font: .subhead,
                    weight: .strong,
                    subTitleConfig: .init(
                        text: "10자 이내로 작성해주세요",
                        font: .footnote,
                        weight: .weak
                    )
                )

                ForEach(secondCategoryinterests.indices, id: \.self) { interestIdx in
                    LADivider(size: .small)
                    LASectionHeader(
                        text: secondCategoryinterests[interestIdx].subCategory.displayValue,
                        font: .footnote,
                        weight: .weak
                    )
                    LeftAlignedFlowLayout(xSpacing: 8, ySpacing: 8) {
                        ForEach(secondCategoryinterests[interestIdx].hashtags.indices, id: \.self) { hashtagIdx in
                            LAInputChip(
                                config: .existing(
                                    text: $secondCategoryinterests[interestIdx].hashtags[hashtagIdx],
                                    onDelete: {
                                        secondCategoryinterests[interestIdx].hashtags.remove(at: hashtagIdx)
                                    }
                                )
                            )
                        }
                        if secondCategoryinterests[interestIdx].hashtags.count < 2 {
                            LAInputChip(
                                config: .input(
                                    text: $secondCategoryinterests[interestIdx].subCategory.inputText,
                                    placeholder: "#해시태그를_입력해주세요",
                                    onSubmit: {
                                        secondCategoryinterests[interestIdx].hashtags.append(secondCategoryinterests[interestIdx].subCategory.inputText)
                                        secondCategoryinterests[interestIdx].subCategory.inputText = ""
                                    }
                                )
                            )
                            .onChange(of: secondCategoryinterests[interestIdx].subCategory.inputText) { _, newValue in
                                if newValue.count > 10 { secondCategoryinterests[interestIdx].subCategory.inputText = String(newValue.prefix(10)) }
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}

extension ModifyView {
    private func modifyUser() {
        user.interests = firstCategoryinterests + secondCategoryinterests
        var newUser = user
        Task {
            do {
                guard let gender = user.gender?.rawValue else { return }
                let birthdate = user.birthdate.count <= 4 ? "\(user.birthdate)-01-01" : user.birthdate
                newUser.birthdate = birthdate
                dump(try await NetworkService.patchUser(
                    .init(
                        nickname: user.nickname,
                        emoji: user.emoji,
                        gender: gender,
                        birthdate: birthdate,
                        height: user.height.parseHeight(),
                        department: user.department
                    )
                ))
                dump(try await NetworkService.putInterest(user.interests.compactMap { $0.updateRequestDTO }))

                await MainActor.run {
                    appStore.user = newUser
                    appCoordinator.pop()
                }
            } catch {}
        }
    }
}

private struct YearPicker: View {
    @Binding var selectedYear: String?
    let action: (String) -> Void

    private let years: [String] = {
        let current = Calendar.current.component(.year, from: Date())
        return Array(1900...current)
                    .compactMap { String($0) }
                    .reversed()
    }()


    var body: some View {
        HStack(spacing: 8) {
            Menu {
                ForEach(years, id: \.self) { year in
                    Button {
                        selectedYear = year
                        action(year)
                    } label: {
                        Text("\(String(year))년")
                    }
                }
            } label: {
                HStack(spacing: 8) {
                    Group {
                        if let selectedYear = selectedYear {
                            Text("\(String(selectedYear))년")
                        } else {
                            Text("연도")
                        }
                    }
                    .font(LAFont.body, weight: .regular)
                    .foregroundStyle(LAColor.Content.base)
                    Spacer()
                    Image(.arrowDown)
                        .renderingMode(.template)
                        .foregroundStyle(LAColor.Content.assistive)
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 12)
                .background(LAColor.BG.Fill.regular)
                .background(LAStyle.Blur.ultraThin)
                .clipShape(.rect(cornerRadius: 12))
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}
