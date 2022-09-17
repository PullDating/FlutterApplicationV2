// I have to use a different class to represent the person rather than profile unfortunately.

class Person {
  Person({required this.uuid,required this.name,required this.age, this.gender, this.bodyType, this.height, this.biography, required this.distance});

  final String uuid;
  final String name;
  final int age;
  final String? gender;
  final String? bodyType;
  final int? height;
  final String? biography;
  final int distance;
}