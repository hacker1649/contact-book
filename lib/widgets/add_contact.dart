import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddContactScreen extends StatelessWidget {
  const AddContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Add Contact', style: GoogleFonts.ubuntu(fontSize: 20.sp,fontWeight: FontWeight.bold)),
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 15.h,),
                TextField(
                  controller: nameController, 
                  decoration: InputDecoration(
                    hintText: 'Contact Name',
                    hintStyle: GoogleFonts.ubuntu(fontSize: 12.sp,fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.w),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.w),
                    ),
                  ),
                  style: GoogleFonts.ubuntu(fontSize: 12.sp,fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 10.h,),
                TextField(
                  controller: emailController, 
                  decoration: InputDecoration(
                    hintText: 'Contact Email',
                    hintStyle: GoogleFonts.ubuntu(fontSize: 12.sp,fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.w),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.w),
                    ),
                  ),
                  style: GoogleFonts.ubuntu(fontSize: 12.sp,fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 10.h,),
                TextField(
                  controller: phoneController, 
                  decoration: InputDecoration(
                    hintText: 'Contact Phone No.',
                    hintStyle: GoogleFonts.ubuntu(fontSize: 12.sp,fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.w),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.w),
                    ),
                  ),
                  style: GoogleFonts.ubuntu(fontSize: 12.sp,fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 30.h,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, 
                      backgroundColor: Color.fromRGBO(0,0,120,1.0),
                      shadowColor: Colors.black, // Shadow color
                      elevation: 10, // Elevation
                      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp), // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.sp), // Rounded corners
                      ),
                    ),
                    onPressed: () async {
                      String name = nameController.text;
                      String email = emailController.text;
                      String phone = phoneController.text;
                      // Check if all the fields are filled or not
                      if (name.isNotEmpty && email.isNotEmpty && phone.isNotEmpty) {
                        // Check if email contains '@gmail.com' or not
                        if (email.contains('@gmail.com')) {
                          // Check if phone number contains any alphabets or not 
                          RegExp phoneRegExp = RegExp(r'[a-zA-Z]');
                          if (!phoneRegExp.hasMatch(phone)) {
                            Contact newContact = Contact(
                              name: name,
                              emailAddress: email,
                              phoneNumber: phone,
                              isFavourite: false, // Default value
                            );
                            try{
                              // Call addContact method from ContactProvider
                              await Provider.of<ContactProvider>(context, listen: false).addContact(newContact);
                              // Show success message
                              showCustomSnackBar(context, "Contact added successfully!", Color.fromRGBO(0,120,0,1.0));
                              // Clear the controllers
                              nameController.clear();
                              emailController.clear();
                              phoneController.clear();
                              // Close the dialog
                              Navigator.of(context).pop();
                            }catch(e) {
                              // Show error message
                              showCustomSnackBar(context, "Error! Unable to save contact.", Color.fromRGBO(120,0,0,1.0));
                              // Clear the controllers
                              nameController.clear();
                              emailController.clear();
                              phoneController.clear();
                              // Close the dialog
                              Navigator.of(context).pop();
                            }
                          }else {
                            // Show error message for invalid phone number
                            showCustomSnackBar(context, "Invalid phone number! \nPlease ensure it does not contain alphabets.", Color.fromRGBO(120,0,0,1.0));
                          }
                        }else {
                          // Show error message for invalid email
                          showCustomSnackBar(context, "Invalid email! \nPlease use an email address with '@gmail.com'.", Color.fromRGBO(120,0,0,1.0));
                        }
                      }else {
                        // Show error message for empty fields
                        showCustomSnackBar(context, "Please fill out all fields before adding a contact.", Color.fromRGBO(120,0,0,1.0));
                      }
                    },
                    child: Text('Add', style: GoogleFonts.ubuntu(fontSize: 12.sp,fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: 10.h,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromRGBO(0,0,120,1.0), 
                      shadowColor: Colors.black, // Shadow color
                      elevation: 10, // Elevation
                      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp), // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.sp), // Rounded corners
                      ),
                    ),
                    onPressed: () {
                      // Clear the controllers
                      nameController.clear();
                      emailController.clear();
                      phoneController.clear();
                      // Close the dialog
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel', style: GoogleFonts.ubuntu(fontSize: 12.sp,fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showCustomSnackBar(BuildContext context, String message, Color bgColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: GoogleFonts.ubuntu(fontSize: 11.sp,fontWeight: FontWeight.bold),),
      backgroundColor: bgColor,
    ),
  );
}
