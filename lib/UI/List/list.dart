import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/Core/Providers/AuthProvider.dart';
import 'package:to_do_list/Core/firestore_helper.dart';
import 'package:to_do_list/Model/tasks.dart';
import 'package:to_do_list/UI/List/taskItem.dart';

class ListTab extends StatefulWidget {
  ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  DateTime mySelectedData = DateTime.now();

  @override
  Widget build(BuildContext context) {
    AuthUserProvider provider = Provider.of<AuthUserProvider>(context);
    return Container(
      color: Color(0xffdce9da),
      child: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              mySelectedData = selectedDate;
              setState(() {});
            },
            headerProps: const EasyHeaderProps(
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.fullDateDMY(),
            ),
            dayProps: const EasyDayProps(
              dayStructure: DayStructure.dayStrDayNum,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff3371FF),
                      Color(0xff8426D6),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirestoreHelper.listenToTasks(
                  provider.authUser!.uid,
                  Timestamp.fromMillisecondsSinceEpoch(
                      mySelectedData.millisecondsSinceEpoch)),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Column(
                    children: [
                      Text("Something went wrong"),
                      ElevatedButton(onPressed: () {}, child: Text("try again"))
                    ],
                  );
                }
                List<Tasks> tasks = snapshot.data ?? [];
                return ListView.builder(
                    itemBuilder: (context, index) => TaskItem(
                          tasks: tasks[index],
                        ),
                    itemCount: tasks.length);
              },
            ),
          ),
        ],
      ),
    );
  }
}
