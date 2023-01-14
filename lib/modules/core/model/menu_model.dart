class MenuModel {
  final int? price;
  final String? malayalamName;
  final String? englishName;
  final List<String> malayalamItems;
  final List<String> englishItems;

  MenuModel({
    required this.malayalamItems,
    required this.englishItems,
    this.price,
    this.malayalamName,
    this.englishName,
  });
}
