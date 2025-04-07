

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
      Person(name: "Richard E. Meyer", age: 28),
      Person(name: "Stephanie S. Young", age: 28, children: [
        Person(name: "Richard E. Meyer", age: 28),
        Person(name: "Richard E. Meyer", age: 28, children: [
          Person(name: "Richard E. Meyer", age: 28),
          Person(name: "Richard E. Meyer", age: 28),
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