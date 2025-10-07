import 'package:flutter/material.dart';
import 'package:pgoldapp/src/reusables/extensions/context.dart';

import '../utils/view_utils.dart';

enum MenuButtonPlacement { start, end }

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final double height;
  final bool addTexts;
  final bool showMenuButton;
  final MenuButtonPlacement menuButtonPlacement;
  Widget? leading;
  final bool? centerTitle;
  final Widget? exTitle;

  /// 💡 Custom background and title color
  final Color? backgroundColor;
  final Color? titleColor;

  MainAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.subtitleWidget,
    this.bottom,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.height = kToolbarHeight + 100,
    this.addTexts = true,
    this.showMenuButton = false,
    this.menuButtonPlacement = MenuButtonPlacement.start,
    this.leading,
    this.exTitle,
    this.centerTitle,
    this.backgroundColor,
    this.titleColor, // 🎯 New parameter
  });

  @override
  Widget build(BuildContext context) {
    Widget menuButton = showMenuButton
        ? IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              if (menuButtonPlacement == MenuButtonPlacement.end) {
                Scaffold.of(context).openEndDrawer();
              } else {
                Scaffold.of(context).openDrawer();
              }
            },
            tooltip: 'Open menu',
          )
        : const SizedBox.shrink();

    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle ?? false,
      surfaceTintColor: Colors.transparent,
      backgroundColor: backgroundColor ?? Colors.white,
      foregroundColor: Colors.black,
      titleSpacing: 0,
      leading: automaticallyImplyLeading
          ? (showMenuButton && menuButtonPlacement == MenuButtonPlacement.start
              ? InkWell(
                  onTap: () => Navigator.of(context).maybePop(),
                  borderRadius: BorderRadius.circular(100),
                  child: leading ??
                      Container(
                        width: 36,
                        height: 36,
                        margin:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 16,
                          color: Colors.black87,
                        ),
                      ),
                )
              : leading ??
                  InkWell(
                    onTap: () => Navigator.of(context).maybePop(),
                    borderRadius: BorderRadius.circular(100),
                    child: leading ??
                        Container(
                          width: 36,
                          height: 36,
                          margin:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 16,
                            color: Colors.black87,
                          ),
                        ),
                  ))
          : (showMenuButton && menuButtonPlacement == MenuButtonPlacement.start
              ? leading ?? menuButton
              : leading),
      title: addTexts
          ? Column(
              crossAxisAlignment: subtitle != null
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              mainAxisAlignment: subtitle != null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 2),
                // subtitleWidget != null
                //     ? const SizedBox.shrink()
                //     : const SizedBox(height: 6),
                if (title != null)
                  Text(
                    title!,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: ViewUtils.gap(2.4),
                      fontWeight: FontWeight.w900,
                      color: titleColor ?? Colors.black,
                    ),
                  )
                else
                  (subtitleWidget ?? const SizedBox.shrink()),
                if (subtitle != null)
                  SizedBox(
                    // width: ViewUtils.gap(60),
                    child: Text(
                      subtitle!,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: Colors.black54,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                    ),
                  )
                else
                  (subtitleWidget ?? const SizedBox.shrink()),
              ],
            )
          : exTitle,
      bottom: bottom,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              if (menuButtonPlacement == MenuButtonPlacement.end)
                leading ?? menuButton,
              ...actions ?? [],
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
