// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NaverApiBlogSearchModel {

 String get lastBuildDate; num get total; num get start; num get display; List<BlogSearchItems> get items;
/// Create a copy of NaverApiBlogSearchModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NaverApiBlogSearchModelCopyWith<NaverApiBlogSearchModel> get copyWith => _$NaverApiBlogSearchModelCopyWithImpl<NaverApiBlogSearchModel>(this as NaverApiBlogSearchModel, _$identity);

  /// Serializes this NaverApiBlogSearchModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NaverApiBlogSearchModel&&(identical(other.lastBuildDate, lastBuildDate) || other.lastBuildDate == lastBuildDate)&&(identical(other.total, total) || other.total == total)&&(identical(other.start, start) || other.start == start)&&(identical(other.display, display) || other.display == display)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lastBuildDate,total,start,display,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'NaverApiBlogSearchModel(lastBuildDate: $lastBuildDate, total: $total, start: $start, display: $display, items: $items)';
}


}

/// @nodoc
abstract mixin class $NaverApiBlogSearchModelCopyWith<$Res>  {
  factory $NaverApiBlogSearchModelCopyWith(NaverApiBlogSearchModel value, $Res Function(NaverApiBlogSearchModel) _then) = _$NaverApiBlogSearchModelCopyWithImpl;
@useResult
$Res call({
 String lastBuildDate, num total, num start, num display, List<BlogSearchItems> items
});




}
/// @nodoc
class _$NaverApiBlogSearchModelCopyWithImpl<$Res>
    implements $NaverApiBlogSearchModelCopyWith<$Res> {
  _$NaverApiBlogSearchModelCopyWithImpl(this._self, this._then);

  final NaverApiBlogSearchModel _self;
  final $Res Function(NaverApiBlogSearchModel) _then;

/// Create a copy of NaverApiBlogSearchModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastBuildDate = null,Object? total = null,Object? start = null,Object? display = null,Object? items = null,}) {
  return _then(_self.copyWith(
lastBuildDate: null == lastBuildDate ? _self.lastBuildDate : lastBuildDate // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as num,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as num,display: null == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as num,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<BlogSearchItems>,
  ));
}

}


/// Adds pattern-matching-related methods to [NaverApiBlogSearchModel].
extension NaverApiBlogSearchModelPatterns on NaverApiBlogSearchModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NaverApiBlogSearchModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NaverApiBlogSearchModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NaverApiBlogSearchModel value)  $default,){
final _that = this;
switch (_that) {
case _NaverApiBlogSearchModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NaverApiBlogSearchModel value)?  $default,){
final _that = this;
switch (_that) {
case _NaverApiBlogSearchModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String lastBuildDate,  num total,  num start,  num display,  List<BlogSearchItems> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NaverApiBlogSearchModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String lastBuildDate,  num total,  num start,  num display,  List<BlogSearchItems> items)  $default,) {final _that = this;
switch (_that) {
case _NaverApiBlogSearchModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String lastBuildDate,  num total,  num start,  num display,  List<BlogSearchItems> items)?  $default,) {final _that = this;
switch (_that) {
case _NaverApiBlogSearchModel() when $default != null:
return $default(_that.lastBuildDate,_that.total,_that.start,_that.display,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NaverApiBlogSearchModel implements NaverApiBlogSearchModel {
  const _NaverApiBlogSearchModel({required this.lastBuildDate, required this.total, required this.start, required this.display, required final  List<BlogSearchItems> items}): _items = items;
  factory _NaverApiBlogSearchModel.fromJson(Map<String, dynamic> json) => _$NaverApiBlogSearchModelFromJson(json);

@override final  String lastBuildDate;
@override final  num total;
@override final  num start;
@override final  num display;
 final  List<BlogSearchItems> _items;
@override List<BlogSearchItems> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of NaverApiBlogSearchModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NaverApiBlogSearchModelCopyWith<_NaverApiBlogSearchModel> get copyWith => __$NaverApiBlogSearchModelCopyWithImpl<_NaverApiBlogSearchModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NaverApiBlogSearchModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NaverApiBlogSearchModel&&(identical(other.lastBuildDate, lastBuildDate) || other.lastBuildDate == lastBuildDate)&&(identical(other.total, total) || other.total == total)&&(identical(other.start, start) || other.start == start)&&(identical(other.display, display) || other.display == display)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lastBuildDate,total,start,display,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'NaverApiBlogSearchModel(lastBuildDate: $lastBuildDate, total: $total, start: $start, display: $display, items: $items)';
}


}

/// @nodoc
abstract mixin class _$NaverApiBlogSearchModelCopyWith<$Res> implements $NaverApiBlogSearchModelCopyWith<$Res> {
  factory _$NaverApiBlogSearchModelCopyWith(_NaverApiBlogSearchModel value, $Res Function(_NaverApiBlogSearchModel) _then) = __$NaverApiBlogSearchModelCopyWithImpl;
@override @useResult
$Res call({
 String lastBuildDate, num total, num start, num display, List<BlogSearchItems> items
});




}
/// @nodoc
class __$NaverApiBlogSearchModelCopyWithImpl<$Res>
    implements _$NaverApiBlogSearchModelCopyWith<$Res> {
  __$NaverApiBlogSearchModelCopyWithImpl(this._self, this._then);

  final _NaverApiBlogSearchModel _self;
  final $Res Function(_NaverApiBlogSearchModel) _then;

/// Create a copy of NaverApiBlogSearchModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastBuildDate = null,Object? total = null,Object? start = null,Object? display = null,Object? items = null,}) {
  return _then(_NaverApiBlogSearchModel(
lastBuildDate: null == lastBuildDate ? _self.lastBuildDate : lastBuildDate // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as num,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as num,display: null == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as num,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<BlogSearchItems>,
  ));
}


}

// dart format on
