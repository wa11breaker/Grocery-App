class Address {
  String address;
  String name;
  String phone;
  Address({this.address, this.name, this.phone});
  factory Address.formMap(Map data) {
    return Address(
      address: data['address'],
      name: data['name'],
      phone: data['phone'],
    );
  }
}
