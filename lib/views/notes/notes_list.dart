import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notella/bloc/notella_bloc.dart';
import '../../utils/dialogs/delete_note_dialog.dart';
import 'package:notella/services/cloud/firestore_database.dart';

class NotesList extends StatelessWidget {
  final Iterable<CloudNote> notes;

  const NotesList({super.key, required this.notes,});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => context.read<NotellaBloc>().add(
              GoToCreateUpdateNoteViewEvent(context, notes.elementAt(index))),
          title: Text(
            notes.elementAt(index).text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
              onPressed: () async {
                final shouldDelete = await showDeleteNoteDialog(context);
                if (shouldDelete) {
                  // ignore: use_build_context_synchronously
                  context
                      .read<NotellaBloc>()
                      // ignore: use_build_context_synchronously
                      .add(DeleteNoteEvent(
                        notes.elementAt(index).noteId,
                      ));
                }
              },
              icon: const Icon(Icons.delete)),
        );
      },
    );
  }
}
