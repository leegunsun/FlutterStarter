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
