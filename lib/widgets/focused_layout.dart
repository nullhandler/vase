import 'package:flutter/material.dart';

class FocusedLayout extends StatelessWidget {
  const FocusedLayout({
    Key? key,
    required this.child,
    this.appBarTitle,
    this.padding,
    this.isScrollable = false,
    this.bottomWidget,
  }) : super(key: key);

  final Widget child;
  final String? appBarTitle;
  final EdgeInsets? padding;
  final bool isScrollable;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle ?? ""),
      ),
      body: Builder(
        builder: (context) {
          if (isScrollable) {
            return SingleChildScrollView(
              padding: padding ?? EdgeInsets.zero,
              child: child,
            );
          }
          return Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: bottomWidget,
      ),
    );
  }
}
