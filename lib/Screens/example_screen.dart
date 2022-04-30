import "dart:math";

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lottie/lottie.dart';

class ExampleScreen extends StatelessWidget {
  ExampleScreen({Key? key}) : super(key: key);
  static Random rnd = Random();
  static const list = ['title', 'error', 'director', 'error2'];
  static final element = list[rnd.nextInt(list.length)];

  final String getMovies = """
    query Query {
    allFilms {
      films {
        $element
      }
    }
  }
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Wars'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Query(
              options: QueryOptions(
                document: gql(getMovies),
                fetchPolicy: FetchPolicy.noCache,
              ),
              builder: (
                QueryResult result, {
                VoidCallback? refetch,
                FetchMore? fetchMore,
              }) {
                if (result.hasException) {
                  return Column(
                    children: [
                      Center(
                        child: SizedBox(
                          height: 250,
                          width: 250,
                          child: Image.asset('assets/images/sad_porg.png'),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "The Force is Unavailable",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 35,
                        ),
                      ),
                    ],
                  );
                }
                if (result.isLoading) {
                  return Center(
                    child:
                        Lottie.asset('assets/animations/loading-spinner.json'),
                  );
                }
                return Column(
                  children: [
                    const Text(
                      'The Force is Strong',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.cyanAccent,
                        fontSize: 35,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: SizedBox(
                        height: 250,
                        width: 250,
                        child: Image.asset('assets/images/yoda.png'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    for (var film in result.data!['allFilms']['films'])
                      Text(
                        film['title'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                          fontSize: 35,
                        ),
                      ),
                  ],
                );
              },
            ), // this is the query string
          ],
        ),
      ),
    );
  }
}
