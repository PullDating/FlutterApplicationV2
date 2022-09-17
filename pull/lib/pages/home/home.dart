//this one is going to have a tab view that controls the three other pages

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pull/pages/home/match_list.dart';
import 'package:pull/pages/home/profile_overview.dart';
import 'package:pull/pages/home/swiping.dart';
import 'package:tuple/tuple.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  final List<Tab> navBarItems = const [
    Tab(icon: Icon(Icons.people_outline_sharp),),
    Tab(icon: Icon(Icons.chat),),
    Tab(icon: Icon(Icons.person))
  ];

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: navBarItems.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            SwipingPage(),
            MatchListPage(),
            ProfileOverviewPage(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            tabs: navBarItems,
          ),
        ),


        // BottomNavigationBar(
        //   currentIndex: ,
        //   items: navBarItems,
        //   onTap: (i) {
        //
        //   },
        // ),
      ),
    );
  }
}