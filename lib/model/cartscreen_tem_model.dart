class CartScreenItemModel {
  int id, maxCount, currentCount;
  String title, category, image;
  double price;

  CartScreenItemModel(
    this.id,
    this.title,
    this.price,
    this.category,
    this.image,
    this.maxCount,
    this.currentCount
  );
}