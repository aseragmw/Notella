part of 'notella_bloc.dart';

//Bloc Creation Needed States
abstract class NotellaState {}

class NotellaInitial extends NotellaState {}

class LoadingState extends NotellaState {}

//Authentication Needed States
class AuthLoggedInState extends NotellaState {
  final AuthUser user;
  AuthLoggedInState(this.user);
}

class AuthLoggedOutState extends NotellaState {
  AuthLoggedOutState();
}

class AuthNeedsVerificationState extends NotellaState {}

class AuthShouldRegisterState extends NotellaState {}

class AuthShouldLoginState extends NotellaState {}

//CRUD

class NoteCreatedState extends NotellaState {
  final CloudNote note;

  NoteCreatedState(this.note);
}

//States for createUpdateNoteView

class showTodoListAddButtonState extends NotellaState {}
