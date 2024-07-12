//
//  DropDownButton.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 09/07/2024.
//

import SwiftUI

struct CellStatus {
    var zIndex: Double
    var isOpen: Bool
}

struct DropdownOption: Hashable {
    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }

    var key: String
    var val: String
}

struct DropdownOptionElement: View {
    var val: String
    var key: String
    var onSelect: ((_ key: String) -> Void)?

    var body: some View {
        Button(action: {
            if let onSelect = self.onSelect {
                onSelect(self.key)
            }
        }) {
            Text(self.val).font(.subheadline)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
    }
}

struct Dropdown: View {
    var options: [DropdownOption]
    var onSelect: ((_ key: String) -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(self.options, id: \.self) { option in
                DropdownOptionElement(val: option.val, key: option.key, onSelect: self.onSelect)
            }
        }

        .background(Color.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.accentColor, lineWidth: 1)
        )
    }
}

struct DropdownButton: View {
    @State var shouldShowDropdown = false
    @Binding var displayText: String
    var options: [DropdownOption]
    var onSelect: ((_ key: String) -> Void)?
    var onDropdownSelected: (() -> Void)?

    let buttonHeight: CGFloat = 30
    var body: some View {
        Button(action: {
            self.shouldShowDropdown.toggle()
            onDropdownSelected!()
        }) {
            HStack {
                Text(displayText)
                Image(systemName: self.shouldShowDropdown ? "chevron.up" : "chevron.down").font(.caption)
            }
        }
        .padding(.horizontal, 8)
        .cornerRadius(20)
        .frame(height: buttonHeight)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.accentColor, lineWidth: 1)
        )
        .overlay(
            VStack {
                if self.shouldShowDropdown {
                    Spacer(minLength: buttonHeight + 10)
                    Dropdown(options: self.options, onSelect: self.onSelect)
                }
            }, alignment: .topLeading
        )
        .background(
            RoundedRectangle(cornerRadius: 20).fill(Color.white)
        )
    }
}

struct DropdownButton_Previews: PreviewProvider {
    static let options = [
        DropdownOption(key: "week", val: "This week"), DropdownOption(key: "month", val: "This month"), DropdownOption(key: "year", val: "This year")
    ]

    static let onSelect = { key in
        print(key)
    }

    static var previews: some View {
        Group {
            VStack(alignment: .leading) {
                DropdownButton(
                    displayText: .constant("This month"),
                    options: options,
                    onSelect: onSelect
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .foregroundColor(Color.black)
        }
    }
}
