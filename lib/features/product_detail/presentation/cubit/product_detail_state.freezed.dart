// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductDetailState {

 int get quantity; int get selectedColorIndex;
/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailStateCopyWith<ProductDetailState> get copyWith => _$ProductDetailStateCopyWithImpl<ProductDetailState>(this as ProductDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailState&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.selectedColorIndex, selectedColorIndex) || other.selectedColorIndex == selectedColorIndex));
}


@override
int get hashCode => Object.hash(runtimeType,quantity,selectedColorIndex);

@override
String toString() {
  return 'ProductDetailState(quantity: $quantity, selectedColorIndex: $selectedColorIndex)';
}


}

/// @nodoc
abstract mixin class $ProductDetailStateCopyWith<$Res>  {
  factory $ProductDetailStateCopyWith(ProductDetailState value, $Res Function(ProductDetailState) _then) = _$ProductDetailStateCopyWithImpl;
@useResult
$Res call({
 int quantity, int selectedColorIndex
});




}
/// @nodoc
class _$ProductDetailStateCopyWithImpl<$Res>
    implements $ProductDetailStateCopyWith<$Res> {
  _$ProductDetailStateCopyWithImpl(this._self, this._then);

  final ProductDetailState _self;
  final $Res Function(ProductDetailState) _then;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quantity = null,Object? selectedColorIndex = null,}) {
  return _then(_self.copyWith(
quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,selectedColorIndex: null == selectedColorIndex ? _self.selectedColorIndex : selectedColorIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductDetailState].
extension ProductDetailStatePatterns on ProductDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _AddingToCart value)?  addingToCart,TResult Function( _AddedToCart value)?  addedToCart,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _AddingToCart() when addingToCart != null:
return addingToCart(_that);case _AddedToCart() when addedToCart != null:
return addedToCart(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _AddingToCart value)  addingToCart,required TResult Function( _AddedToCart value)  addedToCart,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _AddingToCart():
return addingToCart(_that);case _AddedToCart():
return addedToCart(_that);case _Failure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _AddingToCart value)?  addingToCart,TResult? Function( _AddedToCart value)?  addedToCart,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _AddingToCart() when addingToCart != null:
return addingToCart(_that);case _AddedToCart() when addedToCart != null:
return addedToCart(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int quantity,  int selectedColorIndex)?  initial,TResult Function( int quantity,  int selectedColorIndex)?  addingToCart,TResult Function( int quantity,  int selectedColorIndex)?  addedToCart,TResult Function( int quantity,  int selectedColorIndex)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.quantity,_that.selectedColorIndex);case _AddingToCart() when addingToCart != null:
return addingToCart(_that.quantity,_that.selectedColorIndex);case _AddedToCart() when addedToCart != null:
return addedToCart(_that.quantity,_that.selectedColorIndex);case _Failure() when failure != null:
return failure(_that.quantity,_that.selectedColorIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int quantity,  int selectedColorIndex)  initial,required TResult Function( int quantity,  int selectedColorIndex)  addingToCart,required TResult Function( int quantity,  int selectedColorIndex)  addedToCart,required TResult Function( int quantity,  int selectedColorIndex)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial(_that.quantity,_that.selectedColorIndex);case _AddingToCart():
return addingToCart(_that.quantity,_that.selectedColorIndex);case _AddedToCart():
return addedToCart(_that.quantity,_that.selectedColorIndex);case _Failure():
return failure(_that.quantity,_that.selectedColorIndex);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int quantity,  int selectedColorIndex)?  initial,TResult? Function( int quantity,  int selectedColorIndex)?  addingToCart,TResult? Function( int quantity,  int selectedColorIndex)?  addedToCart,TResult? Function( int quantity,  int selectedColorIndex)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.quantity,_that.selectedColorIndex);case _AddingToCart() when addingToCart != null:
return addingToCart(_that.quantity,_that.selectedColorIndex);case _AddedToCart() when addedToCart != null:
return addedToCart(_that.quantity,_that.selectedColorIndex);case _Failure() when failure != null:
return failure(_that.quantity,_that.selectedColorIndex);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ProductDetailState {
  const _Initial({this.quantity = 1, this.selectedColorIndex = 0});
  

@override@JsonKey() final  int quantity;
@override@JsonKey() final  int selectedColorIndex;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.selectedColorIndex, selectedColorIndex) || other.selectedColorIndex == selectedColorIndex));
}


@override
int get hashCode => Object.hash(runtimeType,quantity,selectedColorIndex);

@override
String toString() {
  return 'ProductDetailState.initial(quantity: $quantity, selectedColorIndex: $selectedColorIndex)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $ProductDetailStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 int quantity, int selectedColorIndex
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quantity = null,Object? selectedColorIndex = null,}) {
  return _then(_Initial(
quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,selectedColorIndex: null == selectedColorIndex ? _self.selectedColorIndex : selectedColorIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _AddingToCart implements ProductDetailState {
  const _AddingToCart({required this.quantity, required this.selectedColorIndex});
  

@override final  int quantity;
@override final  int selectedColorIndex;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddingToCartCopyWith<_AddingToCart> get copyWith => __$AddingToCartCopyWithImpl<_AddingToCart>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddingToCart&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.selectedColorIndex, selectedColorIndex) || other.selectedColorIndex == selectedColorIndex));
}


@override
int get hashCode => Object.hash(runtimeType,quantity,selectedColorIndex);

@override
String toString() {
  return 'ProductDetailState.addingToCart(quantity: $quantity, selectedColorIndex: $selectedColorIndex)';
}


}

/// @nodoc
abstract mixin class _$AddingToCartCopyWith<$Res> implements $ProductDetailStateCopyWith<$Res> {
  factory _$AddingToCartCopyWith(_AddingToCart value, $Res Function(_AddingToCart) _then) = __$AddingToCartCopyWithImpl;
@override @useResult
$Res call({
 int quantity, int selectedColorIndex
});




}
/// @nodoc
class __$AddingToCartCopyWithImpl<$Res>
    implements _$AddingToCartCopyWith<$Res> {
  __$AddingToCartCopyWithImpl(this._self, this._then);

  final _AddingToCart _self;
  final $Res Function(_AddingToCart) _then;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quantity = null,Object? selectedColorIndex = null,}) {
  return _then(_AddingToCart(
quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,selectedColorIndex: null == selectedColorIndex ? _self.selectedColorIndex : selectedColorIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _AddedToCart implements ProductDetailState {
  const _AddedToCart({required this.quantity, required this.selectedColorIndex});
  

@override final  int quantity;
@override final  int selectedColorIndex;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddedToCartCopyWith<_AddedToCart> get copyWith => __$AddedToCartCopyWithImpl<_AddedToCart>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddedToCart&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.selectedColorIndex, selectedColorIndex) || other.selectedColorIndex == selectedColorIndex));
}


@override
int get hashCode => Object.hash(runtimeType,quantity,selectedColorIndex);

@override
String toString() {
  return 'ProductDetailState.addedToCart(quantity: $quantity, selectedColorIndex: $selectedColorIndex)';
}


}

/// @nodoc
abstract mixin class _$AddedToCartCopyWith<$Res> implements $ProductDetailStateCopyWith<$Res> {
  factory _$AddedToCartCopyWith(_AddedToCart value, $Res Function(_AddedToCart) _then) = __$AddedToCartCopyWithImpl;
@override @useResult
$Res call({
 int quantity, int selectedColorIndex
});




}
/// @nodoc
class __$AddedToCartCopyWithImpl<$Res>
    implements _$AddedToCartCopyWith<$Res> {
  __$AddedToCartCopyWithImpl(this._self, this._then);

  final _AddedToCart _self;
  final $Res Function(_AddedToCart) _then;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quantity = null,Object? selectedColorIndex = null,}) {
  return _then(_AddedToCart(
quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,selectedColorIndex: null == selectedColorIndex ? _self.selectedColorIndex : selectedColorIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _Failure implements ProductDetailState {
  const _Failure({required this.quantity, required this.selectedColorIndex});
  

@override final  int quantity;
@override final  int selectedColorIndex;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.selectedColorIndex, selectedColorIndex) || other.selectedColorIndex == selectedColorIndex));
}


@override
int get hashCode => Object.hash(runtimeType,quantity,selectedColorIndex);

@override
String toString() {
  return 'ProductDetailState.failure(quantity: $quantity, selectedColorIndex: $selectedColorIndex)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $ProductDetailStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@override @useResult
$Res call({
 int quantity, int selectedColorIndex
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quantity = null,Object? selectedColorIndex = null,}) {
  return _then(_Failure(
quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,selectedColorIndex: null == selectedColorIndex ? _self.selectedColorIndex : selectedColorIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
