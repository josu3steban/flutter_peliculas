import 'package:flutter/material.dart';
import 'package:movies/model/model.dart';

class MyMovieSlider extends StatefulWidget {

  final List<Movie> moviesPopular;
  final Function onNextPage;

  const MyMovieSlider({
    Key? key,
    required this.moviesPopular,
    required this.onNextPage
  }): super(key: key);

  @override
  State<MyMovieSlider> createState() => _MyMovieSliderState();
}

class _MyMovieSliderState extends State<MyMovieSlider> {

  final ScrollController scrollController = ScrollController();

  @override 
  void initState() {
    super.initState();

    double maxScroll = 0;

    scrollController.addListener(() {

      if((scrollController.position.pixels ) >= (scrollController.position.maxScrollExtent) ) {

        if( maxScroll !=  scrollController.position.maxScrollExtent ) {
          widget.onNextPage();
          maxScroll = scrollController.position.maxScrollExtent;
        }
        
      }

    });
  }

  @override
  void dispose() {


    super.dispose();
  }
  
  @override 
  Widget build( BuildContext context) {
    return Container(
      // color: Colors.red,
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Populares', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
              scrollDirection: Axis.horizontal,
              itemCount: widget.moviesPopular.length,
              itemBuilder: (BuildContext context, int index) {

                widget.moviesPopular[index].idHero = '${widget.moviesPopular[index].id}_$index';

                return _MoviePoster(imgUrl: widget.moviesPopular[index].getUrlImage, imgTitle: widget.moviesPopular[index].title, movie: widget.moviesPopular[index], heroId: widget.moviesPopular[index].idHero);

              } 
            ),
          )
          
        ],
      ),
    );
  }
}


class _MoviePoster extends StatelessWidget{

  final String imgUrl;
  final String? imgTitle;
  final String? heroId;
  final Movie movie;

  const _MoviePoster({
    Key? key,
    required this.imgUrl,
    this.imgTitle,
    this.heroId,
    required this.movie
  }): super(key: key);

  @override 
  Widget build( BuildContext context ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'details', arguments:movie,),
      child: Container(
        width: 120,
        height: 150,
        // color: Colors.blue,
        margin: const EdgeInsets.all(10),
    
        child: Column(
          children: [
    
            Hero(
              tag: heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/loading/no-image.jpg'),
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.cover,
                  height: 150,
                ),
              ),
            ),

            const SizedBox(height: 5),
    
            if(imgTitle != null)
              Text(
                imgTitle!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            
            
          ],
        ),
      ),
    );
  }
}