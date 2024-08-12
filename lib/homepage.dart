import 'package:flutter/material.dart';
import 'Colors.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  ////// Robot put the transcriptions data in _items

  final List<String> _items = List.generate(20, (index) => 'Item ${index + 1}');
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gradient AppBar', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                  Color(0xFF2c67f2),
                  Color(0xFF62cff4),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: AnimatedList(
          key: _listKey,
          initialItemCount: _items.length,
          itemBuilder: (context, index, animation) {
            return _buildItem(_items[index], index, animation);
          },
        ),
      ),
    );
  }

  Widget _buildItem(String item, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        margin: const EdgeInsets.symmetric(vertical: 7.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          tileColor: colours.sec,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          title: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text(
              item,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.summarize_outlined, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetailPage(item: item),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.task_alt, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDeletePage(item: item),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  _removeItem(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removeItem(int index) {
    if (index < 0 || index >= _items.length) return;

    String removedItem = _items[index];
    _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedItem, index, animation),
      duration: const Duration(milliseconds: 300),
    );
  }
}

class ItemDetailPage extends StatelessWidget {
  final String item;

  const ItemDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Center(
        child: Text(
          'Details of $item',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class ItemDeletePage extends StatelessWidget {
  final String item;

  const ItemDeletePage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> deleteTodoItems = [
      '$item - Task A',
      '$item - Task B',
      '$item - Task C',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: deleteTodoItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(deleteTodoItems[index]),
                  leading: const Icon(Icons.task),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}