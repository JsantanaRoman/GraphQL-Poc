import 'package:flutter/material.dart';
import 'package:graphql_poc/Screens/example_screen.dart';
import 'package:graphql_poc/Screens/welcome_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:async';
import 'dart:io';
import 'package:testfairy_flutter/testfairy_flutter.dart';

void main() async {
  HttpOverrides.global = TestFairy.httpOverrides();

  runZonedGuarded(() async {
    try {
      FlutterError.onError = (details) => TestFairy.logError(details.exception);
      await TestFairy.begin("SDK-xJlEdGI2");
      await initHiveForFlutter();
      await Hive.openBox('testBox');
      // Call `await TestFairy.begin()` or any other setup code here.

      runApp(TestFairyGestureDetector(child: MyApp()));
    } catch (error) {
      TestFairy.logError(error);
    }
  }, (e, s) {
    TestFairy.logError(e);
  }, zoneSpecification: ZoneSpecification(
    print: (self, parent, zone, message) {
      TestFairy.log(message);
    },
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GraphQLClient client = GraphQLClient(
    link: HttpLink(
      'https://swapi-graphql.netlify.app/.netlify/functions/index',
    ),
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  );
  // create Notifier
  late final ValueNotifier<GraphQLClient> clientNotifier =
      ValueNotifier<GraphQLClient>(client);

  @override
  Widget build(BuildContext context) {
    // Wrap App in GraphQLProvider
    return GraphQLProvider(
      client: clientNotifier,
      child: MaterialApp(
        title: 'Graphql POC',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const WelcomeScreen(),
          '/poc': (context) => const ExampleScreen(),
        },
      ),
    );
  }
}
