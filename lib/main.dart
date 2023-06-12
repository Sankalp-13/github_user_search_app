import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_search_app/logic/cubits/user_search_cubit/user_search_cubit.dart';
import 'package:github_user_search_app/presentation/screens/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (context) => UserSearchCubit(),
          child: MaterialApp(
            theme: ThemeData(scaffoldBackgroundColor: const Color(0xff0c1414)),
            debugShowCheckedModeBanner: false,
            home: const SearchScreen(),
          ),
        );
  }
}