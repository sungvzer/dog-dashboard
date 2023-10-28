class DogBreed {
  final String name;
  final List<String> subBreeds;

  DogBreed({required this.name, required this.subBreeds});

  static List<DogBreed> parseJson(Map<String, dynamic> json) {
    final message = json['message'] as Map<String, dynamic>;

    final List<String> breedNames = message.keys.toList();

    // Create a list of DogBreed instances
    final List<DogBreed> dogBreeds = [];

    for (final breedName in breedNames) {
      final List<String> subBreeds = List<String>.from(message[breedName]);
      final dogBreed = DogBreed(name: breedName, subBreeds: subBreeds);
      dogBreeds.add(dogBreed);
    }
    return dogBreeds;
  }
}
