import 'package:flutter/material.dart';

class FocusedLayout extends StatelessWidget {
  const FocusedLayout({
    Key? key,
    required this.child,
    this.appBarTitle,
    this.padding,
    this.isScrollable = false,
    this.bottomWidget,
    this.fab,
    this.actions
  }) : super(key: key);

  final Widget child;
  final String? appBarTitle;
  final EdgeInsets? padding;
  final bool isScrollable;
  final Widget? bottomWidget;
  final Widget? fab;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: isScrollable,
      appBar: AppBar(
        title: Text(
          appBarTitle ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: actions,
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
      floatingActionButton: fab,
      bottomNavigationBar: bottomWidget,
    );
  }
}
