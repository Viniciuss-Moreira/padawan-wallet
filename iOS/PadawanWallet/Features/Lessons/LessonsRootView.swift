/*
 * Copyright 2020-2025 thunderbiscuit and contributors.
 * Use of this source code is governed by the Apache 2.0 license that can be found in the ./LICENSE file.
 */

import Foundation
import SwiftUI

struct LessonElement {
    let type: ElementType
    let resourceKey: String
}

struct LessonContent {
    let elements: [LessonElement]
}

struct Lesson: Identifiable {
    let id = UUID()
    let title: String
    let isHighlighted: Bool
    let content: LessonContent?
}

struct LessonSection {
    let title: String
    let lessons: [Lesson]
}

enum ElementType {
    case title
    case subtitle
    case paragraph
    case resource
}

struct LessonsRootView: View {
    @Environment(\.padawanColors) private var colors
    @EnvironmentObject var languageManager: LanguageManager
    
    let lesson1Content = LessonContent(
        elements: [
            LessonElement(type: .title, resourceKey: "l1_title"),
            LessonElement(type: .paragraph, resourceKey: "l1_p1"),
            LessonElement(type: .paragraph, resourceKey: "l1_p2"),
            LessonElement(type: .subtitle, resourceKey: "l1_h2"),
            LessonElement(type: .paragraph, resourceKey: "l1_p3"),
            LessonElement(type: .paragraph, resourceKey: "l1_p4"),
            LessonElement(type: .subtitle, resourceKey: "l1_h3"),
            LessonElement(type: .paragraph, resourceKey: "l1_p5"),
            LessonElement(type: .paragraph, resourceKey: "l1_p6"),
            LessonElement(type: .subtitle, resourceKey: "l1_h4"),
            LessonElement(type: .paragraph, resourceKey: "l1_p7"),
            LessonElement(type: .paragraph, resourceKey: "l1_p8"),
            LessonElement(type: .paragraph, resourceKey: "l1_p9")
        ]
    )

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(languageManager.localizedString("padawan_journey"))
                            .font(.title)
                            .bold()
                            .foregroundColor(colors.text)
                        Text(languageManager.localizedString("padawan_journey_subtitle"))
                            .foregroundColor(colors.textLight)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text(languageManager.localizedString("getting_started"))
                            .font(.headline)
                            .bold()
                            .foregroundColor(colors.text)
                        
                        NavigationLink(destination: LessonDetailScreen(
                            lesson: Lesson(
                                title: languageManager.localizedString("l1_title"),
                                isHighlighted: false,
                                content: lesson1Content
                            )
                        )) {
                            LessonRow(lesson: Lesson(
                                title: languageManager.localizedString("l1_title"),
                                isHighlighted: false,
                                content: lesson1Content
                            ))
                        }
                        
                        NavigationLink(destination: LessonDetailScreen(
                            lesson: Lesson(
                                title: languageManager.localizedString("l2_title"),
                                isHighlighted: true,
                                content: nil
                            )
                        )) {
                            LessonRow(lesson: Lesson(
                                title: languageManager.localizedString("l2_title"),
                                isHighlighted: true,
                                content: nil
                            ))
                        }
                        
                        NavigationLink(destination: LessonDetailScreen(
                            lesson: Lesson(
                                title: languageManager.localizedString("l3_title"),
                                isHighlighted: false,
                                content: nil
                            )
                        )) {
                            LessonRow(lesson: Lesson(
                                title: languageManager.localizedString("l3_title"),
                                isHighlighted: false,
                                content: nil
                            ))
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text(languageManager.localizedString("transactions"))
                            .font(.headline)
                            .bold()
                            .foregroundColor(colors.text)
                        
                        NavigationLink(destination: LessonDetailScreen(
                            lesson: Lesson(
                                title: languageManager.localizedString("l4_title"),
                                isHighlighted: true,
                                content: nil
                            )
                        )) {
                            LessonRow(lesson: Lesson(
                                title: languageManager.localizedString("l4_title"),
                                isHighlighted: true,
                                content: nil
                            ))
                        }
                        
                        NavigationLink(destination: LessonDetailScreen(
                            lesson: Lesson(
                                title: languageManager.localizedString("l5_title"),
                                isHighlighted: false,
                                content: nil
                            )
                        )) {
                            LessonRow(lesson: Lesson(
                                title: languageManager.localizedString("l5_title"),
                                isHighlighted: false,
                                content: nil
                            ))
                        }
                        
                        NavigationLink(destination: LessonDetailScreen(
                            lesson: Lesson(
                                title: languageManager.localizedString("l6_title"),
                                isHighlighted: false,
                                content: nil
                            )
                        )) {
                            LessonRow(lesson: Lesson(
                                title: languageManager.localizedString("l6_title"),
                                isHighlighted: false,
                                content: nil
                            ))
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text(languageManager.localizedString("advanced"))
                            .font(.headline)
                            .bold()
                            .foregroundColor(colors.text)
                        
                        NavigationLink(destination: LessonDetailScreen(
                            lesson: Lesson(
                                title: languageManager.localizedString("l7_title"),
                                isHighlighted: false,
                                content: nil
                            )
                        )) {
                            LessonRow(lesson: Lesson(
                                title: languageManager.localizedString("l7_title"),
                                isHighlighted: false,
                                content: nil
                            ))
                        }
                        
                        NavigationLink(destination: LessonDetailScreen(
                            lesson: Lesson(
                                title: languageManager.localizedString("l8_title"),
                                isHighlighted: false,
                                content: nil
                            )
                        )) {
                            LessonRow(lesson: Lesson(
                                title: languageManager.localizedString("l8_title"),
                                isHighlighted: false,
                                content: nil
                            ))
                        }
                        
                        NavigationLink(destination: LessonDetailScreen(
                            lesson: Lesson(
                                title: languageManager.localizedString("l9_title"),
                                isHighlighted: false,
                                content: nil
                            )
                        )) {
                            LessonRow(lesson: Lesson(
                                title: languageManager.localizedString("l9_title"),
                                isHighlighted: false,
                                content: nil
                            ))
                        }
                    }
                }
                .padding()
            }
            .background(colors.background)
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}
