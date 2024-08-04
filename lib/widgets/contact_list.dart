import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/provider/contact_provider.dart';
import 'package:contacts_app/screens/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key, required this.contacts});

  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(5.sp),
      physics: ScrollPhysics(),
      itemCount: contacts.length,
      itemBuilder: ((context, index) {
        return GestureDetector(
          onTap: () async{
            await Navigator.of(context).push(MaterialPageRoute(builder: ((context) => ContactScreen(contact: contacts[index],))));
          },
          child: Card(
            color: Color.fromRGBO(0,0,120,1.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
            shadowColor: Colors.black,
            elevation: 3.sp,
            child: Consumer<ContactProvider>(builder: (context,value,child){
              return ListTile(
                leading: Icon(Icons.person_rounded, color: Colors.white,),
                title: Text(value.contacts[index].name, style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold, fontSize: 14.sp, color: Colors.white,),),
                subtitle: Text(value.contacts[index].emailAddress, style: GoogleFonts.ubuntu(fontWeight: FontWeight.normal, fontSize: 12.sp, color: Colors.white,),),
                trailing: IconButton(
                  icon: Icon(value.contacts[index].isFavourite ? Icons.star_rounded : Icons.star_border_rounded, color: Colors.white,),
                  onPressed: (){
                    value.changeFavouriteStatus(index);
                  },
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
