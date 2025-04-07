import 'package:demo/Bloc/landing_screen_bloc.dart';
import 'package:demo/state/landing_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/PersonModel.dart';
import '../utils.dart';
import 'update_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool isExpanded = true ;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<LandingScreenBloc, LandingScreenState>(
          builder: (context, state) {
            if (state is LandingScreenLoaded) {
              return SingleChildScrollView(
                child: InkWell(
                  onTap: (){
                    setState(() {
                      isExpanded = !isExpanded ;
                    });
                  },
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Your Details", style: headingStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                              Icon(isExpanded?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down)
                            ],
                          ),
                        ),
                        isExpanded?Column(children: _buildNestedList(context, state.persons, []),):const SizedBox(height: 0,)
                      ],
                    ),
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  List<Widget> _buildNestedList(BuildContext context, List<Person> persons, List<int> path) {
    return List.generate(persons.length, (index) {
      final person = persons[index];
      final currentPath = [...path, index];
      return Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Card(
          margin: const EdgeInsets.all(4),
          child: ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(person.name),
                  Text("${person.age} Years Old", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ]),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<LandingScreenBloc>(),
                          child: UpdateScreen(person: person, path: currentPath),
                        ),
                      ),
                    );

                  },
                ),
              ],
            ),
            children: _buildNestedList(context, person.children, currentPath),
          ),
        ),
      );
    });
  }
}