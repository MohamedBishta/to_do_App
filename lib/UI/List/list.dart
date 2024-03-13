import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/Core/Utilites/appColors.dart';

class ListTab extends StatelessWidget {
  const ListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffdce9da),
      child: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
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
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            margin: EdgeInsets.only(left: 20,right: 20,top: 20),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: 5,
                  height: 90,
                  color: AppColors.primaryColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Task Title",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Task Description",
                      style: TextStyle(fontSize: 18),
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
                   child: Icon(Icons.check,color: Colors.black,)),
              ],
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            margin: EdgeInsets.only(left: 20,right: 20,top: 20),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: 5,
                  height: 90,
                  color: AppColors.primaryColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Task Title",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Task Desxription",
                      style: TextStyle(fontSize: 18),
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
                   child: Icon(Icons.check,color: Colors.black,)),
              ],
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            margin: EdgeInsets.only(left: 20,right: 20,top: 20),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: 5,
                  height: 90,
                  color: AppColors.primaryColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Task Title",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Task Desxription",
                      style: TextStyle(fontSize: 18),
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
                   child: Icon(Icons.check,color: Colors.black,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
