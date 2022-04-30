import 'package:flutter/material.dart';
import 'package:graphql_poc/Screens/example_screen.dart';
import 'package:graphql_poc/Screens/welcome_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await initHiveForFlutter();
  await Hive.openBox('testBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // create Client
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
          '/poc': (context) => ExampleScreen(),
        },
      ),
    );
  }
}
