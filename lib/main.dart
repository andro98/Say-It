import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sayit/blocs/authentication/authentication_bloc.dart';
import 'package:sayit/blocs/authentication/authentication_event.dart';
import 'package:sayit/blocs/authentication/authentication_state.dart';
import 'package:sayit/pages/ConversationPageSlide.dart';
import 'package:sayit/pages/RegisterPage.dart';
import 'package:sayit/repositories/AuthenticationRepository.dart';
import 'package:sayit/repositories/StorageRepository.dart';
import 'package:sayit/repositories/UserRepository.dart';

void main() {
  final AuthenticationRepository authRepository = AuthenticationRepository();
  final UserDataRepository userDataRepository = UserDataRepository();
  final StorageRepository storageRepository = StorageRepository();

  runApp(
    BlocProvider(
      builder: (context) => AuthenticationBloc(
          authenticationRepository: authRepository,
          userDataRepository: userDataRepository,
          storageRepository: storageRepository)
        ..dispatch(AppLaunched()),
      child: SayIt(),
    ),
  );
}

class SayIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Say it',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is UnAuthenticated) {
            return RegisterPage();
          } else if (state is ProfileUpdated) {
            return ConversationPageSlide();
          } else {
            return RegisterPage();
          }
        },
      ),
    );
  }
}
