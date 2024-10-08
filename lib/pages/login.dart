import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_application/pages/trangchu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  Color primary =  const Color(0xFF3ADD58);

  late SharedPreferences sharedPreferences;


  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          isKeyboardVisible?  SizedBox(height: screenHeight / 20) : Container(
            height: screenHeight / 2.5,
            width: screenWidth,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(70),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: screenWidth / 5,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: screenHeight / 40,
                bottom: screenHeight / 30,
            ),
            child: Text(
               "Đăng Nhập",
              style: TextStyle(
                fontSize: screenWidth / 18,
                fontFamily: "Nexa Bold",
              ),
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth / 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  fieldTitle("Email"),
                  customField("Nhập Email của bạn", emailController, false),
                  fieldTitle("Password"),
                  customField("Nhập mật khẩu", passController, true),
                  GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      String email = emailController.text.trim();
                      String password = passController.text.trim();
                      
                      if(email.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Email không để trống!"),
                        ));
                      } else if(password.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Password không để trống!"),
                        ));
                      } else {
                        QuerySnapshot snap = await FirebaseFirestore.instance
                            .collection("Admin").where('email', isEqualTo: email).get();
                        try{
                          if(password == snap.docs[0]['password']){
                            sharedPreferences = await SharedPreferences.getInstance();

                            sharedPreferences.setString('adminEmail', email).then((_) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => HomeScreen())
                              );
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Mật khẩu không đúng!"),
                            ));
                          }
                        } catch(e) {
                          String error = " ";
                          if(e.toString() == "RangeError (index): Invalid value: Valid value range is empty: 0"){
                            setState(() {
                              error = "email không tồn tại";
                            });
                          } else {
                            setState(() {
                              error = "Error occurred!";
                            });
                          }
                          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                            content: Text(error),
                          ));

                        }
                      }
                    },
                    child: Container(
                      height: 60,
                      width: screenWidth,
                      margin: EdgeInsets.only(top: screenHeight / 40),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Center(
                        child: Text(
                            "LOGIN",
                          style: TextStyle(
                            fontFamily: "Nexa Bold",
                            fontSize: screenWidth / 26,
                            color: Colors.black,
                            letterSpacing: 2,
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }

  Widget fieldTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth / 26,
          fontFamily: "Nexa Bold",
        ),
      ),
    );
  }

  Widget customField(String hint, TextEditingController controller, bool obscure){
    return Container(
      width: screenWidth,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: screenWidth / 6,
            child: Icon(
              Icons.person,
              color: primary,
              size: screenWidth / 15,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth / 12),
              child: TextFormField(
                controller: controller,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight / 35,
                  ),
                  border: InputBorder.none,
                  hintText: hint,
                ),
                maxLines: 1,
                obscureText: obscure,
              ),
            ),
          )
        ],
      ),
    );
  }

}

