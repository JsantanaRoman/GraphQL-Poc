import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({Key? key}) : super(key: key);
  // titles = Loading to error
  // title = Loading to sucess if no cache
  final String getMovies = """
    query Query {
    allFilms {
      films {
        title
      }
    }
  }
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Query(
              options: QueryOptions(
                document: gql(getMovies),
              ),
              builder: (
                QueryResult result, {
                VoidCallback? refetch,
                FetchMore? fetchMore,
              }) {
                if (result.hasException) {
                  return Center(
                    child: Text(
                      'Sorry No Data Available',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade700,
                        fontSize: 30,
                      ),
                    ),
                  );
                }
                if (result.isLoading) {
                  return Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow.shade700,
                        fontSize: 30,
                      ),
                    ),
                  );
                }
                return Center(
                  child: Text(
                    result.data!['allFilms']['films'][4]['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                      fontSize: 30,
                    ),
                  ),
                );
              },
            ), // this is the query string
          ],
        ),
      ),
    );
  }
}
