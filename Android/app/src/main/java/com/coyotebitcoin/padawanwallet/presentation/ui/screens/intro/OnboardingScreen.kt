/*
 * Copyright 2020-2025 thunderbiscuit and contributors.
 * Use of this source code is governed by the Apache 2.0 license that can be found in the ./LICENSE file.
 */

package com.coyotebitcoin.padawanwallet.presentation.ui.screens.intro

import android.util.Log
import androidx.compose.foundation.Image
import androidx.compose.foundation.ScrollState
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Devices
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.coyotebitcoin.padawanwallet.R
import com.coyotebitcoin.padawanwallet.domain.utils.WalletCreateType
import com.coyotebitcoin.padawanwallet.presentation.navigation.SecondaryDestinations
import com.coyotebitcoin.padawanwallet.presentation.theme.LocalPadawanColors
import com.coyotebitcoin.padawanwallet.presentation.theme.PadawanTheme
import com.coyotebitcoin.padawanwallet.presentation.theme.PadawanTypography
import com.coyotebitcoin.padawanwallet.presentation.theme.neuBrutalismShadow
import com.coyotebitcoin.padawanwallet.presentation.ui.components.standardBorder
import com.coyotebitcoin.padawanwallet.presentation.utils.ScreenSizeHeight
import com.coyotebitcoin.padawanwallet.presentation.utils.getScreenSizeHeight

private const val TAG = "OnboardingScreen"

@Composable
internal fun OnboardingScreen(
    onBuildWallet: (WalletCreateType) -> Unit,
    onCreateNav: (SecondaryDestinations) -> Unit,
    onRecoverNav: () -> Unit,
) {
    val screenSizeHeight: ScreenSizeHeight = getScreenSizeHeight(LocalConfiguration.current.screenHeightDp)
    val pageScrollState: ScrollState = rememberScrollState()

    if (screenSizeHeight == ScreenSizeHeight.Small) {
        SmallOnboarding(
            pageScrollState = pageScrollState,
            onBuildWallet = onBuildWallet,
            onCreateNav = onCreateNav,
            onRecoverNav = onRecoverNav
        )
    } else {
        PhoneOnboarding(
            pageScrollState = pageScrollState,
            onBuildWallet = onBuildWallet,
            onCreateNav = onCreateNav,
            onRecoverNav = onRecoverNav
        )
    }
}

@Composable
internal fun SmallOnboarding(
    pageScrollState: ScrollState,
    onBuildWallet: (WalletCreateType) -> Unit,
    onCreateNav: (SecondaryDestinations) -> Unit,
    onRecoverNav: () -> Unit,
) {
    val colors = LocalPadawanColors.current
    Column(
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = Modifier
            .fillMaxSize()
            .background(colors.background)
            .verticalScroll(pageScrollState)
    ) {
        Image(
            painter = painterResource(id = R.drawable.ic_padawan_colour_foreground),
            contentDescription = stringResource(R.string.padawan_logo),
            Modifier.size(140.dp)
        )
        Text(
            text = stringResource(R.string.padawan_wallet),
            style = PadawanTypography.headlineLarge,
            fontSize = 34.sp,
            color = colors.text,
            modifier = Modifier.padding(start = 24.dp, end = 24.dp, bottom = 8.dp)
        )

        Text(
            stringResource(R.string.welcome_statement),
            style = PadawanTypography.bodyMedium,
            fontSize = 16.sp,
            color = colors.text,
            modifier = Modifier.padding(start = 24.dp, end = 24.dp, bottom = 12.dp)
        )

        Button(
            onClick = {
                Log.i(TAG, "Creating a wallet")
                onBuildWallet(WalletCreateType.FROMSCRATCH)
                onCreateNav(SecondaryDestinations.CoreScreens)
            },
            colors = ButtonDefaults.buttonColors(
                containerColor = colors.accent2,
            ),
            shape = RoundedCornerShape(20.dp),
            border = standardBorder,
            modifier = Modifier
                .padding(top = 4.dp, start = 4.dp, end = 4.dp, bottom = 4.dp)
                .neuBrutalismShadow()
                .height(90.dp)
                .width(240.dp)
                .align(Alignment.CenterHorizontally)
        ) {
            Text(
                text = stringResource(R.string.create_a_wallet),
            )
        }

        Button(
            onClick = { onRecoverNav() },
            colors = ButtonDefaults.buttonColors(containerColor = colors.accent2),
            shape = RoundedCornerShape(20.dp),
            border = standardBorder,
            modifier = Modifier
                .padding(top = 4.dp, start = 4.dp, end = 4.dp, bottom = 4.dp)
                .neuBrutalismShadow()
                .height(90.dp)
                .width(240.dp)
                .align(Alignment.CenterHorizontally)
        ) {
            Text(
                text = stringResource(id = R.string.already_have_a_wallet),
                modifier = Modifier.fillMaxWidth(),
                textAlign = TextAlign.Center,
                color = colors.text
            )
        }
    }
}

@Composable
internal fun PhoneOnboarding(
    pageScrollState: ScrollState,
    onBuildWallet: (WalletCreateType) -> Unit,
    onCreateNav: (SecondaryDestinations) -> Unit,
    onRecoverNav: () -> Unit,
) {
    val colors = LocalPadawanColors.current

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(colors.background)
            .verticalScroll(pageScrollState)
    ) {
        Column(
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally,
            modifier = Modifier
                .fillMaxWidth()
                .padding(top = 60.dp)
        ) {
            Image(
                painter = painterResource(id = R.drawable.ic_padawan_colour_foreground),
                contentDescription = stringResource(id = R.string.padawan_logo),
                Modifier.size(140.dp)
            )
            Text(
                text = stringResource(R.string.padawan_wallet),
                style = PadawanTypography.headlineLarge,
                fontSize = 32.sp,
                color = colors.text,
                modifier = Modifier
                    .padding(start = 24.dp, end = 24.dp, bottom = 32.dp)
            )
        }

        Column(
            horizontalAlignment = Alignment.Start,
            modifier = Modifier.fillMaxSize()
        ) {
            Text(
                stringResource(R.string.welcome_statement),
                style = PadawanTypography.bodyMedium,
                fontSize = 18.sp,
                color = colors.textLight,
                modifier = Modifier
                    .padding(start = 24.dp, end = 24.dp, bottom = 12.dp)
            )

            Spacer(modifier = Modifier.weight(1f))

            Button(
                onClick = {
                    Log.i(TAG, "Creating a wallet")
                    onBuildWallet(WalletCreateType.FROMSCRATCH)
                    onCreateNav(SecondaryDestinations.CoreScreens)
                },
                colors = ButtonDefaults.buttonColors(containerColor = colors.accent2),
                shape = RoundedCornerShape(20.dp),
                border = standardBorder,
                modifier = Modifier
                    .padding(top = 4.dp, start = 4.dp, end = 4.dp, bottom = 4.dp)
                    .neuBrutalismShadow()
                    .height(90.dp)
                    .width(300.dp)
                    .align(Alignment.CenterHorizontally)
            ) {
                Row(
                    verticalAlignment = Alignment.CenterVertically,
                    modifier = Modifier.padding(vertical = 4.dp)
                ) {
                    Text(
                        text = stringResource(R.string.create_a_wallet),
                        color = colors.text
                    )
                }
            }

            Button(
                onClick = { onRecoverNav() },
                colors = ButtonDefaults.buttonColors(containerColor = colors.accent2),
                shape = RoundedCornerShape(20.dp),
                border = standardBorder,
                modifier = Modifier
                    .padding(top = 4.dp, start = 4.dp, end = 4.dp, bottom = 32.dp)
                    .neuBrutalismShadow()
                    .height(90.dp)
                    .width(300.dp)
                    .align(Alignment.CenterHorizontally)
            ) {
                Text(
                    text = stringResource(id = R.string.already_have_a_wallet),
                    modifier = Modifier.fillMaxWidth(),
                    textAlign = TextAlign.Center,
                    color = colors.text
                )
            }
        }
    }
}

@Preview(device = Devices.PIXEL_7, showBackground = true)
@Preview(widthDp = 320, showBackground = true)
@Composable
internal fun PreviewOnboardingScreen() {
    PadawanTheme {
        OnboardingScreen(
            onBuildWallet = {},
            onCreateNav = {},
            onRecoverNav = {}
        )
    }
}
