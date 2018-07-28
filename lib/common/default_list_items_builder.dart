import 'package:boe/common/empty_place_holder.dart';
import 'package:flutter/material.dart';

typedef Widget ItemWidgetBuilder<T>(BuildContext context, T item);

class DefaultListItemsBuilder<T> extends StatelessWidget {
  DefaultListItemsBuilder({this.items, this.itemBuilder});
  final List<T> items;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (items != null) {
      if (items.length > 0) {
        return _buildList();
      } else {
        return EmptyPlaceholder();
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return itemBuilder(context, items[index]);
        });
  }
}
