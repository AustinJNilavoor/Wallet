import 'package:flutter/material.dart';
import 'package:wallet/pages/homepage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallet/model/transclass.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>('transactions');


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LocalAuthentication auth = LocalAuthentication();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0x00000000),
        canvasColor: Color(0xff2c5364),
        unselectedWidgetColor: Colors.white,
        brightness: Brightness.dark,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: LocalAut()
    );
  }
}


class LocalAut extends StatefulWidget {
  @override
  _LocalAutState createState() => _LocalAutState();
}

class _LocalAutState extends State<LocalAut> {
  final LocalAuthentication localAuth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    bool weCanCheckBiometrics = await localAuth.canCheckBiometrics;

    if (weCanCheckBiometrics) {
      bool authenticated = await localAuth.authenticate(
          localizedReason: "Use your fingerprint to verify your identity.",
          useErrorDialogs: true,
          stickyAuth: true
      );

      if (authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          child: Center(
            child: Image(image: AssetImage('assets/wallet.png'),
            height: 130,
            width: 130,)
          ),
          decoration: BoxDecoration(
            color: Color(0xff3d72b4)
          ),
        ),
        onTap: _authenticate,
      ),
    );
  }
}
