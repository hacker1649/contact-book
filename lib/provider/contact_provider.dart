import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_app/models/contact.dart';
import 'package:flutter/material.dart';

class ContactProvider with ChangeNotifier{
  final List<Contact> _contacts=[];
  List<Contact> get contacts => _contacts;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch contacts from Firebase Firestore
  Future<void> fetchContacts() async {
    try{
      QuerySnapshot snapshot = await _firestore.collection('contacts').orderBy('timestamp').get();
      _contacts.clear(); // Clear existing contacts
      for(var doc in snapshot.docs) {
        _contacts.add(Contact.fromFirestore(doc.data() as Map<String, dynamic>));
      }
      _sortContacts(); // Sort contacts after fetching
      notifyListeners();
    }catch(e) {
      print("Error fetching contacts: $e");
    }
  }

  // Add a new contact to Firebase Firestore and the local list
  Future<void> addContact(Contact contact) async {
    try{
      await _firestore.collection('contacts').add({
        'name': contact.name,
        'email': contact.emailAddress,
        'phone': contact.phoneNumber,
        'timestamp': FieldValue.serverTimestamp(),
      });
      // After adding, fetch contacts again to include the new contact
      fetchContacts();
    }catch(e) {
      print("Error adding contact: $e");
    }
  }

  //setter for changing the favourite status 
  void changeFavouriteStatus(int index){
    _contacts[index].isFavourite=!_contacts[index].isFavourite;
    _sortContacts();
    notifyListeners();
  }
  
  //sort all the contacts 
  void _sortContacts(){
    _contacts.sort((a, b){
      int comparisonResult;
      //primarily sorting based on whether or not the contact is favorited 
      comparisonResult=_compareBasedOnFavouriteStatus(a, b);
      //if the favorite status of the two contacts are identical means equal to zero
      //then the alphabetical sorting kicks in...
      if(comparisonResult==0){
        comparisonResult=_compareAlphabetically(a, b);
      }
      return comparisonResult;
    });
  }
  
  //comparison between two contacts based on the favourite status of that contacts
  int _compareBasedOnFavouriteStatus(Contact a, Contact b){
    if(a.isFavourite){
      return -1; // contactOne will be before contactTwo
    }else if(b.isFavourite){
      return 1; // contactOne will be after contactTwo
    }else{
      return 0; // the position doesn't change
    }
  }
  
  //comparison between two contacts based on the alphabetical manner
  int _compareAlphabetically(Contact a, Contact b){
    return a.name.compareTo(b.name);
  }
}
