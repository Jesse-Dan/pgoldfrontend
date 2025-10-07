import "package:bot_toast/bot_toast.dart";
import "package:flutter_riverpod/legacy.dart";
import "package:pgoldapp/src/reusables/utils/ref_holder.dart";

import "../components/app_loading_indicator.dart";

final loadingProvider = StateProvider<bool>((ref) => false);

void showLoading([String? text]) {
  RefHolder.ref.read(loadingProvider.notifier).state = true;
  cancelLoading();
  BotToast.showCustomLoading(
    toastBuilder:
        (cancelFunc) =>
            AppLoadingIndicator(text: text?.replaceAll("Exception:", "")),
  );
}

void cancelLoading() {
  RefHolder.ref.read(loadingProvider.notifier).state = false;
  BotToast.closeAllLoading();
}
