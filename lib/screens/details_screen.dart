import 'package:flutter/material.dart';
import 'package:movies/model/movies_model.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}): super(key: key);

  @override 
  Widget build( BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final movieProvider = Provider.of<MovieProvider>(context);
    
    return Scaffold(
      body: CustomScrollView(
        physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: [

          _MySliverAppBar(title: movie.title, image: movie.getUrlImage,),

          SliverList(
            delegate: SliverChildListDelegate([

              _MyPosterAndTitle(image: movie.getUrlImage, average: movie.voteAverage, originalTitle: movie.originalTitle, title: movie.title, id: movie.idHero,),

              _MyMovieDescription(description: movie.overview,),

              const SizedBox(height: 10,),

              if(movie.id != null)
                MyCastingCard(movieId: movie.id!)
              
            ]),
          )
          
        ],
      ),
    );
  } 
}

class _MySliverAppBar extends StatelessWidget {

  final String? title;
  final String image;

  const _MySliverAppBar({
    Key? key,
    this.title,
    required this.image
  }): super(key: key);

  @override 
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,

      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          padding:const EdgeInsets.only(bottom: 5),
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          color: Colors.black38,
          child: Text(title ?? '', style: const TextStyle(fontSize: 18),)
        ),

        background: FadeInImage(
          placeholder: const AssetImage('assets/loading/loading.gif'),
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      )
      
    );
  }
}

class _MyPosterAndTitle extends StatelessWidget {

  final String image;
  final String? title;
  final String? originalTitle;
  final double? average;
  final String? id;

  const _MyPosterAndTitle({
    Key? key,
    required this.image,
    this.title,
    this.originalTitle,
    this.average,
    this.id
  }): super(key: key);

  @override 
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        
        children: [

          Hero(
            tag: '$id',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/loading/no-image.jpg'),
                image: NetworkImage(image),
                fit: BoxFit.cover,
                width: 120,
              ),
            ),
          ),

          const SizedBox(width: 10,),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 210),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                Text(title ?? '', style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis, maxLines: 2),
          
                Text(originalTitle ?? '', style: Theme.of(context).textTheme.subtitle2, overflow: TextOverflow.ellipsis, maxLines: 2),
          
                Row(
                  children: [
          
                    const Icon(Icons.star_border_outlined, color: Colors.grey,),
          
                    const SizedBox(width: 5,),
          
                    Text('$average', style: Theme.of(context).textTheme.caption, overflow: TextOverflow.ellipsis, maxLines: 2)
                    
                  ],
                )
                
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}

class _MyMovieDescription extends StatelessWidget {

  final String? description;

  const _MyMovieDescription({
    Key? key,
    this.description
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        description ?? '',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}