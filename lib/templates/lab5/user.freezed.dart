// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  Address get address => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get website => throw _privateConstructorUsedError;
  Company get company => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {int id,
      String name,
      String username,
      String email,
      Address address,
      String phone,
      String website,
      Company company});

  $AddressCopyWith<$Res> get address;
  $CompanyCopyWith<$Res> get company;
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? username = null,
    Object? email = null,
    Object? address = null,
    Object? phone = null,
    Object? website = null,
    Object? company = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      website: null == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CompanyCopyWith<$Res> get company {
    return $CompanyCopyWith<$Res>(_value.company, (value) {
      return _then(_value.copyWith(company: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String username,
      String email,
      Address address,
      String phone,
      String website,
      Company company});

  @override
  $AddressCopyWith<$Res> get address;
  @override
  $CompanyCopyWith<$Res> get company;
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? username = null,
    Object? email = null,
    Object? address = null,
    Object? phone = null,
    Object? website = null,
    Object? company = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      website: null == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  _$UserImpl(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.address,
      required this.phone,
      required this.website,
      required this.company});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String username;
  @override
  final String email;
  @override
  final Address address;
  @override
  final String phone;
  @override
  final String website;
  @override
  final Company company;

  @override
  String toString() {
    return 'User(id: $id, name: $name, username: $username, email: $email, address: $address, phone: $phone, website: $website, company: $company)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.company, company) || other.company == company));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, username, email, address, phone, website, company);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  factory _User(
      {required final int id,
      required final String name,
      required final String username,
      required final String email,
      required final Address address,
      required final String phone,
      required final String website,
      required final Company company}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get username;
  @override
  String get email;
  @override
  Address get address;
  @override
  String get phone;
  @override
  String get website;
  @override
  Company get company;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Address _$AddressFromJson(Map<String, dynamic> json) {
  return _Address.fromJson(json);
}

/// @nodoc
mixin _$Address {
  String get street => throw _privateConstructorUsedError;
  String get suite => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get zipcode => throw _privateConstructorUsedError;
  Geolocation get geolocation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call(
      {String street,
      String suite,
      String city,
      String zipcode,
      Geolocation geolocation});

  $GeolocationCopyWith<$Res> get geolocation;
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = null,
    Object? suite = null,
    Object? city = null,
    Object? zipcode = null,
    Object? geolocation = null,
  }) {
    return _then(_value.copyWith(
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      suite: null == suite
          ? _value.suite
          : suite // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      zipcode: null == zipcode
          ? _value.zipcode
          : zipcode // ignore: cast_nullable_to_non_nullable
              as String,
      geolocation: null == geolocation
          ? _value.geolocation
          : geolocation // ignore: cast_nullable_to_non_nullable
              as Geolocation,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GeolocationCopyWith<$Res> get geolocation {
    return $GeolocationCopyWith<$Res>(_value.geolocation, (value) {
      return _then(_value.copyWith(geolocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddressImplCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$AddressImplCopyWith(
          _$AddressImpl value, $Res Function(_$AddressImpl) then) =
      __$$AddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String street,
      String suite,
      String city,
      String zipcode,
      Geolocation geolocation});

  @override
  $GeolocationCopyWith<$Res> get geolocation;
}

/// @nodoc
class __$$AddressImplCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$AddressImpl>
    implements _$$AddressImplCopyWith<$Res> {
  __$$AddressImplCopyWithImpl(
      _$AddressImpl _value, $Res Function(_$AddressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = null,
    Object? suite = null,
    Object? city = null,
    Object? zipcode = null,
    Object? geolocation = null,
  }) {
    return _then(_$AddressImpl(
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      suite: null == suite
          ? _value.suite
          : suite // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      zipcode: null == zipcode
          ? _value.zipcode
          : zipcode // ignore: cast_nullable_to_non_nullable
              as String,
      geolocation: null == geolocation
          ? _value.geolocation
          : geolocation // ignore: cast_nullable_to_non_nullable
              as Geolocation,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressImpl implements _Address {
  _$AddressImpl(
      {required this.street,
      required this.suite,
      required this.city,
      required this.zipcode,
      required this.geolocation});

  factory _$AddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressImplFromJson(json);

  @override
  final String street;
  @override
  final String suite;
  @override
  final String city;
  @override
  final String zipcode;
  @override
  final Geolocation geolocation;

  @override
  String toString() {
    return 'Address(street: $street, suite: $suite, city: $city, zipcode: $zipcode, geolocation: $geolocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressImpl &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.suite, suite) || other.suite == suite) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.zipcode, zipcode) || other.zipcode == zipcode) &&
            (identical(other.geolocation, geolocation) ||
                other.geolocation == geolocation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, street, suite, city, zipcode, geolocation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      __$$AddressImplCopyWithImpl<_$AddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressImplToJson(
      this,
    );
  }
}

abstract class _Address implements Address {
  factory _Address(
      {required final String street,
      required final String suite,
      required final String city,
      required final String zipcode,
      required final Geolocation geolocation}) = _$AddressImpl;

  factory _Address.fromJson(Map<String, dynamic> json) = _$AddressImpl.fromJson;

  @override
  String get street;
  @override
  String get suite;
  @override
  String get city;
  @override
  String get zipcode;
  @override
  Geolocation get geolocation;
  @override
  @JsonKey(ignore: true)
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Geolocation _$GeolocationFromJson(Map<String, dynamic> json) {
  return _Geolocation.fromJson(json);
}

/// @nodoc
mixin _$Geolocation {
  String get lat => throw _privateConstructorUsedError;
  String get lng => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeolocationCopyWith<Geolocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeolocationCopyWith<$Res> {
  factory $GeolocationCopyWith(
          Geolocation value, $Res Function(Geolocation) then) =
      _$GeolocationCopyWithImpl<$Res, Geolocation>;
  @useResult
  $Res call({String lat, String lng});
}

/// @nodoc
class _$GeolocationCopyWithImpl<$Res, $Val extends Geolocation>
    implements $GeolocationCopyWith<$Res> {
  _$GeolocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
  }) {
    return _then(_value.copyWith(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeolocationImplCopyWith<$Res>
    implements $GeolocationCopyWith<$Res> {
  factory _$$GeolocationImplCopyWith(
          _$GeolocationImpl value, $Res Function(_$GeolocationImpl) then) =
      __$$GeolocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String lat, String lng});
}

/// @nodoc
class __$$GeolocationImplCopyWithImpl<$Res>
    extends _$GeolocationCopyWithImpl<$Res, _$GeolocationImpl>
    implements _$$GeolocationImplCopyWith<$Res> {
  __$$GeolocationImplCopyWithImpl(
      _$GeolocationImpl _value, $Res Function(_$GeolocationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
  }) {
    return _then(_$GeolocationImpl(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeolocationImpl implements _Geolocation {
  _$GeolocationImpl({required this.lat, required this.lng});

  factory _$GeolocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeolocationImplFromJson(json);

  @override
  final String lat;
  @override
  final String lng;

  @override
  String toString() {
    return 'Geolocation(lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeolocationImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeolocationImplCopyWith<_$GeolocationImpl> get copyWith =>
      __$$GeolocationImplCopyWithImpl<_$GeolocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeolocationImplToJson(
      this,
    );
  }
}

abstract class _Geolocation implements Geolocation {
  factory _Geolocation({required final String lat, required final String lng}) =
      _$GeolocationImpl;

  factory _Geolocation.fromJson(Map<String, dynamic> json) =
      _$GeolocationImpl.fromJson;

  @override
  String get lat;
  @override
  String get lng;
  @override
  @JsonKey(ignore: true)
  _$$GeolocationImplCopyWith<_$GeolocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return _Company.fromJson(json);
}

/// @nodoc
mixin _$Company {
  String get name => throw _privateConstructorUsedError;
  String get catchPhrase => throw _privateConstructorUsedError;
  String get bs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyCopyWith<Company> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyCopyWith<$Res> {
  factory $CompanyCopyWith(Company value, $Res Function(Company) then) =
      _$CompanyCopyWithImpl<$Res, Company>;
  @useResult
  $Res call({String name, String catchPhrase, String bs});
}

/// @nodoc
class _$CompanyCopyWithImpl<$Res, $Val extends Company>
    implements $CompanyCopyWith<$Res> {
  _$CompanyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? catchPhrase = null,
    Object? bs = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      catchPhrase: null == catchPhrase
          ? _value.catchPhrase
          : catchPhrase // ignore: cast_nullable_to_non_nullable
              as String,
      bs: null == bs
          ? _value.bs
          : bs // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompanyImplCopyWith<$Res> implements $CompanyCopyWith<$Res> {
  factory _$$CompanyImplCopyWith(
          _$CompanyImpl value, $Res Function(_$CompanyImpl) then) =
      __$$CompanyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String catchPhrase, String bs});
}

/// @nodoc
class __$$CompanyImplCopyWithImpl<$Res>
    extends _$CompanyCopyWithImpl<$Res, _$CompanyImpl>
    implements _$$CompanyImplCopyWith<$Res> {
  __$$CompanyImplCopyWithImpl(
      _$CompanyImpl _value, $Res Function(_$CompanyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? catchPhrase = null,
    Object? bs = null,
  }) {
    return _then(_$CompanyImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      catchPhrase: null == catchPhrase
          ? _value.catchPhrase
          : catchPhrase // ignore: cast_nullable_to_non_nullable
              as String,
      bs: null == bs
          ? _value.bs
          : bs // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyImpl implements _Company {
  _$CompanyImpl(
      {required this.name, required this.catchPhrase, required this.bs});

  factory _$CompanyImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyImplFromJson(json);

  @override
  final String name;
  @override
  final String catchPhrase;
  @override
  final String bs;

  @override
  String toString() {
    return 'Company(name: $name, catchPhrase: $catchPhrase, bs: $bs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.catchPhrase, catchPhrase) ||
                other.catchPhrase == catchPhrase) &&
            (identical(other.bs, bs) || other.bs == bs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, catchPhrase, bs);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyImplCopyWith<_$CompanyImpl> get copyWith =>
      __$$CompanyImplCopyWithImpl<_$CompanyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyImplToJson(
      this,
    );
  }
}

abstract class _Company implements Company {
  factory _Company(
      {required final String name,
      required final String catchPhrase,
      required final String bs}) = _$CompanyImpl;

  factory _Company.fromJson(Map<String, dynamic> json) = _$CompanyImpl.fromJson;

  @override
  String get name;
  @override
  String get catchPhrase;
  @override
  String get bs;
  @override
  @JsonKey(ignore: true)
  _$$CompanyImplCopyWith<_$CompanyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
