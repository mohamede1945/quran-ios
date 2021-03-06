//
//  TranslationVerseTextRetrieval.swift
//  Quran
//
//  Created by Mohamed Afifi on 4/4/17.
//
//  Quran for iOS is a Quran reading application for iOS.
//  Copyright (C) 2017  Quran.com
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

import PromiseKit

class TranslationVerseTextRetrieval: Interactor {

    func execute(_ input: QuranShareData) -> Promise<String> {
        guard let cell = input.cell as? QuranTranslationCollectionPageCollectionViewCell else {
            fatalError("TranslationVerseTextRetrieval works with QuranTranslationCollectionPageCollectionViewCell")
        }

        guard let page = cell.translationPage else {
            return Promise(value: "")
        }

        guard let verse = page.verses.first(where: { $0.ayah == input.ayah }) else {
            return Promise(value: "")
        }

        var components: [String] = []

        // add arabic text
        components.append(verse.arabicText)

        for translationText in verse.translations {
            components.append("\(translationText.translation.translationName):\n\(translationText.text)")
        }

        let text = components.joined(separator: "\n\n")
        return Promise(value: text)
    }
}
