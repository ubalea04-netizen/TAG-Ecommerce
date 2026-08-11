class Product {
  final String id;
  final String title;
  final String category;
  final String vendor;
  final double price;
  final double rating;
  final bool isAuction;
  final String imageUrl;
  final int inventoryCount;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.vendor,
    required this.price,
    required this.rating,
    required this.isAuction,
    required this.imageUrl,
    required this.inventoryCount,
  });
}
