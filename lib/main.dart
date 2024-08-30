import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_feed_4d/provider/CommentFeedProvider.dart';
import 'package:video_feed_4d/provider/VideoFeedProvider.dart';
import 'package:video_feed_4d/provider/VideoIndexProvider.dart';
import 'view/HomePage.dart';

void main() {
  runApp(
      MyApp(),
  
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=>VideoFeedProvider()),
      ChangeNotifierProvider(create: (context)=>CommentFeedProvider()),
      ChangeNotifierProvider(create: (context)=>VideoIndexProvider()),
    ],child:MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: 
      
      const HomePage(title: 'Flutter Demo Home Page'),
    ) ,);
    
    
  }
}

