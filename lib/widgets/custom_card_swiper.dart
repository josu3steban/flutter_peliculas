import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies/model/model.dart';

class MyCardSwiper extends StatelessWidget {

  final List<Movie> moviesData;
  
  const MyCardSwiper({
    Key? key,
    required this.moviesData,
  }): super(key: key);

  @override 
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      // color: Colors.red,

      child: Swiper(
        itemCount: moviesData.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (BuildContext context, int index) {

          // print(moviesData[index].posterPath);
          final movie = moviesData[index];
          movie.idHero = '${movie.title}_${movie.id}_$index';
          
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.idHero!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  placeholder: AssetImage('assets/loading/no-image.jpg'),
                  image: NetworkImage(movie.getUrlImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}