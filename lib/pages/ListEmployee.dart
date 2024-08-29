import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_application/services/database.dart';
import 'package:flutter/material.dart';
import 'addEmployee.dart';

class ListEmployee extends StatefulWidget {
  const ListEmployee({super.key});

  @override
  State<ListEmployee> createState() => _ListEmployeeState();
}

class _ListEmployeeState extends State<ListEmployee> {
  TextEditingController nameController =  TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController positionController =  TextEditingController();
  TextEditingController cccdController =  TextEditingController();
  TextEditingController phoneController =  TextEditingController();

  Stream ? EmployeeStream;

  getontheload() async{
    EmployeeStream = await DatabaseMethods().getEmployeeDetail();
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getontheload();
    super.initState();
  }

  Widget allEmployeeDetail(){
    return StreamBuilder(
        stream: EmployeeStream ,
        builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData?
      ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Họ tên: "+ds["Họ Tên"],
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              nameController.text=ds["Họ Tên"];
                              genderController.text=ds["Giới tính"];
                              positionController.text=ds["Vị trí"];
                              cccdController.text=ds["CMND"];
                              phoneController.text=ds["Số điện thoại"];
                              EditEmployeeDetail(ds["Id"]);
                            },
                            child: const Icon(
                              Icons.remove_red_eye,
                              color:Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Vị trí: "+ds["Vị trí"],
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "CMND: "+ds["CMND"],
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }):
      Container();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> EmployeeDetail()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Danh sách nhân viên",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0,top: 10.0),
        child: Column(
          children: [
            Expanded(child: allEmployeeDetail()),
          ],
        ),
      )
    );
  }
  Future EditEmployeeDetail(String id)=> showDialog(context: context, builder: (context)=> AlertDialog(
    content: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.cancel),
              ),
              SizedBox(width: 60.0,),
              const Text(
                "Employee",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Details",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0,),
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
          SizedBox(height: 30.0),
          Center(child: ElevatedButton(onPressed: () async{
            Map<String, dynamic>updateInfo={
              "Id": id,
              "Họ Tên": nameController.text,
              "Giới tính": genderController.text,
              "Vị trí": positionController.text,
              "CMND": cccdController.text,
              "Số điện thoại": phoneController.text,
            };
            await DatabaseMethods().updateEmployeeDetail(id, updateInfo).then((value) {
              Navigator.pop(context);
            });
           }, child: Text("Update")))
        ],
      ),
    ),
  ));
}
