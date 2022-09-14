import 'package:flutter/material.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:movies/screens/screens.dart';
import 'package:movies/theme/apptheme.dart';
import 'package:provider/provider.dart';

void main() => runApp( 

  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (BuildContext context) => MovieProvider(), lazy: false),
    ],

    child: const MyApp(),
  )

);

// class AppState extends StatelessWidget {

//   @override 
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider( create: (BuildContext context) => MovieProvider(), lazy: false ),
//       ],

//       child: MyApp(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);

  @override 
  Widget build( BuildContext context ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      title: 'Películas',
      initialRoute: 'home', 
      routes: {
        'home'   : (_) => const HomeScreen(),
        'details': (_) => const DetailsScreen()
      },
    );
  }
}