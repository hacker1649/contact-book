import 'package:contacts_app/provider/contact_provider.dart';
import 'package:contacts_app/widgets/add_contact.dart';
import 'package:contacts_app/widgets/contact_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    setState(() { isloading = true; });
    await Provider.of<ContactProvider>(context, listen: false).fetchContacts();
    setState(() { isloading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Contacts', style: GoogleFonts.ubuntu(fontSize: 20.sp,fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: Icon(Icons.person_add,),
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(builder: ((context) => AddContactScreen())));
              },
            ),
          ],
        ),
        body: Consumer<ContactProvider>(builder: (context,value,child){
          return Center(
            child: isloading
              ? CircularProgressIndicator()
              : value.contacts.isEmpty
                ? Text('No Contacts found',style: GoogleFonts.ubuntu(fontSize: 15.sp,fontWeight: FontWeight.bold),)
                : ContactList(contacts: value.contacts),
          );
        }),
      ),
    );
  }
}