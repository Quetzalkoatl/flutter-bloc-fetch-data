import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc/blocs/app_blocs.dart';
import 'package:http_bloc/blocs/app_events.dart';
import 'package:http_bloc/blocs/app_states.dart';
import 'package:http_bloc/models/user_model.dart';
import 'package:http_bloc/repos/repositories.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(RepositoryProvider.of<UserRepository>(context))..add(LoadUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Flutter Bloc HTTP fetch data app')),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UserLoadedState) {
              List<UserModel> userList = state.users;

              return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        color: Colors.blue,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(userList[index].firstName, style: const TextStyle(
                            color: Colors.white
                          ),),
                          subtitle: Text(userList[index].lastName, style: const TextStyle(
                            color: Colors.white
                          ),),
                          trailing: CircleAvatar(
                            backgroundImage: NetworkImage(userList[index].avatar),
                          ),
                        ),
                      ),
                    );
                  });
            }

            if (state is UserErrorState) {
              return const Center(
                child: Text('Error'),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
