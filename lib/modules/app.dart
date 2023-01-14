import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_in_city/modules/core/core_screen.dart';
import 'package:top_in_city/modules/core/presentation/bloc/core_bloc.dart';
import 'package:top_in_city/modules/core/theme/light_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CoreBloc>(
      create: (context) => CoreBloc()
        ..add(
          InitializeApi(),
        ),
      child: MaterialApp(
        title: 'Top In City',
        theme: lightTheme,
        themeMode: ThemeMode.light,
        home: const CoreScreen(),
      ),
    );
  }
}
