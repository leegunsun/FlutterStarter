// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blog_crawl_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CrawlContent {

 ContentType get contentType; String get contentValue;
/// Create a copy of CrawlContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlContentCopyWith<CrawlContent> get copyWith => _$CrawlContentCopyWithImpl<CrawlContent>(this as CrawlContent, _$identity);

  /// Serializes this CrawlContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlContent&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.contentValue, contentValue) || other.contentValue == contentValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contentType,contentValue);

@override
String toString() {
  return 'CrawlContent(contentType: $contentType, contentValue: $contentValue)';
}


}

/// @nodoc
abstract mixin class $CrawlContentCopyWith<$Res>  {
  factory $CrawlContentCopyWith(CrawlContent value, $Res Function(CrawlContent) _then) = _$CrawlContentCopyWithImpl;
@useResult
$Res call({
 ContentType contentType, String contentValue
});




}
/// @nodoc
class _$CrawlContentCopyWithImpl<$Res>
    implements $CrawlContentCopyWith<$Res> {
  _$CrawlContentCopyWithImpl(this._self, this._then);

  final CrawlContent _self;
  final $Res Function(CrawlContent) _then;

/// Create a copy of CrawlContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contentType = null,Object? contentValue = null,}) {
  return _then(_self.copyWith(
contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as ContentType,contentValue: null == contentValue ? _self.contentValue : contentValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CrawlContent].
extension CrawlContentPatterns on CrawlContent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CrawlContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CrawlContent() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CrawlContent value)  $default,){
final _that = this;
switch (_that) {
case _CrawlContent():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CrawlContent value)?  $default,){
final _that = this;
switch (_that) {
case _CrawlContent() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ContentType contentType,  String contentValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CrawlContent() when $default != null:
return $default(_that.contentType,_that.contentValue);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ContentType contentType,  String contentValue)  $default,) {final _that = this;
switch (_that) {
case _CrawlContent():
return $default(_that.contentType,_that.contentValue);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ContentType contentType,  String contentValue)?  $default,) {final _that = this;
switch (_that) {
case _CrawlContent() when $default != null:
return $default(_that.contentType,_that.contentValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CrawlContent implements CrawlContent {
  const _CrawlContent({required this.contentType, required this.contentValue});
  factory _CrawlContent.fromJson(Map<String, dynamic> json) => _$CrawlContentFromJson(json);

@override final  ContentType contentType;
@override final  String contentValue;

/// Create a copy of CrawlContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CrawlContentCopyWith<_CrawlContent> get copyWith => __$CrawlContentCopyWithImpl<_CrawlContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CrawlContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CrawlContent&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.contentValue, contentValue) || other.contentValue == contentValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contentType,contentValue);

@override
String toString() {
  return 'CrawlContent(contentType: $contentType, contentValue: $contentValue)';
}


}

/// @nodoc
abstract mixin class _$CrawlContentCopyWith<$Res> implements $CrawlContentCopyWith<$Res> {
  factory _$CrawlContentCopyWith(_CrawlContent value, $Res Function(_CrawlContent) _then) = __$CrawlContentCopyWithImpl;
@override @useResult
$Res call({
 ContentType contentType, String contentValue
});




}
/// @nodoc
class __$CrawlContentCopyWithImpl<$Res>
    implements _$CrawlContentCopyWith<$Res> {
  __$CrawlContentCopyWithImpl(this._self, this._then);

  final _CrawlContent _self;
  final $Res Function(_CrawlContent) _then;

/// Create a copy of CrawlContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contentType = null,Object? contentValue = null,}) {
  return _then(_CrawlContent(
contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as ContentType,contentValue: null == contentValue ? _self.contentValue : contentValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
