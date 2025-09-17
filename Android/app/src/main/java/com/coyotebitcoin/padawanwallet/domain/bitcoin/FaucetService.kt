/*
 * Copyright 2020-2025 thunderbiscuit and contributors.
 * Use of this source code is governed by the Apache 2.0 license that can be found in the ./LICENSE file.
 */

package com.coyotebitcoin.padawanwallet.domain.bitcoin

import io.ktor.client.HttpClient
import io.ktor.client.engine.cio.CIO
import io.ktor.client.plugins.auth.Auth
import io.ktor.client.plugins.auth.providers.BearerTokens
import io.ktor.client.plugins.auth.providers.bearer
import io.ktor.client.request.request
import io.ktor.client.request.setBody
import io.ktor.client.statement.HttpResponse
import io.ktor.content.TextContent
import io.ktor.http.ContentType
import io.ktor.http.HttpMethod
import io.ktor.utils.io.core.use
import kotlinx.coroutines.runBlocking

class FaucetService {
    fun callTatooineFaucet(
        address: String,
        faucetUrl: String,
        faucetToken: String,
    ): FaucetCall {
        val ktorClient = HttpClient(CIO) {
            install(Auth) {
                bearer {
                    loadTokens {
                        BearerTokens(faucetToken, "")
                    }
                }
            }
        }

        return ktorClient.use {
            try {
                val response: HttpResponse = runBlocking {
                    ktorClient.request(faucetUrl) {
                        method = HttpMethod.Post
                        setBody(TextContent(address, ContentType.Text.Plain))
                    }
                }

                when (response.status.value) {
                    200 -> FaucetCall.Success(
                        status = response.status.value,
                        description = response.status.description,
                    )

                    else -> FaucetCall.Error(
                        status = response.status.value,
                        description = response.status.description
                    )
                }
            } catch (exception: Exception) {
                FaucetCall.ExceptionThrown(exception = exception)
            }
        }
    }
}

sealed class FaucetCall {
    data class Success(val status: Int, val description: String) : FaucetCall()
    data class Error(val status: Int, val description: String) : FaucetCall()
    data class ExceptionThrown(val exception: Exception) : FaucetCall()
}
