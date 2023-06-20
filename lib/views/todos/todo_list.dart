// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:notella/services/cloud/firestore_database.dart';
// import 'package:notella/views/todos/todo_card.dart';

// class ToDoList extends StatefulWidget {
//   final CloudNote currentNote;
//   ToDoList({super.key, required this.currentNote});

//   @override
//   State<ToDoList> createState() => _ToDoListState();
// }

// class _ToDoListState extends State<ToDoList> {
//   late List<Widget> todosWidgets;
//   late List<CloudTodo> todos;

//   _ToDoListState();

//   @override
//   void initState() {
//     todos = [];
//     todosWidgets = [];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             const Text('Add todo..'),
//             IconButton(
//                 onPressed: () async {
//                   await addTodoWiget();
//                 },
//                 icon: const Icon(Icons.add)),
//           ],
//         ),
//         Expanded(
//           child: SizedBox(
//               height: 200,
//               child: ListView.builder(
//                   itemCount: todos.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: todosWidgets[index],
//                     );
//                   })),
//         ),
//       ],
//     );
//   }

//   Future<void> addTodoWiget() async {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           TextEditingController controller = TextEditingController();
//           return AlertDialog(
//             title: const Text('Add todo'),
//             content: TextField(
//               controller: controller,
//             ),
//             actions: [
//               TextButton(
//                   onPressed: () async {
//                     final todo = await FirestoreDatabase().createTodo(
//                         noteId: widget.currentNote.noteId,
//                         text: controller.text);
//                     setState(() {
//                       todos.add(todo);
//                       todosWidgets.add(TodoCard(todoText: controller.text));
//                     });

//                     Navigator.of(context).pop(); //should save todo
//                   },
//                   child: const Text('save'))
//             ],
//           );
//         });
//   }
// }
