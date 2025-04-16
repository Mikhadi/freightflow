class Order {
  final String from;
  final String to;
  final int numberOfVehicles;
  final bool completed;
  final List<String> drivers;

  Order({
    required this.from,
    required this.to,
    required this.numberOfVehicles,
    this.completed = false,
    required this.drivers,
  });

  // factory method to create from JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      from: json['from'],
      to: json['to'],
      numberOfVehicles: json['numberOfVehicles'],
      completed: json['completed'] ?? false,
      drivers: List<String>.from(json['drivers']),
    );
  }

  // convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      'numberOfVehicles': numberOfVehicles,
      'completed': completed,
      'drivers': drivers,
    };
  }
}