import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  GoogleSignInAccount _currentUser;

  String tName = "NoConnect";
  String tImage = "No Image";
  String tEmail = "No Email";

  Future<void> _handleSignIn() async {
    try {
      _currentUser = await _googleSignIn.signIn();

      setState(() {
        tName = _currentUser.displayName;
        tImage=_currentUser.photoUrl;
        tEmail=_currentUser.email;
      });
      print("OK");
    } catch (error) {
      print(error);
    }
  }
  Future<Null> _handleSignOut() async {
    print("step 1");

    await _googleSignIn.disconnect();

    setState(() {
      tName = "NoConnect";
      tImage = "No Image";
      tEmail = "No Email";
    });

    print("step End");
  }

  Widget GooglePage() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Singin"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            CircleAvatar(

              backgroundImage:tImage=="No Image"? NetworkImage("https://cdn2.iconfinder.com/data/icons/ios-7-icons/50/user_male2-512.png") :  NetworkImage(tImage),
            ),
            Text('$tName'),
            Text('$tEmail'),

            FlatButton.icon(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () => _handleSignIn(), //_handleSignIn(),
                icon: Icon(Icons.supervised_user_circle),
                label: Text('Google signin')),

            FlatButton.icon(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () => _handleSignOut(), //_handleSignIn(),
                icon: Icon(Icons.exit_to_app),
                label: Text('SignOut')),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return GooglePage();
  }
}
