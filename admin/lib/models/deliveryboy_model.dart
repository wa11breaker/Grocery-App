class DeliveryBoyModle {
  String name;
  String email;
  String id;
  DeliveryBoyModle({
    this.email,
    this.name,
    this.id,
  });
  DeliveryBoyModle.fromDoc(Map<String, dynamic> doc) {
    name = doc['name'];
    email = doc['email'];
    id = doc['id'];
  }
}
