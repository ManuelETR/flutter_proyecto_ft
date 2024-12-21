class Address {
  final String street;
  final String number;
  final String neighborhood;
  int? postalCode;

  Address({
    required this.street, 
    required this.number, 
    required this.neighborhood,
    this.postalCode
    });
}