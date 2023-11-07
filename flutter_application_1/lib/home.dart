import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/until/dialoge.dart';
import 'package:flutter_application_1/until/todolist.dart';
import 'package:hive/hive.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final _mybox = Hive.box('mybox');
  toDoDatabase db = toDoDatabase();

  @override
  void initState() {
    if (_mybox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();
  //
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDolists[index][1] = !db.toDolists[index][1];
      db.updateData();
    });
  }

  void saveNewtask() {
    setState(() {
      db.toDolists.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void creatList() {
    showDialog(
      context: context,
      builder: (context) {
        return dialogueBox(
          controller: _controller,
          onSave: saveNewtask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDolists.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          creatList();
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDolists.length,
        itemBuilder: (context, index) {
          return ToDoList(
            taskName: db.toDolists[index][0],
            taskCompleted: db.toDolists[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            delete: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
