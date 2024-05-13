class FakeProduct {
  String? productId;
  String? name;
  String? description;
  double? price;

  FakeProduct({this.productId, this.name, this.description, this.price});

  FakeProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    return data;
  }
}