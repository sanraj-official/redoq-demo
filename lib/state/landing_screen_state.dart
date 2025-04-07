

import 'package:demo/model/PersonModel.dart';

abstract class LandingScreenState {}

class LandingScreenInitial extends LandingScreenState {}

class LandingScreenLoaded extends LandingScreenState {
  final List<Person> persons;
  LandingScreenLoaded(this.persons);
}