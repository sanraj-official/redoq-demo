
class Person {
  String name;
  int age;
  List<Person> children;

  Person({required this.name, required this.age, this.children = const []});

  Person copyWith({String? name, int? age, List<Person>? children}) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
      children: children ?? this.children,
    );
  }
}