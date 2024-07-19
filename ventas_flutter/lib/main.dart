import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/login_view.dart';
import 'views/tab_view.dart';
import 'views/registration_view.dart';
import 'views/user_list_view.dart';
import 'views/user_detail_view.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/tabs',
      routes: {
        '/login': (context) => LoginView(),
        '/tabs': (context) => TabView(),
        '/register': (context) => RegistrationView(),
        '/users': (context) => UserListView(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/userDetail') {
          final User user = settings.arguments as User;
          return MaterialPageRoute(
            builder: (context) {
              return UserDetailView(user: user);
            },
          );
        }
        return null;
      },
    );
  }
}
