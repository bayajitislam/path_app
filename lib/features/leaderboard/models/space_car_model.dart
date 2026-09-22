/// Data model representing a selectable space vehicle in the garage.
class SpaceCarModel {
  final String id;
  final String name;
  final String imagePath;
  final bool isUnlocked;
  final int requiredPoints;

  const SpaceCarModel({
    required this.id,
    required this.name,
    required this.imagePath,
    this.isUnlocked = true,
    this.requiredPoints = 0,
  });
}
