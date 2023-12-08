import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data.dart';

class ApiException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;
  ApiException([this.message, this.prefix, this.url]);
}

class BadRequestException extends ApiException {
  BadRequestException([String? message, String? url])
      : super(message, 'Bad Request', url) {
    // Get.find<AnalyticsService>()
    //     .logApiError(message: message ?? 'Bad Request', link: url ?? 'No Link');
  }
}

class FetchDataException extends ApiException {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to process', url) {
    // Get.find<AnalyticsService>().logApiError(
    //     message: message ?? 'Fetch Data Exception', link: url ?? 'No Link');
  }
}

class ApiNotRespondingException extends ApiException {
  ApiNotRespondingException([String? message, String? url])
      : super(message, 'Api not Responded', url) {
    Overlay.of(Get.overlayContext!)!.dispose();
    Get.to(() => const NoConnectivity(
          title: 'Server Not Responding',
          subtitle: "We're fixing our server.\nWill be back soon!",
        ));
    // Get.find<AnalyticsService>().logApiError(
    //     message: message ?? 'Api Not Responding', link: url ?? 'No Link');
  }
}

class UnAuthorizedException extends ApiException {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'UnAuthorised Request', url) {
    // Get.find<AnalyticsService>().logUnAuthorized(link: url ?? 'No Link Found');
  }
}
