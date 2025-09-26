/*
 * Copyright 2020-2025 thunderbiscuit and contributors.
 * Use of this source code is governed by the Apache 2.0 license that can be found in the ./LICENSE file.
 */

package com.coyotebitcoin.padawanwallet.presentation.ui.screens.wallet

import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.selection.SelectionContainer
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.Scaffold
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Alignment.Companion.BottomCenter
import androidx.compose.ui.Alignment.Companion.Center
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.ImageBitmap
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.composables.icons.lucide.ClipboardCopy
import com.composables.icons.lucide.Lucide
import com.coyotebitcoin.padawanwallet.R
import com.coyotebitcoin.padawanwallet.domain.utils.QrUiState
import com.coyotebitcoin.padawanwallet.domain.utils.addressToQR
import com.coyotebitcoin.padawanwallet.presentation.theme.LocalPadawanColors
import com.coyotebitcoin.padawanwallet.presentation.theme.PadawanColorsTatooineDesert
import com.coyotebitcoin.padawanwallet.presentation.theme.ShareTechMono
import com.coyotebitcoin.padawanwallet.presentation.theme.neuBrutalismShadow
import com.coyotebitcoin.padawanwallet.presentation.ui.components.LoadingAnimation
import com.coyotebitcoin.padawanwallet.presentation.ui.components.PadawanAppBar
import com.coyotebitcoin.padawanwallet.presentation.ui.components.standardBorder
import com.coyotebitcoin.padawanwallet.presentation.utils.ScreenSizeWidth
import com.coyotebitcoin.padawanwallet.presentation.utils.copyToClipboard
import com.coyotebitcoin.padawanwallet.presentation.utils.getScreenSizeWidth
import com.coyotebitcoin.padawanwallet.presentation.utils.logRecomposition
import com.coyotebitcoin.padawanwallet.presentation.viewmodels.mvi.ReceiveScreenAction
import com.coyotebitcoin.padawanwallet.presentation.viewmodels.mvi.ReceiveScreenState
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

private const val TAG = "ReceiveScreen"

@Composable
internal fun ReceiveScreen(
    state: ReceiveScreenState,
    onAction: (ReceiveScreenAction) -> Unit,
    onBack: () -> Unit,
) {
    logRecomposition(TAG)
    val colors = LocalPadawanColors.current
    val snackbarHostState = remember { SnackbarHostState() }
    var qr by remember { mutableStateOf<ImageBitmap?>(null) }

    LaunchedEffect(state.address) {
        if (state.bip21Uri != null) {
            withContext(Dispatchers.IO) {
                qr = addressToQR(state.bip21Uri)
            }
        }
    }

    val qrCodeSize = when (getScreenSizeWidth(LocalConfiguration.current.screenWidthDp)) {
        ScreenSizeWidth.Small -> 220.dp
        ScreenSizeWidth.Phone -> 340.dp
    }

    val context = LocalContext.current
    val scope = rememberCoroutineScope()

    Scaffold(
        topBar = {
            PadawanAppBar(
                title = stringResource(R.string.receive_bitcoin),
                onClick = { onBack() }
            )
        },
        snackbarHost = { SnackbarHost(snackbarHostState) }
    ) { scaffoldPadding ->
        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(colors.background)
                .padding(scaffoldPadding)
        ) {
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center,
                modifier = Modifier
                    .align(Center)
                    .padding(bottom = 120.dp)
            ) {
                if (state.qrState == QrUiState.Loading) {
                    LoadingAnimation(circleColor = colors.accent2, circleSize = 38.dp)
                } else if (state.qrState == QrUiState.QR && state.bip21Uri != null && state.address != null) {
                    qr?.let {
                        Image(
                            bitmap = it,
                            contentDescription = stringResource(R.string.qr_code),
                            Modifier
                                .size(qrCodeSize)
                                .clip(RoundedCornerShape(16.dp))
                                .clickable {
                                    copyToClipboard(
                                        state.address,
                                        context,
                                        scope,
                                        snackbarHostState,
                                        null
                                    )
                                }
                        )
                        Spacer(Modifier.height(16.dp))
                        Box(
                            modifier = Modifier.padding(horizontal = 16.dp)
                        ) {
                            SelectionContainer {
                                Text(
                                    modifier = Modifier
                                        .background(
                                            color = colors.background,
                                            shape = RoundedCornerShape(16.dp)
                                        )
                                        .clickable {
                                            copyToClipboard(
                                                state.address,
                                                context,
                                                scope,
                                                snackbarHostState,
                                                null,
                                            )
                                        }
                                        .padding(12.dp),
                                    text = state.address.chunked(4).joinToString(" "),
                                    fontFamily = ShareTechMono,
                                    fontSize = 18.sp
                                )
                            }
                            Icon(
                                Lucide.ClipboardCopy,
                                tint = Color.Black,
                                contentDescription = "Copy to clipboard",
                                modifier = Modifier
                                    .padding(8.dp)
                                    .size(20.dp)
                                    .align(Alignment.BottomEnd)
                            )
                        }
                    }
                }
            }

            Button(
                onClick = { onAction(ReceiveScreenAction.UpdateAddress) },
                colors = ButtonDefaults.buttonColors(containerColor = PadawanColorsTatooineDesert.accent2),
                shape = RoundedCornerShape(20.dp),
                border = standardBorder,
                modifier = Modifier
                    .height(100.dp)
                    .fillMaxWidth(0.9f)
                    .padding(vertical = 8.dp, horizontal = 8.dp)
                    .neuBrutalismShadow()
                    .align(BottomCenter)
            ) {
                Text(
                    text = stringResource(R.string.generate_a_new_address),
                )
            }
        }
    }
}

// @Preview(device = Devices.PIXEL_4, showBackground = true)
// @Composable
// internal fun PreviewIntroScreen() {
//     PadawanTheme {
//         ReceiveScreen(
//             rememberNavController(),
//             WalletViewModel(),
//         )
//     }
// }
