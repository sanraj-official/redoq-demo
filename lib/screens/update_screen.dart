import 'package:demo/Bloc/landing_screen_bloc.dart';
import 'package:demo/model/PersonModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/person_events.dart';
import '../utils.dart';

class UpdateScreen extends StatefulWidget {
  final Person person;
  final List<int> path;

  const UpdateScreen({super.key, required this.person, required this.path});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.person.name);
    ageController = TextEditingController(text: widget.person.age.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Update")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name', style: headingStyle()),
                    provideVSpace(),
                    TextFormField(
                      controller: nameController,
                      decoration:  InputDecoration(border: formBorder(),hintText: "Enter your name"),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter name";
                        }
                        return null;
                      },
                    ),
                    provideVSpace(),
                    Text('Age', style: headingStyle()),
                    provideVSpace(),
                    TextFormField(
                      controller: ageController,
                      decoration: InputDecoration(border: formBorder(),hintText: "Enter your age",),
                      keyboardType: TextInputType.number,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter age";
                        }
                        return null ;
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  if(_formKey.currentState == null || !_formKey.currentState!.validate()){
                    return;
                  }
                  final name = nameController.text;
                  final age = int.tryParse(ageController.text) ?? widget.person.age;
                  context.read<LandingScreenBloc>().add(
                    UpdatePersonEvent(path: widget.path, name: name, age: age),
                  );
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding:  EdgeInsets.symmetric(vertical: 10),
                  child:  Text("Submit",style: TextStyle(fontSize: 19),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}