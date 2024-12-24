class Address {
  late String street;
  late String number;
  late String neighborhood;
  int? postalCode;

  Address({
    required this.street, 
    required this.number, 
    required this.neighborhood,
    this.postalCode
    });
}