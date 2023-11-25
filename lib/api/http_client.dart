import 'dart:developer';

import 'package:http/http.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_exception.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import '../settings.dart';

class OAuthClient extends OAuth2Client {
  OAuthClient()
      : super(
          customUriScheme: kCustomUriScheme,
          redirectUri: "$kCustomUriScheme:/oauth2",
          tokenUrl:
              "https://auth.umom.pro/realms/umom-realm/protocol/openid-connect/token",
          authorizeUrl:
              "https://auth.umom.pro/realms/umom-realm/protocol/openid-connect/auth",
        );
}

class HttpClient extends OAuth2Helper {
  HttpClient(super.client)
      : super(clientId: "umom-client", scopes: ["openid", "profile"]);

  @override
  Future<Response> get(String url,
          {Map<String, String>? headers, Client? httpClient}) =>
      super.get(kServerUrl + url, headers: headers, httpClient: httpClient);

  @override
  Future<Response> post(String url,
          {Map<String, String>? headers, body, Client? httpClient}) =>
      super.post(kServerUrl + url,
          headers: headers, body: body, httpClient: httpClient);

  @override
  Future<Response> delete(String url,
          {Map<String, String>? headers, Client? httpClient}) =>
      super.delete(kServerUrl + url, headers: headers, httpClient: httpClient);

  @override
  Future<Response> put(String url,
          {Map<String, String>? headers, body, Client? httpClient}) =>
      super.put(kServerUrl + url,
          headers: headers, body: body, httpClient: httpClient);

  @override
  Future<Response> patch(String url,
      {Map<String, String>? headers, body, Client? httpClient}) {
    return super.patch(kServerUrl + url,
        headers: headers, body: body, httpClient: httpClient);
  }

  @override
  Future<AccessTokenResponse> refreshToken(
      AccessTokenResponse curTknResp) async {
    AccessTokenResponse? tknResp;
    var refreshToken = curTknResp.refreshToken!;
    try {
      tknResp = await client.refreshToken(refreshToken,
          clientId: clientId,
          clientSecret: clientSecret,
          scopes: curTknResp.scope);
    } catch (_) {
      return await fetchToken();
    }

    if (tknResp.isValid()) {
      //If the response doesn't contain a refresh token, keep using the current one
      if (!tknResp.hasRefreshToken()) {
        tknResp.refreshToken = refreshToken;
      }

      await tokenStorage.addToken(tknResp);
    } else {
      if (tknResp.error == 'invalid_grant' ||
          tknResp.error == "invalid_token") {
        //The refresh token is expired too
        await tokenStorage.deleteToken(["openid", "profile"]);
        //Fetch another access token
        tknResp = await getToken();
      } else {
        throw OAuth2Exception(tknResp.error ?? 'Error',
            errorDescription: tknResp.errorDescription);
      }
    }

    return tknResp!;
  }
}
