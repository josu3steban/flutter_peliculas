import 'package:flutter/material.dart';
import 'package:movies/model/model.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}): super(key: key);

  @override 
  Widget build( BuildContext context ) {

    final moviesProvider = Provider.of<MovieProvider>(context);
    final moviesPopular  = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Películas en cines'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: MovieSearchDelegate()
            ),
          )
        ],
      ),

      body: SingleChildScrollView(

        child: Column(
          children: [
      
            MyCardSwiper(moviesData: moviesProvider.onStartLoadMovies),
      
            const SizedBox(height: 10),
      
            MyMovieSlider(moviesPopular: moviesPopular.onStartLoadMoviesPopular, onNextPage: () => moviesPopular.getStartLoadMoviePopular() ),
            
          ],
        ),
      )
    );
  }
}


class MovieSearchDelegate extends SearchDelegate {


  @override
  String get searchFieldLabel => 'Buscar...';

  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear_outlined),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('RESULTADOS DE LA BUSQUEDA');
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final movieProvider = Provider.of<MovieProvider>(context);

    movieProvider.getSuggestionByQuery(query);

    if(query.isEmpty) {
      return const Center(
        child: Icon(Icons.movie_creation_outlined, color: Colors.black45, size: 150),
      );
    }

    return StreamBuilder(
      stream: movieProvider.suggestionStream,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

        if(!snapshot.hasData) {

          return const Center(
            child: Icon(Icons.movie_creation_outlined, color: Colors.black45, size: 150),
          );
          
        }

        return ListView.builder(
          physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {

            final movie = snapshot.data![index];
            movie.idHero = 'search_${index}_${movie.id}';

            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
              child: Hero(
                tag: movie.idHero!,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    
                    children: [
                          
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          placeholder: const AssetImage('assets/loading/no-image.jpg'),
                          image: NetworkImage(movie.getUrlImage),
                          fit: BoxFit.cover,
                          width: 50,
                        ),
                      ),
                          
                      const SizedBox(width: 10,),
                          
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                      
                            Text(movie.title ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis, maxLines: 1),
                      
                            Text(movie.originalTitle ?? '', style: const TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis, maxLines: 1),
                      
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            );
            
          },
        );

      },
    );
    
  }

}