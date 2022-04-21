import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:udimy_flutter/models/user/user_model.dart';

class UsersScreen extends StatelessWidget {
  List<UserModel> users=[
    UserModel(id: 1, name: 'Laith', phone: '+962796117405'),
    UserModel(id: 2, name: 'Mohammad', phone: '+962796117405'),
    UserModel(id: 3, name: 'Ahmad', phone: '+962796117405'),
    UserModel(id: 4, name: 'Khaled', phone: '+962796117405'),
    UserModel(id: 5, name: 'Ayman', phone: '+962796117405'),
    UserModel(id: 6, name: 'Jawad', phone: '+962796117405'),
    UserModel(id: 7, name: 'Laith', phone: '+962796117405'),
    UserModel(id: 8, name: 'Mohammad', phone: '+962796117405'),
    UserModel(id: 9, name: 'Ahmad', phone: '+962796117405'),
    UserModel(id: 10, name: 'Khaled', phone: '+962796117405'),
    UserModel(id: 11, name: 'Ayman', phone: '+962796117405')

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context,index)=> buildUserItem(users[index]),
          separatorBuilder: (ontext,index) =>
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20.0,
                ),
                child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
              ),
          itemCount: users.length)

    );
  }

  Widget buildUserItem(UserModel user) =>Padding(
    padding: const EdgeInsets.all(20.0),
    child:
    Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          child:
          Text(
            '${user.id}',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            Text(
              user.phone,
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        )
      ],
    ),
  );
}
