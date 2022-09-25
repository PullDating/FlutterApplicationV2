import 'package:firebase_core/firebase_core.dart';
import 'package:pull/pages/chat.dart';
import 'package:pull/pages/home/home.dart';
import 'package:pull/pages/home/settings/edit_filters.dart';
import 'package:pull/pages/home/settings/edit_profile.dart';
import 'package:pull/pages/home/settings/settings.dart';
import 'package:pull/pages/login/one_time_password.dart';
import 'package:pull/pages/signup/profile/accountCreationController.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'pages/login/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: PullApp()
    )
  );
}

class PullApp extends ConsumerWidget {
  PullApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
      title: 'Pull',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,

      ),
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[

      //login routes
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        }
      ),
      GoRoute(
        path: '/login/one_time_password',
        builder: (BuildContext context, GoRouterState state) {
          return const OneTimePasswordPage();
        }
      ),

      //main app routes
      GoRoute(
          path: '/home',
          builder: (BuildContext context, GoRouterState state) {
            int index = 0;
            print("Index in query: ${state.queryParams['index']}");
            if(state.queryParams['index'] != null){
              print("index was not null");
              index = int.parse(state.queryParams['index']!);
            } else {
              print("index was null");
              index = 0;
            }
            return HomePage(title: "pull",index: index,);
          }
      ),

      GoRoute(
          path: '/accountcreation',
          builder: (BuildContext context, GoRouterState state) {
            return const AccountCreationController(title: "Create Account",);
          }
      ),
      GoRoute(
          path: '/settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsPage();
          }
      ),
      GoRoute(
          path: '/editProfile',
          builder: (BuildContext context, GoRouterState state) {
            return const EditProfilePage();
          }
      ),
      GoRoute(
          path: '/editFilters',
          builder: (BuildContext context, GoRouterState state) {
            return const EditFiltersPage();
          }
      ),
      GoRoute(
          path: '/chat/:uuid',
          builder: (BuildContext context, GoRouterState state) {
            String uuid = '';
            print(state.params);
            print("UUID in param: ${state.params["uuid"]}");
            if(state.params['uuid'] != null){
              print("uuid was not null");
              uuid = state.params['uuid']!;
            } else {
              print("uuid was null");
            }
            return ChatPage(uuid: uuid,);
          }
      ),
    ]
  );

}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
