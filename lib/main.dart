import 'package:flutter/material.dart';
import 'package:jasonw/pages/clearing_request.dart';
import 'package:jasonw/pages/paymentPage.dart';
import 'package:jasonw/pages/settings.dart';
import 'package:crypto/crypto.dart';
import 'package:jasonw/pages/welcome_page.dart';

import 'package:scoped_model/scoped_model.dart';
import './pages/auth.dart';
import './pages/dashboard.dart';
import './pages/news.dart';
import './scoped_models/main.dart';
import './pages/task_list.dart';
import './pages/chat.dart';
import './pages/reflect.dart';
import './pages/about.dart';
import './pages/inspirations.dart';
import './pages/journals.dart';
import './pages/reflect_goals/reflect_admin.dart';
import 'pages/ChatRoom.dart';
import 'pages/heal.dart';
import 'pages/manage_journals/journal_admin.dart';
import 'pages/manage_journals/journal_list.dart';
import 'pages/products.dart';
import 'pages/see_me.dart';
import 'pages/splash.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();

  @override
  void initState() {
    print('hi');

    _model.autoAuthenticate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
//         debugShowMaterialGrid: true,
//        home: new SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.deepPurple,
            buttonColor: Colors.deepPurple),
        routes: {
          '/': (BuildContext context) => ScopedModelDescendant(
                builder: (BuildContext context, Widget child, MainModel model) {
                  return model.user == null
                      ? SplashScreen()
                      // : Dashboard(_model);
                      : WelcomePage();
                },
              ),
          '/Auth': (BuildContext context) => Auth(),
          // '/welcomePage': (BuildContext context) => WelcomePage(),
          '/dashboard': (BuildContext context) => Dashboard(_model),
          // '/dashboard': (BuildContext context) => WelcomePage(),
          '/news': (BuildContext context) => News(model: _model),
          '/task_list': (BuildContext context) => TaskList(_model),
          '/reflect': (BuildContext context) => Reflect(_model),
          '/chat': (BuildContext context) => MyAppChat(),
          '/inpirations': (BuildContext context) => Inspirations(_model),
          '/journal': (BuildContext context) => Journal(_model),
          '/about': (BuildContext context) => About(),
          '/seeMe': (BuildContext context) => SeeMe(),
          '/reflect_admin': (BuildContext context) =>
              ReflectGoalsAdminPage(_model),
          '/journal_admin': (BuildContext context) => JournalAdmin(_model),
          '/journal_list': (BuildContext context) => JournalList(_model),
          '/heal': (BuildContext context) => Heal(),
          '/chatRoom': (BuildContext context) => ChatRoom(_model),
          '/products': (BuildContext context) => Products(),
          '/paymentPage': (BuildContext context) => PaymentPage(),
          '/clearingrequest': (BuildContext context) => ClearingRequestScreen(),
          '/settings': (BuildContext context) => SettingsScreen(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'dashboard') {
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => Dashboard(_model),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => Dashboard(_model));
        },
      ),
    );
  }
}
