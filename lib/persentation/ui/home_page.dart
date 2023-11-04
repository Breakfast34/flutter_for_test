import 'package:flutter/material.dart';
import 'package:flutter_application_1/persentation/bloc/data_user_bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataUserBloc _dataUserBlocBloc = DataUserBloc();
  @override
  void initState() {
    super.initState();
    _dataUserBlocBloc.add(FetchDataUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
      body: BlocBuilder<DataUserBloc, DataUserBlocState>(
        bloc: _dataUserBlocBloc,
        builder: (context, state) {
          if (state is DataUserBlocLoading) {
            dev.log('💚 DataUserBlocLoading');
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataUserBlocLoaded) {
            dev.log('💚 DataUserBlocLoaded');
            return ListView.builder(
                itemCount: state.listUsers.results.length,
                itemBuilder: (context, index) {
                  final dataUser = state.listUsers.results[index];
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(dataUser.picture.medium),
                      ),
                      title: Text(
                        'Name: ${dataUser.name.title} ${dataUser.name.first} ${dataUser.name.last}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email: ${dataUser.email}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                          Text(
                            'Age: ${dataUser.registered.age}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                          Text(
                            'Gender: ${dataUser.gender}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                          Text(
                            'Phone: ${dataUser.phone}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else if (state is DataUserBlocError) {
            dev.log('DataUserBlocError');
            return Text('Error: ${state.message}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
