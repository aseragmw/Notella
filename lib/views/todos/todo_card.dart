// import 'package:flutter/material.dart';

// class TodoCard extends StatefulWidget {
//   final String todoText;
//   const TodoCard({super.key, required this.todoText});

//   @override
//   State<TodoCard> createState() => _TodoCardState();
// }

// class _TodoCardState extends State<TodoCard> {
//   bool checkBoxValue = false;
//   TextDecoration? decoration = TextDecoration.none;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 60,
//       width: 100,
//       child: Row(
//         children: [
//           Text(widget.todoText, style: TextStyle(decoration: decoration)),
//           Checkbox(
//               value: checkBoxValue,
//               onChanged: (value) {
//                 setState(() {
//                   if (value != null) {
//                     checkBoxValue = value;
//                     if (checkBoxValue) {
//                       setState(() {
//                         decoration = TextDecoration.lineThrough;
//                       });
//                     } else {
//                       setState(() {
//                         decoration = TextDecoration.none;
//                       });
//                     }
//                   }
//                 });
//               }),
//           IconButton(onPressed: () {
            
//           }, icon: const Icon(Icons.delete))
//         ],
//       ),
//     );
//   }
// }
