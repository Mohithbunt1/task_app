import 'package:flutter/material.dart';
import 'package:task_/screens/Gotask.dart';
import 'package:task_/screens/database.dart/database.dart';
import 'package:task_/screens/database.dart/model.dart';

class Edittask extends StatefulWidget {
  final DataModel data;
  final int index;

  const Edittask({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  State<Edittask> createState() => _EdittaskState();
}

class _EdittaskState extends State<Edittask> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late DB db;

  int currentindex = 0;
  bool fetching = true;
  List<DataModel> datas = [];
  bool isImportantChecked = false;
  bool isNoneChecked = false;
  bool importantChecked = false;
  bool noneChecked = false;
  bool fetch = true;
  @override
  void initState() {
    super.initState();
    db = DB();
    fetchData();
  }

  void fetchData() async {
    try {
      datas = await db.getData();
      DataModel currentData =
          datas[widget.index]; // Use the received index here
      nameController.text = currentData.Name;
      dateController.text = currentData.Date;
      descriptionController.text = currentData.Description;

      setState(() {
        fetching = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void delete() async {
    try {
      await db.deleteData(datas[widget.index].id!);
      Navigator.pop(context); // Navigate back after deleting
    } catch (e) {
      print("Error deleting data: $e");
    }
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
              'Edit Task',
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
                    onPressed: () async {
                      DataModel newData = DataModel(
                        id: datas[widget.index].id,
                        Name: nameController.text,
                        Date: dateController.text,
                        Description: descriptionController.text,
                      );

                      await db.updateData(newData, newData.id!);
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: fetching
          ? const CircularProgressIndicator()
          : SingleChildScrollView(
              child: Container(
              height: 1000,
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
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        const Text(
                          'Delete Task?',
                          style: TextStyle(
                            fontFamily: "VariableFont_slnt",
                            fontSize: 15,
                            color: Color.fromRGBO(21, 96, 188, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        Container(
                          height: 43,
                          width: 132,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: const Color.fromRGBO(21, 96, 188, 1),
                          ),
                          child: TextButton(
                            onPressed: delete,
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                fontFamily: "VariableFont_slnt",
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                    child: SizedBox(
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
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: TextFormField(
                      controller: dateController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.calendar_month_rounded,
                                color: Color.fromRGBO(21, 96, 188, 1),
                              )),
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
                    ),
                  ),
                  const SizedBox(
                    height: 5,
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
                        width: 20,
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
                            color: Color.fromRGBO(21, 96, 188, 1),
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
                        width: 50,
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
                            color: Color.fromRGBO(21, 96, 188, 1),
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
                        width: 20,
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
                            color: Color.fromRGBO(21, 96, 188, 1),
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
                        width: 50,
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
                            color: Color.fromRGBO(21, 96, 188, 1),
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
            )),
    );
  }

  void edit(index) {
    currentindex = index;
    nameController.text = datas[index].Name;
    dateController.text = datas[index].Date;
    descriptionController.text = datas[index].Description;
  }
}
