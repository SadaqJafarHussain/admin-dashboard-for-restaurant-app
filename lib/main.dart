import 'package:ecommerce_admin_tut/pages/login/login.dart';
import 'package:ecommerce_admin_tut/providers/app_provider.dart';
import 'package:ecommerce_admin_tut/providers/auth.dart';
import 'package:ecommerce_admin_tut/rounting/route_names.dart';
import 'package:ecommerce_admin_tut/rounting/router.dart';
import 'package:ecommerce_admin_tut/widgets/layout/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpers/costants.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create:(ctx)=> AuthProvider()),
    ChangeNotifierProvider(create:(ctx)=> AppProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primarySwatch: Colors.green,
      ),
      onGenerateRoute: generateRoute,
      initialRoute: PageControllerRoute,
    );
  }
}

class AppPagesController extends StatefulWidget {
  @override
  State<AppPagesController> createState() => _AppPagesControllerState();
}

class _AppPagesControllerState extends State<AppPagesController> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context,listen: false).authenticating();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return FutureBuilder(
      // Initialize FlutterFire:
      future: initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Something went wrong")],
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print(authProvider.status.toString());
          switch (authProvider.status) {
            case Status.Unauthenticated:
              return LoginPage();
            case Status.Authenticated:
              return LayoutTemplate();
            default:
              return LoginPage();
          }
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          ),
        );
      },
    );
  }
}
