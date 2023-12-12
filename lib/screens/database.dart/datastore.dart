import 'package:flutter/material.dart';
import 'package:task_/screens/database.dart/model.dart';
import 'package:task_/screens/edit.dart';

class Datacard extends StatefulWidget {
  const Datacard({
    Key? key,
    required this.data,
    required this.index,
    required this.delete,
  }) : super(key: key);

  final DataModel data;
  final int index;
  final Function delete;

  @override
  _DatacardState createState() => _DatacardState();
}

class _DatacardState extends State<Datacard> {
  bool noneChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: const EdgeInsets.all(BorderSide.strokeAlignCenter),
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Edittask(
                        data: widget.data,
                        index: widget.index,
                      )),
            );
          },
          child: ListTile(
            leading: Container(
              width: 53,
              height: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage('assets/img11.jpeg'),
                      fit: BoxFit.fill)),
            ),
            title: SizedBox(
              height: 19,
              width: 200,
              child: Text(
                widget.data.Name,
                style: const TextStyle(
                  fontFamily: "VariableFont_slnt",
                  fontSize: 16,
                  color: Color.fromRGBO(21, 96, 188, 1),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      height: 15,
                      width: 70,
                      child: Text(
                        "Priority level :",
                        style: TextStyle(
                          fontFamily: "VariableFont_slnt",
                          fontSize: 12,
                          color: Color.fromRGBO(55, 135, 235, 1),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                      width: 70,
                      child: Text(
                        widget.data.Description,
                        maxLines: 5,
                        style: const TextStyle(
                          fontFamily: "VariableFont_slnt",
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 15,
                  width: 400,
                  child: Text(
                    "Date:  ${widget.data.Date}",
                    style: const TextStyle(
                      fontFamily: "VariableFont_slnt",
                      fontSize: 14,
                      color: Color.fromRGBO(55, 135, 235, 1),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            trailing: Transform.scale(
              scale: 2,
              child: Checkbox(
                value: noneChecked,
                onChanged: (bool? value) {
                  setState(() {
                    noneChecked = value!;
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
          ),
        ),
      ),
    );
  }
}
