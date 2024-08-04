class Contact {
  String name;
  String emailAddress;
  String phoneNumber;
  bool isFavourite;

  Contact({required this.name,required this.emailAddress,required this.phoneNumber,this.isFavourite=false});

  // Factory method to create a Contact object from Firestore document data
  factory Contact.fromFirestore(Map<String, dynamic> data) {
    return Contact(
      name: data['name'] ?? '',
      emailAddress: data['email'] ?? '',
      phoneNumber: data['phone'] ?? '',
    );
  }
}
