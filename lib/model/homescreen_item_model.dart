class HomeScreenModel {
  final List<HomeScreenProductModel> allProducts;

  const HomeScreenModel(this.allProducts);

  factory HomeScreenModel.fromJson(List<dynamic> json) {
    List<HomeScreenProductModel> productsList = [];
    for (var value in json) {
      productsList.add(HomeScreenProductModel(
        value["id"], 
        value["title"], 
        value["price"].toDouble(), 
        value["category"], 
        value["image"], 
        value["rating"]["count"]));
    }

    return HomeScreenModel(productsList);
  }
}

class HomeScreenProductModel {
  final int id, count;
  final String title, category, image;
  final double price;

  const HomeScreenProductModel(
    this.id,
    this.title,
    this.price,
    this.category,
    this.image,
    this.count
  );
}