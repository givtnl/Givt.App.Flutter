import 'dart:developer';

import 'package:givt_mobile_apps/services/local_user_service.dart';
import 'package:givt_mobile_apps/services/user_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/models/models.dart';

/// This is the interceptor that will be used by the [InterceptedClient]
/// to add the access token to the headers of the request.
class GivtApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      final accessToken =
          locator<LocalUserService>().getLocalUser().accessToken;
      if (accessToken.isNotEmpty) {
        data.headers['Authorization'] = 'Bearer $accessToken';
      }
      data.headers['Content-Type'] = 'application/json';
      data.headers['Accept'] = 'application/json';
    } catch (e) {
      log(e.toString());
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}

/// This is the retry policy that will be used by the [InterceptedClient]
/// to retry requests that failed due to an expired token.
class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int maxRetryAttempts = 2;

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    ///This is where we need to update our token on 401 response
    if (response.statusCode == 401) {
      /// Refreshing the token using the [UserService]
      final userService = locator<UserService>();
      await userService.refreshToken();
      return true;
    }
    return false;
  }
}
