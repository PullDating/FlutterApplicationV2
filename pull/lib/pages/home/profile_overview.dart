import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/providers/profile.dart';

class ProfileOverviewPage extends ConsumerStatefulWidget {
  const ProfileOverviewPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileOverviewPage> createState() => _ProfileOverviewPageState();
}

class _ProfileOverviewPageState extends ConsumerState<ProfileOverviewPage> {
  @override
  Widget build(BuildContext context) {

    if(ref.read(profileProvider) == null){
      throw Exception("profile provider was null, cannot get image for circle avatar");
    } else if (ref.read(profileProvider)!.images[0] == null){
      throw Exception("First image in profile provider was null. Cannot get image for circle avatar");
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: ref.watch(profileProvider)!.images[0]!.image,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: ElevatedButton(
                  onPressed: () {
                    //todo add correct to the edit profile page.
                  },
                  child: Icon(Icons.edit, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    primary: Colors.blue, // <-- Button color
                    onPrimary: Colors.red, // <-- Splash color
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  //todo add context.go to the correct route here
                },
                child: Icon(Icons.settings, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Colors.blue, // <-- Button color
                  onPrimary: Colors.red, // <-- Splash color
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  //todo add context.go to correct route here
                },
                child: Icon(Icons.filter_list_rounded, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Colors.blue, // <-- Button color
                  onPrimary: Colors.red, // <-- Splash color
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}