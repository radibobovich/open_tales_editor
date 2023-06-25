import 'package:flutter/material.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  List<String> projects = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Projects'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/create_project');
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(projects[index]),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/project', arguments: projects[index]);
                },
              );
            }));
  }
}
