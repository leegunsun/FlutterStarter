// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crawl_naver_blog_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CrawlNaverBlogModel {

 List<CrawlContent> get imgContents; String get desc;
/// Create a copy of CrawlNaverBlogModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlNaverBlogModelCopyWith<CrawlNaverBlogModel> get copyWith => _$CrawlNaverBlogModelCopyWithImpl<CrawlNaverBlogModel>(this as CrawlNaverBlogModel, _$identity);

  /// Serializes this CrawlNaverBlogModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlNaverBlogModel&&const DeepCollectionEquality().equals(other.imgContents, imgContents)&&(identical(other.desc, desc) || other.desc == desc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(imgContents),desc);

@override
String toString() {
  return 'CrawlNaverBlogModel(imgContents: $imgContents, desc: $desc)';
}


}

/// @nodoc
abstract mixin class $CrawlNaverBlogModelCopyWith<$Res>  {
  factory $CrawlNaverBlogModelCopyWith(CrawlNaverBlogModel value, $Res Function(CrawlNaverBlogModel) _then) = _$CrawlNaverBlogModelCopyWithImpl;
@useResult
$Res call({
 List<CrawlContent> imgContents, String desc
});




}
/// @nodoc
class _$CrawlNaverBlogModelCopyWithImpl<$Res>
    implements $CrawlNaverBlogModelCopyWith<$Res> {
  _$CrawlNaverBlogModelCopyWithImpl(this._self, this._then);

  final CrawlNaverBlogModel _self;
  final $Res Function(CrawlNaverBlogModel) _then;

/// Create a copy of CrawlNaverBlogModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imgContents = null,Object? desc = null,}) {
  return _then(_self.copyWith(
imgContents: null == imgContents ? _self.imgContents : imgContents // ignore: cast_nullable_to_non_nullable
as List<CrawlContent>,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CrawlNaverBlogModel].
extension CrawlNaverBlogModelPatterns on CrawlNaverBlogModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CrawlNaverBlogModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CrawlNaverBlogModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CrawlNaverBlogModel value)  $default,){
final _that = this;
switch (_that) {
case _CrawlNaverBlogModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CrawlNaverBlogModel value)?  $default,){
final _that = this;
switch (_that) {
case _CrawlNaverBlogModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CrawlContent> imgContents,  String desc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CrawlNaverBlogModel() when $default != null:
return $default(_that.imgContents,_that.desc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CrawlContent> imgContents,  String desc)  $default,) {final _that = this;
switch (_that) {
case _CrawlNaverBlogModel():
return $default(_that.imgContents,_that.desc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CrawlContent> imgContents,  String desc)?  $default,) {final _that = this;
switch (_that) {
case _CrawlNaverBlogModel() when $default != null:
return $default(_that.imgContents,_that.desc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CrawlNaverBlogModel implements CrawlNaverBlogModel {
  const _CrawlNaverBlogModel({required final  List<CrawlContent> imgContents, required this.desc}): _imgContents = imgContents;
  factory _CrawlNaverBlogModel.fromJson(Map<String, dynamic> json) => _$CrawlNaverBlogModelFromJson(json);

 final  List<CrawlContent> _imgContents;
@override List<CrawlContent> get imgContents {
  if (_imgContents is EqualUnmodifiableListView) return _imgContents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imgContents);
}

@override final  String desc;

/// Create a copy of CrawlNaverBlogModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CrawlNaverBlogModelCopyWith<_CrawlNaverBlogModel> get copyWith => __$CrawlNaverBlogModelCopyWithImpl<_CrawlNaverBlogModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CrawlNaverBlogModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CrawlNaverBlogModel&&const DeepCollectionEquality().equals(other._imgContents, _imgContents)&&(identical(other.desc, desc) || other.desc == desc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_imgContents),desc);

@override
String toString() {
  return 'CrawlNaverBlogModel(imgContents: $imgContents, desc: $desc)';
}


}

/// @nodoc
abstract mixin class _$CrawlNaverBlogModelCopyWith<$Res> implements $CrawlNaverBlogModelCopyWith<$Res> {
  factory _$CrawlNaverBlogModelCopyWith(_CrawlNaverBlogModel value, $Res Function(_CrawlNaverBlogModel) _then) = __$CrawlNaverBlogModelCopyWithImpl;
@override @useResult
$Res call({
 List<CrawlContent> imgContents, String desc
});




}
/// @nodoc
class __$CrawlNaverBlogModelCopyWithImpl<$Res>
    implements _$CrawlNaverBlogModelCopyWith<$Res> {
  __$CrawlNaverBlogModelCopyWithImpl(this._self, this._then);

  final _CrawlNaverBlogModel _self;
  final $Res Function(_CrawlNaverBlogModel) _then;

/// Create a copy of CrawlNaverBlogModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imgContents = null,Object? desc = null,}) {
  return _then(_CrawlNaverBlogModel(
imgContents: null == imgContents ? _self._imgContents : imgContents // ignore: cast_nullable_to_non_nullable
as List<CrawlContent>,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
