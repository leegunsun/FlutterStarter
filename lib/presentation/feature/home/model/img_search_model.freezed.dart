// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'img_search_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImgSearchModel {

 String get lastBuildDate; num get total; num get start; num get display; List<SearchItemDto> get items;
/// Create a copy of ImgSearchModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImgSearchModelCopyWith<ImgSearchModel> get copyWith => _$ImgSearchModelCopyWithImpl<ImgSearchModel>(this as ImgSearchModel, _$identity);

  /// Serializes this ImgSearchModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImgSearchModel&&(identical(other.lastBuildDate, lastBuildDate) || other.lastBuildDate == lastBuildDate)&&(identical(other.total, total) || other.total == total)&&(identical(other.start, start) || other.start == start)&&(identical(other.display, display) || other.display == display)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lastBuildDate,total,start,display,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'ImgSearchModel(lastBuildDate: $lastBuildDate, total: $total, start: $start, display: $display, items: $items)';
}


}

/// @nodoc
abstract mixin class $ImgSearchModelCopyWith<$Res>  {
  factory $ImgSearchModelCopyWith(ImgSearchModel value, $Res Function(ImgSearchModel) _then) = _$ImgSearchModelCopyWithImpl;
@useResult
$Res call({
 String lastBuildDate, num total, num start, num display, List<SearchItemDto> items
});




}
/// @nodoc
class _$ImgSearchModelCopyWithImpl<$Res>
    implements $ImgSearchModelCopyWith<$Res> {
  _$ImgSearchModelCopyWithImpl(this._self, this._then);

  final ImgSearchModel _self;
  final $Res Function(ImgSearchModel) _then;

/// Create a copy of ImgSearchModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastBuildDate = null,Object? total = null,Object? start = null,Object? display = null,Object? items = null,}) {
  return _then(_self.copyWith(
lastBuildDate: null == lastBuildDate ? _self.lastBuildDate : lastBuildDate // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as num,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as num,display: null == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as num,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<SearchItemDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ImgSearchModel].
extension ImgSearchModelPatterns on ImgSearchModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImgSearchModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImgSearchModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImgSearchModel value)  $default,){
final _that = this;
switch (_that) {
case _ImgSearchModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImgSearchModel value)?  $default,){
final _that = this;
switch (_that) {
case _ImgSearchModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String lastBuildDate,  num total,  num start,  num display,  List<SearchItemDto> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImgSearchModel() when $default != null:
return $default(_that.lastBuildDate,_that.total,_that.start,_that.display,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String lastBuildDate,  num total,  num start,  num display,  List<SearchItemDto> items)  $default,) {final _that = this;
switch (_that) {
case _ImgSearchModel():
return $default(_that.lastBuildDate,_that.total,_that.start,_that.display,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String lastBuildDate,  num total,  num start,  num display,  List<SearchItemDto> items)?  $default,) {final _that = this;
switch (_that) {
case _ImgSearchModel() when $default != null:
return $default(_that.lastBuildDate,_that.total,_that.start,_that.display,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImgSearchModel implements ImgSearchModel {
  const _ImgSearchModel({required this.lastBuildDate, required this.total, required this.start, required this.display, required final  List<SearchItemDto> items}): _items = items;
  factory _ImgSearchModel.fromJson(Map<String, dynamic> json) => _$ImgSearchModelFromJson(json);

@override final  String lastBuildDate;
@override final  num total;
@override final  num start;
@override final  num display;
 final  List<SearchItemDto> _items;
@override List<SearchItemDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ImgSearchModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImgSearchModelCopyWith<_ImgSearchModel> get copyWith => __$ImgSearchModelCopyWithImpl<_ImgSearchModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImgSearchModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImgSearchModel&&(identical(other.lastBuildDate, lastBuildDate) || other.lastBuildDate == lastBuildDate)&&(identical(other.total, total) || other.total == total)&&(identical(other.start, start) || other.start == start)&&(identical(other.display, display) || other.display == display)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lastBuildDate,total,start,display,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ImgSearchModel(lastBuildDate: $lastBuildDate, total: $total, start: $start, display: $display, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ImgSearchModelCopyWith<$Res> implements $ImgSearchModelCopyWith<$Res> {
  factory _$ImgSearchModelCopyWith(_ImgSearchModel value, $Res Function(_ImgSearchModel) _then) = __$ImgSearchModelCopyWithImpl;
@override @useResult
$Res call({
 String lastBuildDate, num total, num start, num display, List<SearchItemDto> items
});




}
/// @nodoc
class __$ImgSearchModelCopyWithImpl<$Res>
    implements _$ImgSearchModelCopyWith<$Res> {
  __$ImgSearchModelCopyWithImpl(this._self, this._then);

  final _ImgSearchModel _self;
  final $Res Function(_ImgSearchModel) _then;

/// Create a copy of ImgSearchModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastBuildDate = null,Object? total = null,Object? start = null,Object? display = null,Object? items = null,}) {
  return _then(_ImgSearchModel(
lastBuildDate: null == lastBuildDate ? _self.lastBuildDate : lastBuildDate // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as num,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as num,display: null == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as num,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SearchItemDto>,
  ));
}


}

// dart format on
