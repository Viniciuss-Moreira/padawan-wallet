/*
 * Copyright 2020-2025 thunderbiscuit and contributors.
 * Use of this source code is governed by the Apache 2.0 license that can be found in the ./LICENSE file.
 */

package com.coyotebitcoin.padawanwallet.presentation.ui.components

import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Devices
import androidx.compose.ui.tooling.preview.Preview
import com.composables.core.Icon
import com.composables.icons.lucide.ArrowLeft
import com.composables.icons.lucide.Lucide
import com.coyotebitcoin.padawanwallet.R
import com.coyotebitcoin.padawanwallet.domain.settings.PadawanColorTheme
import com.coyotebitcoin.padawanwallet.presentation.theme.PadawanTheme

private const val TAG = "PadawanAppBar"

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PadawanAppBar(
    title: String,
    onClick: () -> Unit,
    color: Color = Color.Transparent
) {
    CenterAlignedTopAppBar(
        title = {
            Text(
                text = title,
                fontWeight = FontWeight.Bold
            )
        },
        navigationIcon = {
            IconButton(onClick = onClick) {
                Icon(
                    imageVector = Lucide.ArrowLeft,
                    contentDescription = stringResource(id = R.string.back_icon),
                    tint = Color.Black
                )
            }
        },
        colors = TopAppBarDefaults.topAppBarColors(
            containerColor = color
        )
    )
}

@Preview(device = Devices.PIXEL_7, showBackground = true)
@Composable
internal fun PreviewPadawanAppBar() {
    PadawanTheme(PadawanColorTheme.TATOOINE_DESERT) {
        PadawanAppBar(
            title = "Preview App Bar",
            onClick = { }
        )
    }
}
