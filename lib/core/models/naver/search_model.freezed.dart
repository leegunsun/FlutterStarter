// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
  String get lastBuildDate;
  num get total;
  num get start;
  num get display;
  List<BlogSearchItems> get items;

  /// Create a copy of NaverApiBlogSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NaverApiBlogSearchModelCopyWith<NaverApiBlogSearchModel> get copyWith =>
      _$NaverApiBlogSearchModelCopyWithImpl<NaverApiBlogSearchModel>(
          this as NaverApiBlogSearchModel, _$identity);

  /// Serializes this NaverApiBlogSearchModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NaverApiBlogSearchModel &&
            (identical(other.lastBuildDate, lastBuildDate) ||
                other.lastBuildDate == lastBuildDate) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.display, display) || other.display == display) &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lastBuildDate, total, start,
      display, const DeepCollectionEquality().hash(items));

  @override
  String toString() {
    return 'NaverApiBlogSearchModel(lastBuildDate: $lastBuildDate, total: $total, start: $start, display: $display, items: $items)';
  }
}

/// @nodoc
abstract mixin class $NaverApiBlogSearchModelCopyWith<$Res> {
  factory $NaverApiBlogSearchModelCopyWith(NaverApiBlogSearchModel value,
          $Res Function(NaverApiBlogSearchModel) _then) =
      _$NaverApiBlogSearchModelCopyWithImpl;
  @useResult
  $Res call(
      {String lastBuildDate,
      num total,
      num start,
      num display,
      List<BlogSearchItems> items});
}

/// @nodoc
class _$NaverApiBlogSearchModelCopyWithImpl<$Res>
    implements $NaverApiBlogSearchModelCopyWith<$Res> {
  _$NaverApiBlogSearchModelCopyWithImpl(this._self, this._then);

  final NaverApiBlogSearchModel _self;
  final $Res Function(NaverApiBlogSearchModel) _then;

  /// Create a copy of NaverApiBlogSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastBuildDate = null,
    Object? total = null,
    Object? start = null,
    Object? display = null,
    Object? items = null,
  }) {
    return _then(_self.copyWith(
      lastBuildDate: null == lastBuildDate
          ? _self.lastBuildDate
          : lastBuildDate // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as num,
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as num,
      display: null == display
          ? _self.display
          : display // ignore: cast_nullable_to_non_nullable
              as num,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BlogSearchItems>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _NaverApiBlogSearchModel implements NaverApiBlogSearchModel {
  const _NaverApiBlogSearchModel(
      {required this.lastBuildDate,
      required this.total,
      required this.start,
      required this.display,
      required final List<BlogSearchItems> items})
      : _items = items;
  factory _NaverApiBlogSearchModel.fromJson(Map<String, dynamic> json) =>
      _$NaverApiBlogSearchModelFromJson(json);

  @override
  final String lastBuildDate;
  @override
  final num total;
  @override
  final num start;
  @override
  final num display;
  final List<BlogSearchItems> _items;
  @override
  List<BlogSearchItems> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of NaverApiBlogSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NaverApiBlogSearchModelCopyWith<_NaverApiBlogSearchModel> get copyWith =>
      __$NaverApiBlogSearchModelCopyWithImpl<_NaverApiBlogSearchModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NaverApiBlogSearchModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NaverApiBlogSearchModel &&
            (identical(other.lastBuildDate, lastBuildDate) ||
                other.lastBuildDate == lastBuildDate) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.display, display) || other.display == display) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lastBuildDate, total, start,
      display, const DeepCollectionEquality().hash(_items));

  @override
  String toString() {
    return 'NaverApiBlogSearchModel(lastBuildDate: $lastBuildDate, total: $total, start: $start, display: $display, items: $items)';
  }
}

/// @nodoc
abstract mixin class _$NaverApiBlogSearchModelCopyWith<$Res>
    implements $NaverApiBlogSearchModelCopyWith<$Res> {
  factory _$NaverApiBlogSearchModelCopyWith(_NaverApiBlogSearchModel value,
          $Res Function(_NaverApiBlogSearchModel) _then) =
      __$NaverApiBlogSearchModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String lastBuildDate,
      num total,
      num start,
      num display,
      List<BlogSearchItems> items});
}

/// @nodoc
class __$NaverApiBlogSearchModelCopyWithImpl<$Res>
    implements _$NaverApiBlogSearchModelCopyWith<$Res> {
  __$NaverApiBlogSearchModelCopyWithImpl(this._self, this._then);

  final _NaverApiBlogSearchModel _self;
  final $Res Function(_NaverApiBlogSearchModel) _then;

  /// Create a copy of NaverApiBlogSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lastBuildDate = null,
    Object? total = null,
    Object? start = null,
    Object? display = null,
    Object? items = null,
  }) {
    return _then(_NaverApiBlogSearchModel(
      lastBuildDate: null == lastBuildDate
          ? _self.lastBuildDate
          : lastBuildDate // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as num,
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as num,
      display: null == display
          ? _self.display
          : display // ignore: cast_nullable_to_non_nullable
              as num,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BlogSearchItems>,
    ));
  }
}

// dart format on
