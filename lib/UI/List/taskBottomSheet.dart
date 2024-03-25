import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/Core/Providers/AuthProvider.dart';
import 'package:to_do_list/Core/Utilites/appColors.dart';
import 'package:to_do_list/Core/Utilites/dialog_Details.dart';
import 'package:to_do_list/Core/firestore_helper.dart';
import 'package:to_do_list/Model/tasks.dart';
import 'package:to_do_list/UI/Componant/CustomTextFormField.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  var myKey = GlobalKey<FormState>();

  DateTime selectedData = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(30),
      child: Form(
        key: myKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add new Task",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              decoration: InputDecoration(
                labelText: "Title :",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(10)),
              ),
              controller: titleController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return "Please Enter title";
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(30)),
                  labelText: "Description :",
                  hintText: "add description"),
              controller: descriptionController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return "Please Enter description";
                }
              },
              MaxLines: 3,
              MinLines: 3,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Selected Data :"),
            SizedBox(
              height: 10,
            ),
            Center(
                child: InkWell(
                    onTap: () {
                      showTaskDataPicker();
                    },
                    child: Text("${showDataTimeFormate(selectedData)}"))),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: Text("Add Task"))
          ],
        ),
      ),
    );
  }

  showDataTimeFormate(DateTime dataTime) {
    return ("${dataTime.year}-${dataTime.month}-${dataTime.day}");
  }

  void showTaskDataPicker() async {
    var date = await showDatePicker(
        initialDate: selectedData,
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (date == null) return;
    selectedData = date;
    setState(() {});
  }

  Future<void> addTask() async {
    if (myKey.currentState?.validate() == false) return;

    AuthUserProvider provider =
        Provider.of<AuthUserProvider>(context, listen: false);
    DialogUtils.showLoadingDialog(context: context);
    await FirestoreHelper.addNewTask(
        userId: provider.authUser!.uid,
        task: Tasks(
            title: titleController.text,
            description: descriptionController.text,
            date: Timestamp.fromMillisecondsSinceEpoch(selectedData.millisecondsSinceEpoch)));
    DialogUtils.hidenDialog(context: context);
    titleController.text = '';
    descriptionController.text = '';
  }
}
