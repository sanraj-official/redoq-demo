

import 'package:demo/events/person_events.dart';
import 'package:demo/model/PersonModel.dart';
import 'package:demo/state/landing_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingScreenBloc extends Bloc<PersonEvent, LandingScreenState> {
  LandingScreenBloc() : super(LandingScreenInitial()) {
    on<LoadPersonsEvent>(_onLoad);
    on<UpdatePersonEvent>(_onUpdate);
  }

  void _onLoad(LoadPersonsEvent event, Emitter<LandingScreenState> emit) {
    List<Person> mockData = [
      Person(name: "Sanraj", age: 28, children: [
        Person(name: "Ravi Ghosh", age: 9,children: [
          Person(name: "Sachin Tendulkar", age: 45),
          Person(name: "Jhonny Deep", age: 68),
        ]),
        Person(name: "Priya Roy", age: 20, children: [
          Person(name: "David Austin", age: 15, children: [
            Person(name: "Ravi Ghosh", age: 9,children: [
              Person(name: "Sachin Tendulkar", age: 45),
              Person(name: "Jhonny Deep", age: 68),
            ]),
            Person(name: "Priya Roy", age: 20, children: [
              Person(name: "David Austin", age: 15),
              Person(name: "M.S. Dhoni", age: 38),
            ]),
          ]),
          Person(name: "M.S. Dhoni", age: 38),
        ]),
      ]),
      Person(name: "Rohan Kumar", age: 25, children: [
        Person(name: "Ravi Ghosh", age: 9,children: [
          Person(name: "Sachin Tendulkar", age: 45),
          Person(name: "Jhonny Deep", age: 68),
        ]),
        Person(name: "Priya Roy", age: 20, children: [
          Person(name: "David Austin", age: 15),
          Person(name: "M.S. Dhoni", age: 38),
        ]),
      ]),
    ];
    emit(LandingScreenLoaded(mockData));
  }

  void _onUpdate(UpdatePersonEvent event, Emitter<LandingScreenState> emit) {
    if (state is LandingScreenLoaded) {
      List<Person> updated = [...(state as LandingScreenLoaded).persons];
      _updatePersonAtPath(updated, event.path, event.name, event.age);
      emit(LandingScreenLoaded(updated));
    }
  }

  void _updatePersonAtPath(List<Person> list, List<int> path, String name, int age) {
    if (path.isEmpty) return;
    Person person = list[path[0]];
    if (path.length == 1) {
      list[path[0]] = person.copyWith(name: name, age: age);
    } else {
      _updatePersonAtPath(person.children, path.sublist(1), name, age);
    }
  }
}