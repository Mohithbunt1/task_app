import 'package:flutter/material.dart';
import 'package:task_/screens/add.dart';
import 'package:task_/screens/database.dart/database.dart';
import 'package:task_/screens/database.dart/datastore.dart';
import 'package:task_/screens/database.dart/model.dart';

class TaskGo extends StatefulWidget {
  const TaskGo({super.key});

  @override
  State<TaskGo> createState() => _TaskGoState();
}

class _TaskGoState extends State<TaskGo> {
  // TextEditingController nameController = TextEditingController();
  // TextEditingController dateController = TextEditingController();
  // TextEditingController descriptionController = TextEditingController();
  late DB db;
  int currentIndex = 0;
  bool isBodyEmpty = true;

  List<DataModel> datas = [];
  bool fetching = true;
  int currerntindex = 0;
  @override
  void initState() {
    super.initState();
    db = DB();
    getData();
  }

  void getData() async {
    datas = await db.getData();
    setState(() {
      fetching = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(360, 72),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              child: AppBar(
                leading: Icon(null),
                titleSpacing: BorderSide.strokeAlignOutside,
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 70),
                    child: Text(
                      'Go Task',
                      style: TextStyle(
                          fontFamily: "VariableFont_slnt",
                          fontSize: 20,
                          color: Color.fromRGBO(21, 96, 188, 1),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                backgroundColor: Color.fromRGBO(183, 214, 255, 1),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 30,
                    ),
                    child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Color.fromRGBO(21, 96, 188, 1),
                        child: Center(
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddTask()));
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Colors.white,
                              )),
                        )),
                  )
                ],
              ),
            )),
        body: FutureBuilder(
          future: db.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData ||
                (snapshot.data as List<DataModel>).isEmpty) {
              return Center(child: Text('No Task Found'));
            } else {
              datas = snapshot.data as List<DataModel>;
              return ListView.builder(
                itemCount: datas.length,
                itemBuilder: (context, index) => Datacard(
                  data: datas[index],
                  // edit: edit,
                  index: index,
                  delete: delete,
                ),
              );
            }
          },
        ));
  }

  void edit(int index) {
    currentIndex = index;
  }

  void addtask() async {
    AddTask();
  }

  void delete(int index) async {
    await db.deleteData(datas[index].id!);
    setState(() {
      datas.removeAt(index);
      isBodyEmpty = datas.isEmpty;
    });
  }
}
