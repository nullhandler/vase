import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/enums.dart';
import 'package:vase/screens/transactions/date_list_item.dart';
import 'package:vase/screens/transactions/trans_controller.dart';
import 'package:vase/screens/widgets/empty.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final TransController _controller = Get.find<TransController>();

  Widget results() {
    return Obx(() {
      _controller.query.value = query;
      _controller.searchTransactions();
      if (_controller.searchTxns.isEmpty &&
              _controller.searchTransState.value != VaseState.loading ||
          query == '') {
        return const EmptyWidget(
            assetName: "assets/img/no_txn.svg",
            label: "No Transactions Found !");
      } else if (_controller.searchTxns.isEmpty &&
          _controller.transState.value == VaseState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 20),
          shrinkWrap: true,
          itemCount: _controller.searchTxns.length,
          itemBuilder: (context, pos) {
            return DateListItem(
                isSearch: true,
                date: _controller.searchTxns.keys.elementAt(pos),
                transactions: _controller.searchTxns.values.elementAt(pos));
          });
    });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          _controller.query.value = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Get.back(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return results();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return results();
  }
}
