import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notella/services/auth/firebase_auth_provider.dart';
import 'package:notella/services/cloud/firestore_database.dart';
import 'package:notella/views/todos/todo_list.dart';

import '../../bloc/notella_bloc.dart';

// ignore: must_be_immutable
class CreateNoteView extends StatefulWidget {
  late CloudNote? note;
  CreateNoteView({Key? key}) : super(key: key);

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  late TextEditingController _controller;
  late BuildContext passedContext;
  bool showAddTodoListButton = false;

  @override
  void initState() {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    passedContext = arguments['context'];
    widget.note = arguments['note'];
    passedContext.read<NotellaBloc>().add(CreateNoteEvent(
          '',
        ));
    BlocListener<NotellaBloc, NotellaState>(
      listener: (context, state) {
        if (state is NoteCreatedState) {
          widget.note = state.note;
        }
      },
    );
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    saveIfTextExists();

    _controller.dispose();
    super.dispose();
  }

  void saveIfTextExists() {
    if (_controller.text.isNotEmpty && widget.note == null) {
      passedContext.read<NotellaBloc>().add(CreateNoteEvent(
            _controller.text,
          ));
    } else if (_controller.text.isNotEmpty && widget.note != null) {
      passedContext.read<NotellaBloc>().add(UpdateNoteEvent(
            widget.note!.noteId,
            _controller.text,
          ));
    } else if (_controller.text.isEmpty && widget.note != null) {
      //delete
      passedContext.read<NotellaBloc>().add(DeleteNoteEvent(
            widget.note!.noteId,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.note != null) {
      print(widget.note?.text);
      _controller.text = widget.note!.text;
    } else {
      if (passedContext != null) {
        print('not null');
      }
    }
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                      value: MenuActions.addTodos, child: Text('Add Todos'))
                ];
              },
              onSelected: (value) {
                if (value == MenuActions.addTodos) {
                  passedContext
                      .read<NotellaBloc>()
                      .add(ShowTodoListAddButtonEvent());
                }
              },
            )
          ],
        ),
        body: Column(
          children: [
            TextField(
              maxLines: null,
              controller: _controller,
              decoration: const InputDecoration(
                  hintText: 'Enter Your Note..', border: InputBorder.none),
            ),
            // showAddTodoListButton == true
            //     ? Expanded(
            //         child: SizedBox(
            //         height: 200,
            //         child: ToDoList(
            //           currentNote: widget.note!,
            //         ),
            //       ))
            //     : const Text(''),
          ],
        ));
  }
}

enum MenuActions { addTodos }
