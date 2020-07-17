import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './repostories/authenticate/firebase_user_repo.dart';
import './repostories/todo/firestore_todo_repo.dart';
import './screens/screens.dart';
import './bloc/blocs.dart';
import 'model/todo.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(FirebaseUserRepository())..add(AppStarted()),
        ),
        BlocProvider<TodoBloc>(
          create: (context) =>
              TodoBloc(FirestoreTodoRepository())..add(TodoLoaded()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        routes: {
          '/': (context) =>
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationSuccess) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider<TabsBloc>(
                          create: (context) => TabsBloc(),
                        ),
                        BlocProvider<FiltertodoBloc>(
                          create: (context) => FiltertodoBloc(
                            todoBloc: BlocProvider.of<TodoBloc>(context),
                          ),
                        ),
                        BlocProvider<StatsBloc>(
                          create: (context) => StatsBloc(
                            todoBloc: BlocProvider.of<TodoBloc>(context),
                          ),
                        ),
                      ],
                      child: HomeScreen(),
                    );
                  }
                  if (state is AuthenticationFailed) {
                    return Center(
                      child: Text('Could not authenticate with Firestore'),
                    );
                  }
                  print(state);
                  return Center(child: CircularProgressIndicator());
                },
              ),
          '/addEditScreen': (context) {
            return AddEditScreen(
              onSave: (task, note) {
                BlocProvider.of<TodoBloc>(context).add(
                  TodoAdded(Todo(task: task, note: note)),
                );
              },
              isEditing: false,
            );
          },
        },
      ),
    );
  }
}
