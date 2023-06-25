import 'package:flutter/material.dart';

import 'presentation/screens/create_project_screen.dart';
import 'presentation/screens/projects_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/create_project': (BuildContext context) =>
            const CreateProjectScreen(),
      },
      home: const ProjectsScreen(),
    );
  }
}
