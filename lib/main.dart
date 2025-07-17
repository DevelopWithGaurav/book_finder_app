import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/bloc/search_book_bloc.dart';
import 'view/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchBookBloc()),
      ],
      child: MaterialApp(
        title: 'Book Finder',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey)),
        debugShowCheckedModeBanner: false,
        home: SearchScreen(),
      ),
    );
  }
}
