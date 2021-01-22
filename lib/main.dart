import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'КиноCheck'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  List<String> _todoItems = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      print('Going to the background mode');
    } else if (state == AppLifecycleState.resumed) {
      print('Back in the active mode');
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text(
            _todoItems[index],
          ),
          onLongPress: () => _promtRemoveTodoItem(index),
        ),
        itemCount: _todoItems.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFilmItem,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addListItem(String item) {
    setState(() => _todoItems.add(item));
  }

  void _removeListItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _addFilmItem() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Добавить фильм'),
          backgroundColor: Colors.deepPurple,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
              child: IconButton(
                icon: const Icon(Icons.save, size: 30.0),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        body: TextField(
          autofocus: true,
          onSubmitted: (val) {
            _addListItem(val);
            Navigator.pop(context);
          },
          decoration: InputDecoration(
            hintText: 'Введите название фильма',
          ),
        ),
      );
    }));
  }

  void _promtRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Вы действительно хотите удалить этот фильм из своей кинотеки?'),
          actions: [
            FlatButton(
              child: Text('Да'),
              onPressed: () {
                _removeListItem(index);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
