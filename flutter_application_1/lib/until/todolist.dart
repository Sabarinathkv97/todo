import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoList extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? delete;

  ToDoList(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.delete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: delete,
            icon: Icons.delete,
            backgroundColor: Colors.red,
          )
        ]),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          padding: EdgeInsets.all(30),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              Text(
                taskName,
                style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
