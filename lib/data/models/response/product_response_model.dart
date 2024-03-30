import 'dart:convert';

class ProductResponseModel {
  final bool? status;
  final List<Product>? data;

  ProductResponseModel({
    this.status,
    this.data,
  });

  factory ProductResponseModel.fromJson(String str) => ProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) => ProductResponseModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Product>.from(json["data"]!.map((x) => Product.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toLocalMap())),
  };
}

class Product {
  final int? id;
  final String? name;
  final String? price;
  final String? image;
  final String? description;
  final int? status;
  final int? stock;
  final int? categoryId;
  final Category? category;

  Product({
    this.id,
    this.name,
    this.price,
    this.image,
    this.description,
    this.status,
    this.stock,
    this.categoryId,
    this.category,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["item_name"],
    price: json["selling_price"]?.toString(),
    image: json["item_photo"],
    description: json["descriptions"],
    status: int.parse(json["item_status"]),
    stock: json["min_stock"],
    category: json["categories"] == null ? null : Category.fromMap(json["categories"][0]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "item_name": name,
    "selling_price": price,
    "item_photo": image,
    "descriptions": description,
    "item_status": status,
    "min_stock": stock,
  };

  factory Product.fromOrderMap(Map<String, dynamic> json) => Product(
    id: json["id_product"],
  );

  factory Product.fromLocalMap(Map<String, dynamic> json) => Product(
    id: json["productId"],
    categoryId: json["categoryId"],
    category: Category(
      id: json["categoryId"],
      categoryName: json["categoryName"],
    ),
    name: json["name"],
    price: json["price"],
    image: json["image"],
    description: json["description"],
    status: json["status"],
    stock: json["stock"],
  );

  Map<String, dynamic> toLocalMap() => {
    "productId": id,
    "categoryId": categoryId,
    "categoryName": category?.categoryName,
    "name": name,
    "description": description,
    "image": image,
    "price": price,
    "stock": stock,
    "status": status,
  };
}

class Category {
  final int? id;
  final String? categoryName;
  final String? categoryType;
  final String? categoryDescription;

  Category({
    this.id,
    this.categoryName,
    this.categoryType,
    this.categoryDescription,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    categoryName: json["category_name"],
    categoryType: json["category_type"],
    categoryDescription: json["category_description"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "category_name": categoryName,
    "category_type": categoryType,
    "category_description": categoryDescription,
  };
}

class Pivot {
  final int? productId;
  final int? categoryId;

  Pivot({
    this.productId,
    this.categoryId,
  });

  factory Pivot.fromJson(String str) => Pivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
    productId: json["product_id"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toMap() => {
    "product_id": productId,
    "category_id": categoryId,
  };
}

class Productconvertion {
  final int? id;
  final int? productId;
  final int? unitId;
  final int? nilai;
  final int? nilaiTerkecil;
  final int? baseUnitId;
  final int? price;

  Productconvertion({
    this.id,
    this.productId,
    this.unitId,
    this.nilai,
    this.nilaiTerkecil,
    this.baseUnitId,
    this.price,
  });

  factory Productconvertion.fromJson(String str) => Productconvertion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Productconvertion.fromMap(Map<String, dynamic> json) => Productconvertion(
    id: json["id"],
    productId: json["product_id"],
    unitId: json["unit_id"],
    nilai: json["nilai"],
    nilaiTerkecil: json["nilai_terkecil"],
    baseUnitId: json["base_unit_id"],
    price: json["price"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_id": productId,
    "unit_id": unitId,
    "nilai": nilai,
    "nilai_terkecil": nilaiTerkecil,
    "base_unit_id": baseUnitId,
    "price": price,
  };
}

class Unit {
  final int? id;
  final String? unitName;
  final String? unitCode;
  final String? unitDescription;
  final DateTime? createdAt;
  final int? createdBy;
  final DateTime? updatedAt;
  final int? updatedBy;

  Unit({
    this.id,
    this.unitName,
    this.unitCode,
    this.unitDescription,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  factory Unit.fromJson(String str) => Unit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Unit.fromMap(Map<String, dynamic> json) => Unit(
    id: json["id"],
    unitName: json["unit_name"],
    unitCode: json["unit_code"],
    unitDescription: json["unit_description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    updatedBy: json["updated_by"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "unit_name": unitName,
    "unit_code": unitCode,
    "unit_description": unitDescription,
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "updated_at": updatedAt?.toIso8601String(),
    "updated_by": updatedBy,
  };
}