import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/Core/Providers/AuthProvider.dart';
import 'package:to_do_list/Core/firestore_helper.dart';
import 'package:to_do_list/Model/tasks.dart';
import '../../Core/Utilites/appColors.dart';


class TaskItem extends StatelessWidget {
  Tasks tasks;

  TaskItem({super.key,required this.tasks});

  Color containerColor = AppColors.primaryColor;

  Color textColor = AppColors.blackColor;

  @override
  Widget build(BuildContext context) {
    AuthUserProvider provider = Provider.of<AuthUserProvider>(context);
    return  Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.2,
          motion: BehindMotion(),
      children: [
        SlidableAction(
          onPressed: (context) async {
            await FirestoreHelper.deleteTask(userId: provider.authUser!.uid, taskId: tasks.id! );
        },
          backgroundColor: Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          spacing: 15,
          icon: Icons.delete,
          label: 'Delete',
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(24),
            bottomLeft:Radius.circular(24),
          ),
        )
      ]),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: 5,
              height: 90,
              color: containerColor,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tasks.title??"",
                  style: TextStyle(fontSize: 18,color: textColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  tasks.description??"",
                  style: TextStyle(fontSize: 18,color: textColor),
                ),
              ],
            ),
            Spacer(),
            Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 35,
                  width: 50,
                  child: Icon(Icons.check,color: Colors.black,))
          ],
        ),
      ),
    );
  }
}

