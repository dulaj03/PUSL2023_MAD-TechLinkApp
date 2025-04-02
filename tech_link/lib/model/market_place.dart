class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double? originalPrice;
  final String description;
  final String imageUrl;
  final List<String>? additionalImages;
  final double rating;
  final int reviewCount;
  final bool inStock;
  final bool isFavorite;
  final List<String>? features;
  final Map<String, String>? specifications;
  final List<String>? relatedProducts;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.description,
    required this.imageUrl,
    this.additionalImages,
    required this.rating,
    required this.reviewCount,
    required this.inStock,
    this.isFavorite = false,
    this.features,
    this.specifications,
    this.relatedProducts,
  });
}
