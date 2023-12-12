import 'package:flutter/material.dart';
import 'package:task_/screens/Gotask.dart';
import 'package:task_/screens/database.dart/database.dart';
import 'package:task_/screens/database.dart/model.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  List<DataModel> datas = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late DB db;
  bool isImportantChecked = false;
  bool isNoneChecked = false;
  bool importantChecked = false;
  bool noneChecked = false;
  bool fetch = true;
  int currentindex = 0;

  @override
  void initState() {
    super.initState();
    db = DB();
  }

  void Getdata2() async {
    datas = await db.getData();
    setState(() {
      fetch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(360, 72),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AppBar(
            backgroundColor: const Color.fromRGBO(183, 214, 255, 1),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TaskGo()),
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 24,
                color: Color.fromRGBO(21, 96, 188, 1),
              ),
            ),
            title: const Text(
              'Add Task',
              style: TextStyle(
                fontFamily: "VariableFont_slnt",
                fontSize: 20,
                color: Color.fromRGBO(21, 96, 188, 1),
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: CircleAvatar(
                  backgroundColor: const Color.fromRGBO(21, 96, 188, 1),
                  radius: 20,
                  child: IconButton(
                    onPressed: () {
                      addTask();
                    },
                    icon: const Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        height: 1080,
        width: 600,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomStart,
            colors: [
              Color.fromRGBO(214, 232, 255, 0),
              Color.fromRGBO(214, 232, 255, 1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 370),
                child: SizedBox(
                  height: 15,
                  child: Text(
                    'Task Name',
                    style: TextStyle(
                        fontFamily: "VariableFont_slnt",
                        fontSize: 13,
                        color: Color.fromRGBO(55, 135, 235, 1),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(214, 232, 255, 1),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                          color: Color.fromRGBO(55, 135, 235, 1),
                          width: 0,
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 370),
                child: SizedBox(
                  height: 15,
                  child: Text(
                    'Set Date',
                    style: TextStyle(
                        fontFamily: "VariableFont_slnt",
                        fontSize: 13,
                        color: Color.fromRGBO(55, 135, 235, 1),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: TextField(
                  controller: dateController,
                  onTap: () async {
                    DateTime? pickdate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100),
                    );
                    if (pickdate != null) {
                      setState(() {
                        dateController.text = pickdate.toString().split(" ")[0];
                      });
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(214, 232, 255, 1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        style: BorderStyle.none,
                        color: Color.fromRGBO(55, 135, 235, 1),
                        width: 0,
                      ),
                    ),
                    suffixStyle: const TextStyle(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      ),
                    ),
                    suffixIcon: const Icon(
                      Icons.date_range,
                      color: Color.fromRGBO(55, 135, 235, 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 370),
                child: SizedBox(
                  height: 15,
                  child: Text(
                    'Description',
                    maxLines: 5,
                    style: TextStyle(
                        fontFamily: "VariableFont_slnt",
                        fontSize: 13,
                        color: Color.fromRGBO(55, 135, 235, 1),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: TextFormField(
                    controller: descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(214, 232, 255, 1),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            style: BorderStyle.none,
                            color: Color.fromRGBO(55, 135, 235, 1),
                            width: 0,
                          ),
                        )),
                  )),
              //               ),

              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 370),
                child: SizedBox(
                  height: 15,
                  child: Text(
                    'Priority Level',
                    style: TextStyle(
                        fontFamily: "VariableFont_slnt",
                        fontSize: 13,
                        color: Color.fromRGBO(55, 135, 235, 1),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 60,
                  ),
                  Transform.scale(
                    scale: 2.5,
                    child: Checkbox(
                      value: isImportantChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isImportantChecked = value!;
                          if (isImportantChecked) {
                            isNoneChecked = false;
                          }
                        });
                      },
                      side: const BorderSide(
                        style: BorderStyle.solid,
                        color: Color.fromRGBO(166, 203, 248, 1),
                      ),
                      activeColor: const Color.fromRGBO(21, 96, 188, 1),
                      checkColor: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'important',
                    style: TextStyle(
                        fontFamily: "VariableFont_slnt",
                        fontSize: 14,
                        color: Color.fromRGBO(55, 135, 235, 1),
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  Transform.scale(
                    scale: 2.5,
                    child: Checkbox(
                      value: isNoneChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isNoneChecked = value!;
                          if (isNoneChecked) {
                            isImportantChecked = false;
                          }
                        });
                      },
                      side: const BorderSide(
                        style: BorderStyle.solid,
                        color: Color.fromRGBO(166, 203, 248, 1),
                      ),
                      activeColor: const Color.fromRGBO(21, 96, 188, 1),
                      checkColor: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'None',
                    style: TextStyle(
                        fontFamily: "VariableFont_slnt",
                        fontSize: 14,
                        color: Color.fromRGBO(55, 135, 235, 1),
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 60,
                  ),
                  Transform.scale(
                    scale: 2.5,
                    child: Checkbox(
                      value: importantChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          importantChecked = value!;
                          if (importantChecked) {
                            noneChecked = false;
                          }
                        });
                      },
                      side: const BorderSide(
                        style: BorderStyle.solid,
                        color: Color.fromRGBO(166, 203, 248, 1),
                      ),
                      activeColor: const Color.fromRGBO(21, 96, 188, 1),
                      checkColor: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'important',
                    style: TextStyle(
                        fontFamily: "VariableFont_slnt",
                        fontSize: 14,
                        color: Color.fromRGBO(55, 135, 235, 1),
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  Transform.scale(
                    scale: 2.5,
                    child: Checkbox(
                      value: noneChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          noneChecked = value!;
                          if (noneChecked) {
                            importantChecked = false;
                          }
                        });
                      },
                      side: const BorderSide(
                        style: BorderStyle.solid,
                        color: Color.fromRGBO(166, 203, 248, 1),
                      ),
                      activeColor: const Color.fromRGBO(21, 96, 188, 1),
                      checkColor: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'None',
                    style: TextStyle(
                        fontFamily: "VariableFont_slnt",
                        fontSize: 14,
                        color: Color.fromRGBO(55, 135, 235, 1),
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTask() {
    DataModel dataLocal = DataModel(
      Name: nameController.text,
      Date: dateController.text,
      Description: descriptionController.text,
      id: null,
    );
    db.insertDB(dataLocal);

    setState(() {
      datas.add(dataLocal);
    });

    nameController.clear();
    dateController.clear();
    descriptionController.clear();
    Navigator.pop(context);
    setState(() {
      db;
    });
  }
}
