import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:task_management_app/app/routes/app_pages.dart';
import 'package:task_management_app/app/utils/style/AppColors.dart';
import 'package:task_management_app/app/utils/widget/header.dart';
import 'package:task_management_app/app/utils/widget/sideBar.dart';
import 'package:task_management_app/app/utils/widget/myTask.dart';
import 'package:task_management_app/app/utils/widget/myfriends.dart';
import 'package:task_management_app/app/utils/widget/upcomingtask.dart';
import 'package:task_management_app/app/data/controller/auth_controller.dart';

import '../controllers/friends_controller.dart';

class FriendsView extends GetView<FriendsController> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final authCon = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: const SizedBox(width: 150, child: SideBar()),
      backgroundColor: AppColors.primaryBg,
      body: SafeArea(
        child: Row(
          children: [
            !context.isPhone
                ? const Expanded(
                    flex: 2,
                    child: SideBar(),
                  )
                : const SizedBox(),
            Expanded(
              flex: 15,
              child: Column(children: [
                !context.isPhone
                    ? const header()
                    : Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _drawerKey.currentState!.openDrawer();
                                  },
                                  icon: const Icon(
                                    Icons.menu,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Task Management',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: AppColors.primaryText),
                                    ),
                                    Text(
                                      'Manage task made easy with friends',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.primaryText),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.notifications,
                                  color: AppColors.primaryText,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.amber,
                                    radius: 25,
                                    foregroundImage: NetworkImage(
                                        'https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/09/27/08/jennifer-lawrence.jpg?quality=75&width982&height=726&auto=webp'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            context.isPhone
                                ? TextField(
                                    onChanged: (value) =>
                                        authCon.searchFriends(value),
                                    controller: authCon.searchFriendsController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.only(
                                          left: 40, right: 10),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.blue),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        color: Colors.black,
                                      ),
                                      hintText: 'Search',
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                //content / isi page / screen
                Expanded(
                  child: Container(
                    padding: !context.isPhone
                        ? EdgeInsets.all(50)
                        : EdgeInsets.all(20),
                    margin: !context.isPhone
                        ? const EdgeInsets.all(10)
                        : const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: !context.isPhone
                          ? BorderRadius.circular(50)
                          : BorderRadius.circular(10),
                    ),
                    child: Obx(
                      () => authCon.hasilPencarian.isEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  const Text(
                                    'People You May Know',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: AppColors.primaryText,
                                    ),
                                  ),
                                  PeopleYouMayKnow(),
                                  MyFriends(),
                                ])
                          : ListView.builder(
                              padding: EdgeInsets.all(8),
                              shrinkWrap: true,
                              itemCount: authCon.hasilPencarian.length,
                              itemBuilder: (context, index) => ListTile(
                                onTap: () => authCon.addFriends(
                                    authCon.hasilPencarian[index]['email']),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image(
                                    image: NetworkImage(
                                        authCon.hasilPencarian[index]['photo']),
                                  ),
                                ),
                                title:
                                    Text(authCon.hasilPencarian[index]['name']),
                                subtitle: Text(
                                    authCon.hasilPencarian[index]['email']),
                                trailing: Icon(Icons.add),
                              ),
                            ),
                    ),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
