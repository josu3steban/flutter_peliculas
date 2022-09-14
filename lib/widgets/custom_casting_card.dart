import 'package:flutter/cupertino.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../model/model.dart';

class MyCastingCard extends StatelessWidget {

  final int movieId;
  
  const MyCastingCard({
    Key? key,
    required this.movieId
  }) : super(key: key);


  @override 
  Widget build(BuildContext context) {

    final movieProvider = Provider.of<MovieProvider>(context);

    return FutureBuilder(
      future: movieProvider.getStartMovieById(movieId),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {

        if(!snapshot.hasData) {
          return Container(
            // width: double.infinity,
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }

        final cast = snapshot.data!;
        
        return Container(
          width: double.infinity,
          height: 180,
          margin: const EdgeInsets.only(bottom: 10),

          child: ListView.builder(
          physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 100,
                height: 120,

                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/loading/no-image.jpg'),
                        image: NetworkImage(cast[index].getUrlImage),
                        fit: BoxFit.cover,
                        height: 120,
                      ),
                    ),

                    const SizedBox(height: 5,),

                    Text(
                      cast[index].name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}