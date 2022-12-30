import 'package:equatable/equatable.dart';

class AppLocation extends Equatable {
  final double lat;
  final double long;
  final String? address;
  final String? city;
  final String? state;
  final String? country;

  const AppLocation({
    required this.lat,
    required this.long,
    this.address,
    this.city,
    this.state,
    this.country,
  });

  @override
  List<Object> get props {
    return [
      lat,
      long,
    ];
  }

  @override
  String toString() {
    return 'AppLocation(lat: $lat, long: $long, address: $address, city: $city, state: $state, country: $country)';
  }
}
