import 'package:flutter/material.dart';
import 'package:vase/screens/widgets/fab.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("hello"),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Expense",
              ),
              Tab(
                text: "Income",
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Text("hello"),
            Text("hello 2"),
          ],
        ),
        floatingActionButton: Fab(onTap: () {}),
      ),
    );
  }
}
