import 'package:flutter/material.dart';
import 'package:pgoldapp/src/reusables/components/app_search_field.dart';

import '../../config/color_config.dart';

class BottomSheetUtil {
  static Future<T?> showCustomSheet<T>(
    BuildContext context, {
    required Widget child,
    required String title,
    String? subtitle,
    bool cancellable = true,
    bool isDismissible = true,
    bool enableDrag = true,
    bool searchable = false,
    ValueChanged<String>? onSearch,
    Color? backgroundColor,
  }) {
    final TextEditingController searchController = TextEditingController();
    final Color bgColor = backgroundColor ?? ColorConfig.surfaceWhite;

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.top,
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // ✅ Remove focus when tapping outside search field
                FocusScope.of(context).unfocus();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.85,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Drag handle
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: ColorConfig.textGrey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    // Header
                    Container(
                      width: double.infinity,
                      color: bgColor,
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConfig.textDark,
                                  ),
                                ),
                                if (subtitle != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      subtitle!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: ColorConfig.textGrey,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (cancellable)
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: ColorConfig.textGrey,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                        ],
                      ),
                    ),

                    // ✅ Search field
                    if (searchable)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: AppSearchField(
                          controller: searchController,
                          onChanged: onSearch,
                        ),
                      ),

                    const Divider(height: 1, color: Color(0xFFEEEEEE)),

                    // Content
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: bgColor,
                        child: child,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
