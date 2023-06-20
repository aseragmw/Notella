import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notella/bloc/notella_bloc.dart';
import 'package:notella/services/cloud/firestore_database.dart';
import 'package:notella/views/notes/notes_list.dart';

import '../../services/auth/auth_user.dart';
import '../../utils/dialogs/logout_dialog.dart';

class NotesView extends StatefulWidget {
  final AuthUser user;
  const NotesView({Key? key, required this.user}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

enum NotesViewPopupMenu { logout }

class _NotesViewState extends State<NotesView> {
  late FirestoreDatabase cloud;

  @override
  void initState() {
    cloud = FirestoreDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Notes'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                context
                    .read<NotellaBloc>()
                    .add(GoToCreateUpdateNoteViewEvent(context, null));
              },
              icon: const Icon(Icons.add)),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: NotesViewPopupMenu.logout,
                child: Text('Logout'),
              )
            ],
            onSelected: (value) async {
              if (value == NotesViewPopupMenu.logout) {
                final shouldLogOut = await showLogOutDialog(context);
                if (shouldLogOut) {
                  // ignore: use_build_context_synchronously
                  context.read<NotellaBloc>().add(LogoutEvent(context));
                } else {}
              }
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: cloud.allNotes(ownerId: widget.user.id),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  return NotesList(
                    notes: snapshot.data!,
                  );
                } else {
                  return const CircularProgressIndicator();
                }

              default:
                return const CircularProgressIndicator();
            }
          }),
    );
  }
}
