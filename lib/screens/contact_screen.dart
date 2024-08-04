import 'package:contacts_app/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactScreen extends StatelessWidget {

  final Contact contact;
  const ContactScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Contact Details:', style: GoogleFonts.ubuntu(fontSize: 20.sp, fontWeight:FontWeight.bold,),),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15.sp,right: 15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.sp,),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Name = ', style: GoogleFonts.ubuntu(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.sp,),),
                    TextSpan(text: contact.name.toString(), style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 13.sp,),),
                  ]
                ),
              ),
              SizedBox(height: 10.sp,),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Email = ', style: GoogleFonts.ubuntu(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.sp,),),
                    TextSpan(text: contact.emailAddress.toString(), style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 13.sp,),),
                  ]
                ),
              ),
              SizedBox(height: 10.sp,),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Phone No. = ', style: GoogleFonts.ubuntu(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.sp,),),
                    TextSpan(text: contact.phoneNumber.toString(), style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 13.sp,),),
                  ]
                ),
              ),
              SizedBox(height: 10.sp,),
            ],
          ),
        ),
      ),
    );
  }
}
