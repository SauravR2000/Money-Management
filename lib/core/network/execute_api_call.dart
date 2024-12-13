import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> executeApiCall<T>({
  required Future<T> Function() apiCall,
  required Function(T response) onSuccess,
  required Function(String error) onError,
}) async {
  try {
    final response = await apiCall();
    onSuccess(response);
  } on AuthApiException catch (e) {
    log("API call failed: $e}");
    onError(e.message.toString());
  } catch (e) {
    log("Unexpected error occurred: ${e.runtimeType}");
    onError("An unexpected error occurred. Please try again.");
  }
}
