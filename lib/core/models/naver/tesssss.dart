import 'package:freezed_annotation/freezed_annotation.dart';


@freezed
abstract class Product with _$Product {
  const factory Product({
    required String name,
    required double price,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json)
  => _$ProductFromJson(json);
}