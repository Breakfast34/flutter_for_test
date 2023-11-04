import 'package:data_flutter_for_test/data_flutter_for_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'persentation/bloc/data_user_bloc_bloc.dart';
import 'persentation/ui/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DataUserBloc>(create: (context) => DataUserBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(title: 'PROFILE' ),
      ),
    );
  }
}
