// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchItemDto {

 String get title; String get link; String get thumbnail; String get sizeheight; String get sizewidth;
/// Create a copy of SearchItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchItemDtoCopyWith<SearchItemDto> get copyWith => _$SearchItemDtoCopyWithImpl<SearchItemDto>(this as SearchItemDto, _$identity);

  /// Serializes this SearchItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchItemDto&&(identical(other.title, title) || other.title == title)&&(identical(other.link, link) || other.link == link)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.sizeheight, sizeheight) || other.sizeheight == sizeheight)&&(identical(other.sizewidth, sizewidth) || other.sizewidth == sizewidth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,link,thumbnail,sizeheight,sizewidth);

@override
String toString() {
  return 'SearchItemDto(title: $title, link: $link, thumbnail: $thumbnail, sizeheight: $sizeheight, sizewidth: $sizewidth)';
}


}

/// @nodoc
abstract mixin class $SearchItemDtoCopyWith<$Res>  {
  factory $SearchItemDtoCopyWith(SearchItemDto value, $Res Function(SearchItemDto) _then) = _$SearchItemDtoCopyWithImpl;
@useResult
$Res call({
 String title, String link, String thumbnail, String sizeheight, String sizewidth
});




}
/// @nodoc
class _$SearchItemDtoCopyWithImpl<$Res>
    implements $SearchItemDtoCopyWith<$Res> {
  _$SearchItemDtoCopyWithImpl(this._self, this._then);

  final SearchItemDto _self;
  final $Res Function(SearchItemDto) _then;

/// Create a copy of SearchItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? link = null,Object? thumbnail = null,Object? sizeheight = null,Object? sizewidth = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,sizeheight: null == sizeheight ? _self.sizeheight : sizeheight // ignore: cast_nullable_to_non_nullable
as String,sizewidth: null == sizewidth ? _self.sizewidth : sizewidth // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchItemDto].
extension SearchItemDtoPatterns on SearchItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchItemDto value)  $default,){
final _that = this;
switch (_that) {
case _SearchItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _SearchItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String link,  String thumbnail,  String sizeheight,  String sizewidth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchItemDto() when $default != null:
return $default(_that.title,_that.link,_that.thumbnail,_that.sizeheight,_that.sizewidth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String link,  String thumbnail,  String sizeheight,  String sizewidth)  $default,) {final _that = this;
switch (_that) {
case _SearchItemDto():
return $default(_that.title,_that.link,_that.thumbnail,_that.sizeheight,_that.sizewidth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String link,  String thumbnail,  String sizeheight,  String sizewidth)?  $default,) {final _that = this;
switch (_that) {
case _SearchItemDto() when $default != null:
return $default(_that.title,_that.link,_that.thumbnail,_that.sizeheight,_that.sizewidth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchItemDto implements SearchItemDto {
  const _SearchItemDto({required this.title, required this.link, required this.thumbnail, required this.sizeheight, required this.sizewidth});
  factory _SearchItemDto.fromJson(Map<String, dynamic> json) => _$SearchItemDtoFromJson(json);

@override final  String title;
@override final  String link;
@override final  String thumbnail;
@override final  String sizeheight;
@override final  String sizewidth;

/// Create a copy of SearchItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchItemDtoCopyWith<_SearchItemDto> get copyWith => __$SearchItemDtoCopyWithImpl<_SearchItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchItemDto&&(identical(other.title, title) || other.title == title)&&(identical(other.link, link) || other.link == link)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.sizeheight, sizeheight) || other.sizeheight == sizeheight)&&(identical(other.sizewidth, sizewidth) || other.sizewidth == sizewidth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,link,thumbnail,sizeheight,sizewidth);

@override
String toString() {
  return 'SearchItemDto(title: $title, link: $link, thumbnail: $thumbnail, sizeheight: $sizeheight, sizewidth: $sizewidth)';
}


}

/// @nodoc
abstract mixin class _$SearchItemDtoCopyWith<$Res> implements $SearchItemDtoCopyWith<$Res> {
  factory _$SearchItemDtoCopyWith(_SearchItemDto value, $Res Function(_SearchItemDto) _then) = __$SearchItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String title, String link, String thumbnail, String sizeheight, String sizewidth
});




}
/// @nodoc
class __$SearchItemDtoCopyWithImpl<$Res>
    implements _$SearchItemDtoCopyWith<$Res> {
  __$SearchItemDtoCopyWithImpl(this._self, this._then);

  final _SearchItemDto _self;
  final $Res Function(_SearchItemDto) _then;

/// Create a copy of SearchItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? link = null,Object? thumbnail = null,Object? sizeheight = null,Object? sizewidth = null,}) {
  return _then(_SearchItemDto(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,sizeheight: null == sizeheight ? _self.sizeheight : sizeheight // ignore: cast_nullable_to_non_nullable
as String,sizewidth: null == sizewidth ? _self.sizewidth : sizewidth // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
