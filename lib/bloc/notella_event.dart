part of 'notella_bloc.dart';

@immutable
abstract class NotellaEvent {}

//Starting The App Neeeded Events
class AuthCheckLoggedInEvent extends NotellaEvent {}

//Authentication Needed Events
class AuthLoginEvent extends NotellaEvent {
  final String email;
  final String password;
  final BuildContext context;

  AuthLoginEvent(this.email, this.password, this.context);
}

class LogoutEvent extends NotellaEvent {
  final BuildContext context;

  LogoutEvent(this.context);
}

class AuthRegisterEvent extends NotellaEvent {
  final String email;
  final String password;
  final BuildContext context;

  AuthRegisterEvent(this.email, this.password, this.context);
}

class AuthShouldRegisterEvent extends NotellaEvent {}

class AuthShouldLoginEvent extends NotellaEvent {}

class AuthSendVerificationEmailEvent extends NotellaEvent {
  final BuildContext context;
  AuthSendVerificationEmailEvent(this.context);
}

//Crud Needed Events
class DeleteNoteEvent extends NotellaEvent {
  final String noteID;

  DeleteNoteEvent(
    this.noteID,
  );
}

class CreateNoteEvent extends NotellaEvent {
  final String noteContent;
  CreateNoteEvent(
    this.noteContent,
  );
}

class UpdateNoteEvent extends NotellaEvent {
  final String noteId;
  final String text;
  UpdateNoteEvent(
    this.noteId,
    this.text,
  );
}

class ShowErrorDialogEvent extends NotellaEvent {
  final BuildContext context;
  final String error;

  ShowErrorDialogEvent(this.context, this.error);
}

//Navigation Neeeded Events
class GoToCreateUpdateNoteViewEvent extends NotellaEvent {
  final BuildContext context;
  final CloudNote? note;

  GoToCreateUpdateNoteViewEvent(this.context, this.note);
}

//Events for createUpdateNoteView
class ShowTodoListAddButtonEvent extends NotellaEvent {}
