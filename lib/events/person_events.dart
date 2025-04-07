abstract class PersonEvent {}

class LoadPersonsEvent extends PersonEvent {}

class UpdatePersonEvent extends PersonEvent {
  final List<int> path;
  final String name;
  final int age;

  UpdatePersonEvent({required this.path, required this.name, required this.age});
}