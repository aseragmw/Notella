import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:notella/services/auth/auth_provider.dart';
import 'package:notella/services/cloud/firestore_database.dart';
import 'package:notella/utils/dialogs/error_dialog.dart';
import 'package:notella/utils/dialogs/progress_indicator_dialog.dart';
import '../services/auth/auth_exceptions.dart';
import '../services/auth/auth_user.dart';
part 'notella_event.dart';
part 'notella_state.dart';

class NotellaBloc extends Bloc<NotellaEvent, NotellaState> {
  NotellaBloc(AuthProvider provider) : super(NotellaInitial()) {
    FirestoreDatabase cloud = FirestoreDatabase();
    
    on<AuthCheckLoggedInEvent>((event, emit) async {
      emit(LoadingState());

      await provider.initialize();
      final currentUser = provider.currentUser;
      if (currentUser != null) {
        if (true) {
          emit(AuthLoggedInState(currentUser));
        } else {
          emit(AuthNeedsVerificationState());
        }
      } else {
        emit(AuthLoggedOutState());
      }
    });

    //Authentication Handling
    on<AuthLoginEvent>((event, emit) async {
      ShowLoadingDialog.show(event.context);

      try {
        final user =
            await provider.login(email: event.email, password: event.password);
        ShowLoadingDialog.dismiss();

        if (true) {
          emit(AuthLoggedInState(user));
        } else {
          emit(AuthNeedsVerificationState());
        }
      } catch (e) {
        ShowLoadingDialog.dismiss();
        if (e == WrongPasswordException || e == UserNotFoundException) {
          await showErrorDialog(event.context, 'Wronng Credentials..');
        } else if (e == InvalidEmailException) {
          await showErrorDialog(event.context, 'Invalid Email..');
        } else {
          await showErrorDialog(event.context, 'Something went wrong..');
        }
      }
    });

    on<AuthRegisterEvent>((event, emit) async {
      ShowLoadingDialog.show(event.context);

      try {
        await provider.signUp(email: event.email, password: event.password);
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        await provider.logout();
        ShowLoadingDialog.dismiss();
        emit(AuthLoggedOutState());
      } catch (e) {
        ShowLoadingDialog.dismiss();
        if (e == WeakPasswordException) {
          await showErrorDialog(event.context, 'Weak password..');
        } else if (e == EmailAlreadyInUseException) {
          await showErrorDialog(event.context, 'Email Already In Use..');
        } else if (e == InvalidEmailException) {
          await showErrorDialog(event.context, 'Invalid Email..');
        } else {
          await showErrorDialog(event.context, 'Something went wrong..');
        }
      }
    });

    on<AuthShouldRegisterEvent>((event, emit) {
      emit(AuthShouldRegisterState());
    });

    on<AuthShouldLoginEvent>((event, emit) {
      emit(AuthShouldLoginState());
    });

    on<AuthSendVerificationEmailEvent>((event, emit) async {
      ShowLoadingDialog.show(event.context);
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      ShowLoadingDialog.dismiss();
    });

    on<LogoutEvent>(
      (event, emit) async {
        ShowLoadingDialog.show(event.context);
        await provider.logout();
        ShowLoadingDialog.dismiss();
        emit(AuthLoggedOutState());
      },
    );

    //Crud Handling

    on<DeleteNoteEvent>((event, emit) async {
      await cloud.deleteNote(noteId: event.noteID);
    });

    on<CreateNoteEvent>(
      (event, emit) async {
        final note = await cloud.createNote(
            ownerId: provider.currentUser!.id, content: event.noteContent);
        emit(NoteCreatedState(note));
      },
    );

    on<UpdateNoteEvent>(
      (event, emit) async {
        await cloud.updateNote(noteId: event.noteId, text: event.text);
      },
    );

    //Navigation Handling
    on<GoToCreateUpdateNoteViewEvent>(
      (event, emit) {
        if (event.note == null) {
          Navigator.of(event.context).pushNamed('CreateNoteView',
              arguments: {'context': event.context});
        } else {
          Navigator.of(event.context).pushNamed('CreateNoteView',
              arguments: {'context': event.context, 'note': event.note});
        }
      },
    );

    on<ShowErrorDialogEvent>((event, emit) async {
      await showErrorDialog(event.context, event.error);
    });

    on<ShowTodoListAddButtonEvent>((event, emit) async {
      print('helllllllllo from bloc class');
      emit(showTodoListAddButtonState());
    });
  }
}
