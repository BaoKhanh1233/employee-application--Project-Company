import 'package:employee_application/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';


 class EmployeeDetail extends StatefulWidget {
   const EmployeeDetail({super.key});
 
   @override
   State<EmployeeDetail> createState() => _EmployeeDetailState();
 }
 
 class _EmployeeDetailState extends State<EmployeeDetail> {
   TextEditingController nameController =  TextEditingController();
   TextEditingController genderController = TextEditingController();
   TextEditingController positionController =  TextEditingController();
   TextEditingController cccdController =  TextEditingController();
   TextEditingController phoneController =  TextEditingController();
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       resizeToAvoidBottomInset: false,
       appBar: AppBar(
         title: const Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text(
               "Thêm",
               style: TextStyle(
                 color: Colors.blue,
                 fontSize: 24.0,
                 fontWeight: FontWeight.bold,
               ),
             ),
             SizedBox(width: 5.0,),
             Text(
               "Thông tin",
               style: TextStyle(
                 color: Colors.orange,
                 fontSize: 24.0,
                 fontWeight: FontWeight.bold,
               ),
             ),
           ],
         ),
       ),
       body: Container(
         margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             const Text(
               "Họ Tên",
               style: TextStyle(
                 color: Colors.black,
                 fontSize: 20.0,
                 fontWeight: FontWeight.bold,
               ),
             ),
             const SizedBox(
               height: 10.0,
             ),
             Container(
               padding: EdgeInsets.only(left: 10.0),
               decoration: BoxDecoration(
                 border: Border.all(),
                 borderRadius: BorderRadius.circular(10),
               ),
               child: TextField(
                 controller: nameController,
                 decoration: InputDecoration(border: InputBorder.none),
               ),
             ),
             const SizedBox(height: 20.0,),
             const Text(
               "Giới tính",
               style: TextStyle(
                 color: Colors.black,
                 fontSize: 20.0,
                 fontWeight: FontWeight.bold,
               ),
             ),
             const SizedBox(
               height: 10.0,
             ),
             Container(
               padding: EdgeInsets.only(left: 10.0),
               decoration: BoxDecoration(
                 border: Border.all(),
                 borderRadius: BorderRadius.circular(10),
               ),
               child: TextField(
                 controller: genderController,
                 decoration: InputDecoration(border: InputBorder.none),
               ),
             ),
             const SizedBox(height: 20.0,),
             const Text(
               "Vị trí",
               style: TextStyle(
                 color: Colors.black,
                 fontSize: 20.0,
                 fontWeight: FontWeight.bold,
               ),
             ),
             const SizedBox(
               height: 10.0,
             ),
             Container(
               padding: EdgeInsets.only(left: 10.0),
               decoration: BoxDecoration(
                 border: Border.all(),
                 borderRadius: BorderRadius.circular(10),
               ),
               child: TextField(
                 controller: positionController,
                 decoration: InputDecoration(border: InputBorder.none),
               ),
             ),
             const SizedBox(height: 20.0,),
             const Text(
               "CMND",
               style: TextStyle(
                 color: Colors.black,
                 fontSize: 20.0,
                 fontWeight: FontWeight.bold,
               ),
             ),
             const SizedBox(
               height: 10.0,
             ),
             Container(
               padding: EdgeInsets.only(left: 10.0),
               decoration: BoxDecoration(
                 border: Border.all(),
                 borderRadius: BorderRadius.circular(10),
               ),
               child: TextField(
                 controller: cccdController,
                 decoration: InputDecoration(border: InputBorder.none),
               ),
             ),
             const SizedBox(height: 20.0,),
             const Text(
               "Số điện thoại",
               style: TextStyle(
                 color: Colors.black,
                 fontSize: 20.0,
                 fontWeight: FontWeight.bold,
               ),
             ),
             const SizedBox(
               height: 10.0,
             ),
             Container(
               padding: EdgeInsets.only(left: 10.0),
               decoration: BoxDecoration(
                 border: Border.all(),
                 borderRadius: BorderRadius.circular(10),
               ),
               child: TextField(
                 controller: phoneController,
                 decoration: InputDecoration(border: InputBorder.none),
               ),
             ),
             const SizedBox(height: 10.0,),
             Center(
               child: ElevatedButton(
                   onPressed: () async {
                     String Id = randomAlphaNumeric(10); 
                     Map<String, dynamic> employeeInfoMap = {
                       "Id": Id,
                       "Họ Tên": nameController.text,
                       "Giới tính": genderController.text,
                       "Vị trí": positionController.text,
                       "CMND": cccdController.text,
                       "Số điện thoại": phoneController.text,
                     };
                     await DatabaseMethods().addEmployeeDetail(employeeInfoMap, Id).then((value) {
                       Fluttertoast.showToast(
                           msg: "Thông tin nhân viên đã thêm thành công",
                           toastLength: Toast.LENGTH_SHORT,
                           gravity: ToastGravity.CENTER,
                           timeInSecForIosWeb: 1,
                           backgroundColor: Colors.blue,
                           textColor: Colors.white,
                           fontSize: 16.0
                       );
                     });
                   },
                   child: const Text(
                     "Thêm",
                     style: TextStyle(
                       fontSize: 20.0,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
               ),
             ),
           ],
         ),
       ),
     );
   }
 }
 