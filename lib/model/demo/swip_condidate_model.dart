class SwipeCandidateModel {
  final String id;
final String name;
final List<String> image;
final int age;
final String city;
final String distance;
final List<String> hobbies;
final String? audio;


SwipeCandidateModel({
  required this.id,
  required this.name,
  required this.image,
  required this.age,
  required this.city,
  required this.distance,
  required this.hobbies,
   this.audio
});

}