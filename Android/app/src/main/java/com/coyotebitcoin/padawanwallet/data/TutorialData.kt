/*
 * Copyright 2020-2025 thunderbiscuit and contributors.
 * Use of this source code is governed by the Apache 2.0 license that can be found in the ./LICENSE file.
 */

package com.coyotebitcoin.padawanwallet.data

import com.coyotebitcoin.padawanwallet.R

data class LessonData(val chapterNum: Int, val appBarTitleResourceId: Int, val pages: List<Page>)
data class ChapterElement(val elementType: ElementType, val resourceId: Int)
typealias Page = List<ChapterElement>

enum class ElementType {
    TITLE,
    SUBTITLE,
    BODY,
    RESOURCE,
}

val chapter1: List<Page> = listOf(
    listOf(
        ChapterElement(ElementType.TITLE, R.string.l1_title),
        ChapterElement(ElementType.BODY, R.string.l1_p1),
        ChapterElement(ElementType.BODY, R.string.l1_p2),
    ),
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l1_h2),
        ChapterElement(ElementType.BODY, R.string.l1_p3),
        ChapterElement(ElementType.BODY, R.string.l1_p4),
    ),
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l1_h3),
        ChapterElement(ElementType.BODY, R.string.l1_p5),
        ChapterElement(ElementType.BODY, R.string.l1_p6),
    ),
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l1_h4),
        ChapterElement(ElementType.BODY, R.string.l1_p7),
        ChapterElement(ElementType.BODY, R.string.l1_p8),
        ChapterElement(ElementType.BODY, R.string.l1_p9),
    ),
)

val chapter2: List<Page> = listOf(
    listOf(
        ChapterElement(ElementType.TITLE, R.string.l2_title),
        ChapterElement(ElementType.BODY, R.string.l2_p1),
        ChapterElement(ElementType.BODY, R.string.l2_p2),
        ChapterElement(ElementType.BODY, R.string.l2_p3),
        ChapterElement(ElementType.RESOURCE, R.drawable.address),
        ChapterElement(ElementType.BODY, R.string.l2_p4),
        ChapterElement(ElementType.BODY, R.string.l2_p5),
        ChapterElement(ElementType.RESOURCE, R.drawable.return_sats_faucet_address),
        ChapterElement(ElementType.BODY, R.string.l2_p6),
    ),
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l2_h1),
        ChapterElement(ElementType.BODY, R.string.l2_p7),
        ChapterElement(ElementType.BODY, R.string.l2_p8),
        ChapterElement(ElementType.BODY, R.string.l2_p9),
        ChapterElement(ElementType.BODY, R.string.l2_p10),
    ),
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l2_h2),
        ChapterElement(ElementType.BODY, R.string.l2_p11),
        ChapterElement(ElementType.BODY, R.string.l2_p12),
        ChapterElement(ElementType.BODY, R.string.l2_p13),
    ),
)

val chapter3: List<Page> = listOf(
    listOf(
        ChapterElement(ElementType.TITLE, R.string.l3_title),
        ChapterElement(ElementType.BODY, R.string.l3_p1),
        ChapterElement(ElementType.BODY, R.string.l3_p2),
    ),
)
val chapter4: List<Page> = listOf(
    listOf(
        ChapterElement(ElementType.TITLE, R.string.l4_title),
        ChapterElement(ElementType.BODY, R.string.l4_p1),
        ChapterElement(ElementType.BODY, R.string.l4_p2),
    ),
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l4_h1),
        ChapterElement(ElementType.BODY, R.string.l4_p3),
        ChapterElement(ElementType.BODY, R.string.l4_p4),
    ),
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l4_h2),
        ChapterElement(ElementType.BODY, R.string.l4_p5),
        ChapterElement(ElementType.BODY, R.string.l4_p6),
    ),
)

val chapter5: List<Page> = listOf(
    listOf(
        ChapterElement(ElementType.TITLE, R.string.l5_title),
        ChapterElement(ElementType.BODY, R.string.l5_p1),
        ChapterElement(ElementType.BODY, R.string.l5_p2),
    ),
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l5_h1),
        ChapterElement(ElementType.BODY, R.string.l5_p3),
        ChapterElement(ElementType.BODY, R.string.l5_p4),
    ),
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l5_h2),
        ChapterElement(ElementType.BODY, R.string.l5_p5),
    ),
)

val chapter6: List<Page> = listOf(
    listOf(
        ChapterElement(ElementType.TITLE, R.string.l6_title),
        ChapterElement(ElementType.BODY, R.string.l6_p1),
    ),
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l6_h1),
        ChapterElement(ElementType.BODY, R.string.l6_p3),
        ChapterElement(ElementType.BODY, R.string.l6_p4),
        ChapterElement(ElementType.RESOURCE, R.drawable.units),
    ),
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l6_h2),
        ChapterElement(ElementType.BODY, R.string.l6_p5),
        ChapterElement(ElementType.BODY, R.string.l6_p6),
        ChapterElement(ElementType.RESOURCE, R.drawable.bitcoin_units),
        ChapterElement(ElementType.BODY, R.string.l6_p7),
        ChapterElement(ElementType.RESOURCE, R.drawable.satoshi_units),
    ),
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l6_h3),
        ChapterElement(ElementType.BODY, R.string.l6_p8),
        ChapterElement(ElementType.BODY, R.string.l6_p9),
        ChapterElement(ElementType.BODY, R.string.l6_p10),
        ChapterElement(ElementType.BODY, R.string.l6_p11),
        ChapterElement(ElementType.BODY, R.string.l6_p12),
    ),
)

val chapter7: List<Page> = listOf(
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l7_title),
        ChapterElement(ElementType.BODY, R.string.l7_p1),
        ChapterElement(ElementType.BODY, R.string.l7_p2),
        ChapterElement(ElementType.BODY, R.string.l7_p3),
        ChapterElement(ElementType.BODY, R.string.l7_p4),
    ),
    listOf(
        ChapterElement(ElementType.TITLE, R.string.l7_h1),
        ChapterElement(ElementType.BODY, R.string.l7_p5),
        ChapterElement(ElementType.BODY, R.string.l7_p6),
        ChapterElement(ElementType.BODY, R.string.l7_p7),
    ),
)

val chapter8: List<Page> = listOf(
    listOf(
        ChapterElement(ElementType.TITLE, R.string.l8_title),
        ChapterElement(ElementType.BODY, R.string.l8_p1),
        ChapterElement(ElementType.BODY, R.string.l8_p2),
        ChapterElement(ElementType.BODY, R.string.l8_p3),
        ChapterElement(ElementType.BODY, R.string.l8_p4),
        ChapterElement(ElementType.BODY, R.string.l8_p5),
    ),
    listOf(
        ChapterElement(ElementType.TITLE, R.string.l8_h1),
        ChapterElement(ElementType.BODY, R.string.l8_p6),
        ChapterElement(ElementType.BODY, R.string.l8_p7),
        ChapterElement(ElementType.BODY, R.string.l8_p8),
    ),
)

val chapter9: List<Page> = listOf(
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l9_h1),
        ChapterElement(ElementType.BODY, R.string.l9_p1),
        ChapterElement(ElementType.BODY, R.string.l9_p2),
    ),
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l9_h2),
        ChapterElement(ElementType.BODY, R.string.l9_p3),
        ChapterElement(ElementType.BODY, R.string.l9_p4),
        ChapterElement(ElementType.BODY, R.string.l9_p5),
    ),
    listOf(
        ChapterElement(ElementType.SUBTITLE, R.string.l9_h3),
        ChapterElement(ElementType.BODY, R.string.l9_p6),
        ChapterElement(ElementType.BODY, R.string.l9_p7),
        ChapterElement(ElementType.BODY, R.string.l9_p8),
        ChapterElement(ElementType.BODY, R.string.l9_p9),
        ChapterElement(ElementType.BODY, R.string.l9_p10),
        ChapterElement(ElementType.BODY, R.string.l9_p11),
    ),
)

val allChapters = listOf(
    chapter1,
    chapter2,
    chapter3,
    chapter4,
    chapter5,
    chapter6,
    chapter7,
    chapter8,
    chapter9,
)

val allAppBarTitlesResourceId = listOf(
    R.string.l1_app_bar,
    R.string.l2_app_bar,
    R.string.l3_app_bar,
    R.string.l4_app_bar,
    R.string.l5_app_bar,
    R.string.l6_app_bar,
    R.string.l7_app_bar,
    R.string.l8_app_bar,
    R.string.l9_app_bar,
)
