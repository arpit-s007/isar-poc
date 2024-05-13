import 'package:isar/isar.dart';

part 'product_db_model.g.dart';

@collection
class ProductDbModel {
  // Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  @Index()
  Id? productId;
  String? name;
  String? description;
  double? price;
}