
class ProductModel {

  final int id;
  final String productName;
  final String barcodeNumber;
  final double buyingPrice;
  final double mrpPrice;
  final double sellingPrice;
  final int quantity;
  final String category;
  final String description;
  final String imageUrl;
  final String status;

  ProductModel({
    required this.id,
    required this.productName,
    required this.barcodeNumber,
    required this.buyingPrice,
    required this.mrpPrice,
    required this.sellingPrice,
    required this.quantity,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.status,
  });

  factory ProductModel.fromJson(
      Map<String, dynamic> json) {

    return ProductModel(
      id: json["id"],

      productName:
      json["productName"] ?? "",

      barcodeNumber:
      json["barcodeNumber"] ?? "",

      buyingPrice:
      (json["buyingPrice"] as num)
          .toDouble(),

      mrpPrice:
      (json["mrpPrice"] as num)
          .toDouble(),

      sellingPrice:
      (json["sellingPrice"] as num)
          .toDouble(),

      quantity:
      json["quantity"] ?? 0,

      category:
      json["category"] ?? "",

      description:
      json["description"] ?? "",

      imageUrl:
      json["imageUrl"] ?? "",

      status:
      json["status"] ?? "",
    );
  }
}
