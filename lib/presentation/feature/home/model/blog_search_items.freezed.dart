// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blog_search_items.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BlogSearchItems {

 String get title; String get link; String? get thumnail; String? get blogMobileLink; String get description; String get bloggername; String get bloggerlink; String get postdate;
/// Create a copy of BlogSearchItems
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlogSearchItemsCopyWith<BlogSearchItems> get copyWith => _$BlogSearchItemsCopyWithImpl<BlogSearchItems>(this as BlogSearchItems, _$identity);

  /// Serializes this BlogSearchItems to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlogSearchItems&&(identical(other.title, title) || other.title == title)&&(identical(other.link, link) || other.link == link)&&(identical(other.thumnail, thumnail) || other.thumnail == thumnail)&&(identical(other.blogMobileLink, blogMobileLink) || other.blogMobileLink == blogMobileLink)&&(identical(other.description, description) || other.description == description)&&(identical(other.bloggername, bloggername) || other.bloggername == bloggername)&&(identical(other.bloggerlink, bloggerlink) || other.bloggerlink == bloggerlink)&&(identical(other.postdate, postdate) || other.postdate == postdate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,link,thumnail,blogMobileLink,description,bloggername,bloggerlink,postdate);

@override
String toString() {
  return 'BlogSearchItems(title: $title, link: $link, thumnail: $thumnail, blogMobileLink: $blogMobileLink, description: $description, bloggername: $bloggername, bloggerlink: $bloggerlink, postdate: $postdate)';
}


}

/// @nodoc
abstract mixin class $BlogSearchItemsCopyWith<$Res>  {
  factory $BlogSearchItemsCopyWith(BlogSearchItems value, $Res Function(BlogSearchItems) _then) = _$BlogSearchItemsCopyWithImpl;
@useResult
$Res call({
 String title, String link, String? thumnail, String? blogMobileLink, String description, String bloggername, String bloggerlink, String postdate
});




}
/// @nodoc
class _$BlogSearchItemsCopyWithImpl<$Res>
    implements $BlogSearchItemsCopyWith<$Res> {
  _$BlogSearchItemsCopyWithImpl(this._self, this._then);

  final BlogSearchItems _self;
  final $Res Function(BlogSearchItems) _then;

/// Create a copy of BlogSearchItems
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? link = null,Object? thumnail = freezed,Object? blogMobileLink = freezed,Object? description = null,Object? bloggername = null,Object? bloggerlink = null,Object? postdate = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,thumnail: freezed == thumnail ? _self.thumnail : thumnail // ignore: cast_nullable_to_non_nullable
as String?,blogMobileLink: freezed == blogMobileLink ? _self.blogMobileLink : blogMobileLink // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,bloggername: null == bloggername ? _self.bloggername : bloggername // ignore: cast_nullable_to_non_nullable
as String,bloggerlink: null == bloggerlink ? _self.bloggerlink : bloggerlink // ignore: cast_nullable_to_non_nullable
as String,postdate: null == postdate ? _self.postdate : postdate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BlogSearchItems].
extension BlogSearchItemsPatterns on BlogSearchItems {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlogSearchItems value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlogSearchItems() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlogSearchItems value)  $default,){
final _that = this;
switch (_that) {
case _BlogSearchItems():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlogSearchItems value)?  $default,){
final _that = this;
switch (_that) {
case _BlogSearchItems() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String link,  String? thumnail,  String? blogMobileLink,  String description,  String bloggername,  String bloggerlink,  String postdate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlogSearchItems() when $default != null:
return $default(_that.title,_that.link,_that.thumnail,_that.blogMobileLink,_that.description,_that.bloggername,_that.bloggerlink,_that.postdate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String link,  String? thumnail,  String? blogMobileLink,  String description,  String bloggername,  String bloggerlink,  String postdate)  $default,) {final _that = this;
switch (_that) {
case _BlogSearchItems():
return $default(_that.title,_that.link,_that.thumnail,_that.blogMobileLink,_that.description,_that.bloggername,_that.bloggerlink,_that.postdate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String link,  String? thumnail,  String? blogMobileLink,  String description,  String bloggername,  String bloggerlink,  String postdate)?  $default,) {final _that = this;
switch (_that) {
case _BlogSearchItems() when $default != null:
return $default(_that.title,_that.link,_that.thumnail,_that.blogMobileLink,_that.description,_that.bloggername,_that.bloggerlink,_that.postdate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlogSearchItems implements BlogSearchItems {
  const _BlogSearchItems({required this.title, required this.link, this.thumnail, this.blogMobileLink, required this.description, required this.bloggername, required this.bloggerlink, required this.postdate});
  factory _BlogSearchItems.fromJson(Map<String, dynamic> json) => _$BlogSearchItemsFromJson(json);

@override final  String title;
@override final  String link;
@override final  String? thumnail;
@override final  String? blogMobileLink;
@override final  String description;
@override final  String bloggername;
@override final  String bloggerlink;
@override final  String postdate;

/// Create a copy of BlogSearchItems
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlogSearchItemsCopyWith<_BlogSearchItems> get copyWith => __$BlogSearchItemsCopyWithImpl<_BlogSearchItems>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlogSearchItemsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlogSearchItems&&(identical(other.title, title) || other.title == title)&&(identical(other.link, link) || other.link == link)&&(identical(other.thumnail, thumnail) || other.thumnail == thumnail)&&(identical(other.blogMobileLink, blogMobileLink) || other.blogMobileLink == blogMobileLink)&&(identical(other.description, description) || other.description == description)&&(identical(other.bloggername, bloggername) || other.bloggername == bloggername)&&(identical(other.bloggerlink, bloggerlink) || other.bloggerlink == bloggerlink)&&(identical(other.postdate, postdate) || other.postdate == postdate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,link,thumnail,blogMobileLink,description,bloggername,bloggerlink,postdate);

@override
String toString() {
  return 'BlogSearchItems(title: $title, link: $link, thumnail: $thumnail, blogMobileLink: $blogMobileLink, description: $description, bloggername: $bloggername, bloggerlink: $bloggerlink, postdate: $postdate)';
}


}

/// @nodoc
abstract mixin class _$BlogSearchItemsCopyWith<$Res> implements $BlogSearchItemsCopyWith<$Res> {
  factory _$BlogSearchItemsCopyWith(_BlogSearchItems value, $Res Function(_BlogSearchItems) _then) = __$BlogSearchItemsCopyWithImpl;
@override @useResult
$Res call({
 String title, String link, String? thumnail, String? blogMobileLink, String description, String bloggername, String bloggerlink, String postdate
});




}
/// @nodoc
class __$BlogSearchItemsCopyWithImpl<$Res>
    implements _$BlogSearchItemsCopyWith<$Res> {
  __$BlogSearchItemsCopyWithImpl(this._self, this._then);

  final _BlogSearchItems _self;
  final $Res Function(_BlogSearchItems) _then;

/// Create a copy of BlogSearchItems
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? link = null,Object? thumnail = freezed,Object? blogMobileLink = freezed,Object? description = null,Object? bloggername = null,Object? bloggerlink = null,Object? postdate = null,}) {
  return _then(_BlogSearchItems(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,thumnail: freezed == thumnail ? _self.thumnail : thumnail // ignore: cast_nullable_to_non_nullable
as String?,blogMobileLink: freezed == blogMobileLink ? _self.blogMobileLink : blogMobileLink // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,bloggername: null == bloggername ? _self.bloggername : bloggername // ignore: cast_nullable_to_non_nullable
as String,bloggerlink: null == bloggerlink ? _self.bloggerlink : bloggerlink // ignore: cast_nullable_to_non_nullable
as String,postdate: null == postdate ? _self.postdate : postdate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
