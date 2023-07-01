import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder({
    Key? key,
    required this.snapshot,
    required this.itemBuilder,
  }) : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data!;
      if (items.isNotEmpty) {
        return _buildListView(items);
      } else {
        return EmptyContent();
      }
    } else if (snapshot.hasError) {
      return EmptyContent(
        title: 'something_wrong'.tr,
        message: 'unable_to_upload'.tr,
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildListView(List<T> items) {
    return ListView.builder(
        itemCount: items.length + 2,
        itemBuilder: (context, index) {
          if (index == 0 || index == items.length + 1) {
            return Container();
          }
          return itemBuilder(context, items[index - 1]);
        });
  }
}
