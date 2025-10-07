import "package:bot_toast/bot_toast.dart";
import "package:flutter/cupertino.dart";
import "package:pgoldapp/src/reusables/extensions/context.dart";

import "../../config/asset_config.dart";
import "../../config/color_config.dart";
import "../../config/route_config.dart";
import "../components/image_viewer.dart";

void showText(String text, {Duration? duration}) {
  BotToast.cleanAll();
  BotToast.showCustomText(
    toastBuilder: (v) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: ColorConfig.primaryBlueDark.withOpacity(.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 9,
                  ),
                  child: AppImageViewer(
                    AssetConfig.appIcon,
                    height: 24,
                    width: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  // 👈 Allow text to wrap
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Text(
                      text.replaceAll("Exception:", ""),
                      style: navigatorKey.currentContext?.textTheme.labelLarge
                          ?.copyWith(
                        color: ColorConfig.textWhite,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: null,
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    duration: duration ?? const Duration(seconds: 3),
  );
}
