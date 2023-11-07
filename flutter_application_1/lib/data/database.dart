import 'package:hive/hive.dart';

class toDoDatabase {
  List toDolists = [];

  final _mybox = Hive.box('mybox');

  void createInitialData() {
    toDolists = [
      ['make me', false],
      ['hello ', false]
    ];
  }

  void loadData() {
    toDolists = _mybox.get('TODOLIST');
  }

  void updateData() {
    _mybox.put('TODOLIST', toDolists);
  }
}
