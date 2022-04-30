import 'package:graphql_flutter/graphql_flutter.dart';

class MovieService {
  static const String queryMovieTitle = """
    query Query {
    allFilms {
      films {
        title
      }
    }
  }
  """;

  static const String queryMovieDirectors = """
    query Query {
    allFilms {
      films {
        director
      }
    }
  }
  """;

  static QueryOptions<Object?> movieTitleOptions = QueryOptions(
    document: gql(queryMovieTitle),
    fetchPolicy: FetchPolicy.noCache,
  );

  static QueryOptions<Object?> moviewDirectorOptions = QueryOptions(
    document: gql(queryMovieDirectors),
  );
}
