import 'package:flutter/material.dart';
import 'package:shoppingapp/models/grocery_item.dart';
import 'package:shoppingapp/widgets/new_item.dart';

class GloceryList extends StatefulWidget {
  const GloceryList({super.key});

  @override
  State<GloceryList> createState() => _GloceryListState();
}

class _GloceryListState extends State<GloceryList> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem() async {
    final newItem1 = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewItem()));

    if (newItem1 == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem1);
    });
  }

  void removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("No items added yet."),
    );

    if (!_groceryItems.isEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) => Dismissible(
          onDismissed: (direction) { removeItem(_groceryItems[index]); },
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(_groceryItems[index].quantity.toString()),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: content,
    );
  }
}
