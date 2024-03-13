import 'package:flutter/material.dart';
import 'package:to_do_list/Core/Utilites/appColors.dart';
import 'package:to_do_list/UI/List/list.dart';
import 'package:to_do_list/UI/List/taskBottomSheet.dart';
import 'package:to_do_list/UI/Settings/setting.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  var tabs =[
    ListTab(),
    SettingTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "To do App",
        ),
      ),
      body: tabs[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(side: BorderSide(color: AppColors.whiteColor,width: 4)),
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          addTaskBottomSheet();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            elevation: 0.0,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    size: 35,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 35,
                  ),
                  label: ""),
            ],
          ),
      ),
    );
  }

  void addTaskBottomSheet() async{
      await showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        context: context, builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
          child: AddTaskBottomSheet(),
        );
    },);

  }
}
