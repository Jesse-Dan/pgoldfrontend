import 'package:flutter/material.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/modules/dashboard/views/rate_view.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';

class AppNavBarContainer extends StatefulWidget {
  final List<Widget> pages;
  final List<AppNavItem> items;
  final Color backgroundColor;
  final int initialIndex;
  final ValueChanged<int>? onIndexChanged;

  const AppNavBarContainer({
    super.key,
    required this.pages,
    required this.items,
    this.backgroundColor = Colors.white,
    this.initialIndex = 0,
    this.onIndexChanged,
  });

  @override
  State<AppNavBarContainer> createState() => _AppNavBarContainerState();
}

class _AppNavBarContainerState extends State<AppNavBarContainer> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTap(int index) {
    if (index == 3) {
      Navigator.pushNamed(context, RateView.routeName);
      return;
    }
    setState(() => _currentIndex = index);
    widget.onIndexChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: IndexedStack(
        index: _currentIndex,
        children: widget.pages,
      ),
      bottomNavigationBar: _AppNavBar(
        currentIndex: _currentIndex,
        items: widget.items,
        onTap: _onTap,
      ),
    );
  }
}

class _AppNavBar extends StatelessWidget {
  final int currentIndex;
  final List<AppNavItem> items;
  final Function(int) onTap;

  const _AppNavBar({
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final active = currentIndex == index;
          final item = items[index];

          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AppImageViewer(
                        item.iconPath,
                        width: active ? 28 : 24,
                        height: active ? 28 : 24,
                        color: active
                            ? ColorConfig.primaryBlueLight
                            : ColorConfig.textGrey,
                      ),
                      if (active)
                        Positioned(
                          bottom: -5,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: ColorConfig.primaryBlueLight,
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                      color: active
                          ? ColorConfig.primaryBlueLight
                          : ColorConfig.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class AppNavItem {
  final String iconPath; // image or svg path
  final String label;

  const AppNavItem({
    required this.iconPath,
    required this.label,
  });
}
