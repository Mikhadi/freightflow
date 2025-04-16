import 'dart:io';

class Vehicle {
  String? make;
  String? model;
  String? vin;
  String? plateNumber;
  String? imageUrl;
  File? image;

  Vehicle();

  Vehicle.withData({
    required this.make,
    required this.model,
    this.vin,
    this.plateNumber,
    required this.imageUrl,
  }) : assert(vin != null || plateNumber != null,
        'Either VIN or Plate Number must be provided');

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    final vin = json['vin'];
    final plate = json['plateNumber'];
    assert(vin != null || plate != null,
        'Either VIN or Plate Number must be provided');

    return Vehicle.withData(
      make: json['make'],
      model: json['model'],
      vin: vin,
      plateNumber: plate,
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'make': make,
        'model': model,
        'vin': vin,
        'plateNumber': plateNumber,
        'imageUrl': imageUrl,
      };
}