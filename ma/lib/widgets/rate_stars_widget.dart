import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class RateStarsWidget extends StatelessWidget {
  final String itemId;
  final String mediaType; // New parameter for media type

  RateStarsWidget({Key? key, required this.itemId, required this.mediaType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentRating = mediaType == 'movie'
        ? userProvider.user?.moviesRated[itemId] ?? 0
        : userProvider.user?.tvShowsRated[itemId] ?? 0;

    return RatingBar.builder(
      initialRating: currentRating,
      minRating: 0.5,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
      onRatingUpdate: (rating) {
        if (mediaType == 'movie') {
          userProvider.rateMovie(itemId, rating);
        } else {
          userProvider.rateTVShow(itemId, rating);
        }
      },
    );
  }
}
