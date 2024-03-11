import 'dart:async';

import 'package:built_value/built_value.dart';

import '../models/response/api_response.dart';
import '../models/states/api_state.dart';
import '../widgets/cubit.dart';
import 'dio.dart';

class CubitUtils {
  const CubitUtils._();

  static Future<void> makeApiCall<V extends Built<V, B>,
      B extends Builder<V, B>, ApiStateData>({
    required final BVCubit<V, B> cubit,
    required final apiState,
    required final void Function(B b, ApiState<ApiStateData> apiState)
        updateApiState,
    final Future<ApiStateData> Function()? callApi,
    final Future<ApiState<ApiStateData>> Function(
      ApiState<ApiStateData> apiState,
    )?
        callApiWithApiState,
    final bool makeDataNullAtStart = false,
    final String? successMessage,
    final FutureOr<void> Function(Object error)? onError,
  }) async {
    assert(callApi != null || callApiWithApiState != null);
    await Future.delayed(Duration.zero);
    var latestApiState = apiState.rebuild(
      (final bApiState) {
        bApiState
          ..isApiInProgress = true
          ..error = null
          ..message = null;
        if (makeDataNullAtStart) {
          bApiState.data = null;
        }
      },
    );
    cubit.emit(
      cubit.state.rebuild(
        (final b) => updateApiState(
          b,
          latestApiState,
        ),
      ),
    );
    try {
      if (callApi != null) {
        final data = await callApi();
        latestApiState = latestApiState.rebuild(
          (final b) => b.data = data,
        );
      } else if (callApiWithApiState != null) {
        latestApiState = callApiWithApiState(latestApiState);
      }
      latestApiState = latestApiState.rebuild(
        (final b) => b..message = successMessage,
      );
    } catch (e) {
      if (!(e is DioException && e.type == DioExceptionType.cancel)) {
        final metaData = ApiResponse.getStrongMetaData(e);
        latestApiState =
            latestApiState.rebuild((final b) => b.error = metaData.toString());
      }
      await onError?.call(e);
    }
    cubit.emit(
      cubit.state.rebuild(
        (final b) {
          updateApiState(
            b,
            latestApiState.rebuild(
              (final bApiState) => bApiState.isApiInProgress = false,
            ),
          );
        },
      ),
    );
  }
}
