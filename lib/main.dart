import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:life_post_prj/providers/user_provider.dart';
import 'package:life_post_prj/responsive/mobile_screen_layout.dart';
import 'package:life_post_prj/responsive/responsive_layout_screen.dart';
import 'package:life_post_prj/responsive/web_screen_layout.dart';
import 'package:life_post_prj/screens/login_screen.dart';
import 'package:life_post_prj/screens/signup_screen.dart';
import 'package:life_post_prj/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {

  //
  WidgetsFlutterBinding.ensureInitialized();

  //chạy trên web
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBnj-BDPMhwq-9WdQodsGh9XLYZHchzuKk',
          appId: '1:273543665267:web:ab4fc5399734755f61bc06',
          messagingSenderId: '273543665267',
          projectId: 'lifepost-34308',
          storageBucket: 'lifepost-34308.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
          //ẩn debug console
          debugShowCheckedModeBanner: false,
          title: 'Instagram Clone',
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return const ResponsiveLayout(
                        mobileScreenLayout: MobileScreenLayout(),
                        webScreenLayout: WebScreenLayout());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  }
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }
                return LoginScreen();
              })),
    );
  }
}
