import 'package:flutter/material.dart';

Future<bool> showDeleteNoteDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (conteext) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are You sure ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      }).then((value) => value ?? false);
}
