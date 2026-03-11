/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'package:eshop_client/src/protocol/protocol.dart' as _i2;

abstract class Product implements _i1.SerializableModel {
  Product._({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    this.images,
    this.sizes,
    this.colors,
    this.subcategoryId,
    required this.categoryId,
    required this.quantity,
    required this.isAvailable,
  });

  factory Product({
    int? id,
    required String name,
    required String description,
    required double price,
    required double discount,
    List<String>? images,
    List<String>? sizes,
    List<String>? colors,
    int? subcategoryId,
    required int categoryId,
    required int quantity,
    required bool isAvailable,
  }) = _ProductImpl;

  factory Product.fromJson(Map<String, dynamic> jsonSerialization) {
    return Product(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      price: (jsonSerialization['price'] as num).toDouble(),
      discount: (jsonSerialization['discount'] as num).toDouble(),
      images: jsonSerialization['images'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['images'],
            ),
      sizes: jsonSerialization['sizes'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['sizes'],
            ),
      colors: jsonSerialization['colors'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['colors'],
            ),
      subcategoryId: jsonSerialization['subcategoryId'] as int?,
      categoryId: jsonSerialization['categoryId'] as int,
      quantity: jsonSerialization['quantity'] as int,
      isAvailable: jsonSerialization['isAvailable'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String description;

  double price;

  double discount;

  List<String>? images;

  List<String>? sizes;

  List<String>? colors;

  int? subcategoryId;

  int categoryId;

  int quantity;

  bool isAvailable;

  /// Returns a shallow copy of this [Product]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    double? discount,
    List<String>? images,
    List<String>? sizes,
    List<String>? colors,
    int? subcategoryId,
    int? categoryId,
    int? quantity,
    bool? isAvailable,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Product',
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      if (images != null) 'images': images?.toJson(),
      if (sizes != null) 'sizes': sizes?.toJson(),
      if (colors != null) 'colors': colors?.toJson(),
      if (subcategoryId != null) 'subcategoryId': subcategoryId,
      'categoryId': categoryId,
      'quantity': quantity,
      'isAvailable': isAvailable,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProductImpl extends Product {
  _ProductImpl({
    int? id,
    required String name,
    required String description,
    required double price,
    required double discount,
    List<String>? images,
    List<String>? sizes,
    List<String>? colors,
    int? subcategoryId,
    required int categoryId,
    required int quantity,
    required bool isAvailable,
  }) : super._(
         id: id,
         name: name,
         description: description,
         price: price,
         discount: discount,
         images: images,
         sizes: sizes,
         colors: colors,
         subcategoryId: subcategoryId,
         categoryId: categoryId,
         quantity: quantity,
         isAvailable: isAvailable,
       );

  /// Returns a shallow copy of this [Product]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Product copyWith({
    Object? id = _Undefined,
    String? name,
    String? description,
    double? price,
    double? discount,
    Object? images = _Undefined,
    Object? sizes = _Undefined,
    Object? colors = _Undefined,
    Object? subcategoryId = _Undefined,
    int? categoryId,
    int? quantity,
    bool? isAvailable,
  }) {
    return Product(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      images: images is List<String>?
          ? images
          : this.images?.map((e0) => e0).toList(),
      sizes: sizes is List<String>?
          ? sizes
          : this.sizes?.map((e0) => e0).toList(),
      colors: colors is List<String>?
          ? colors
          : this.colors?.map((e0) => e0).toList(),
      subcategoryId: subcategoryId is int? ? subcategoryId : this.subcategoryId,
      categoryId: categoryId ?? this.categoryId,
      quantity: quantity ?? this.quantity,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
