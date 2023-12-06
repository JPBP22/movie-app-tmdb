import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class AddToWatchlistWidget extends StatefulWidget {
  final String itemId;
  final String mediaType; // Parameter to distinguish between movie and TV show

  AddToWatchlistWidget({Key? key, required this.itemId, required this.mediaType}) : super(key: key);

  @override
  _AddToWatchlistWidgetState createState() => _AddToWatchlistWidgetState();
}

class _AddToWatchlistWidgetState extends State<AddToWatchlistWidget> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final isInWatchlist = widget.mediaType == 'movie'
        ? userProvider.user?.moviesToWatchList.contains(widget.itemId) ?? false
        : userProvider.user?.tvShowsToWatchList.contains(widget.itemId) ?? false;

    void toggleWatchlist() {
      if (isInWatchlist) {
        widget.mediaType == 'movie'
            ? userProvider.removeFromWatchlist(widget.itemId)
            : userProvider.removeFromTVShowWatchlist(widget.itemId);
      } else {
        widget.mediaType == 'movie'
            ? userProvider.addToWatchlist(widget.itemId)
            : userProvider.addToTVShowWatchlist(widget.itemId);
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(isInWatchlist ? Icons.bookmark : Icons.bookmark_border),
          onPressed: toggleWatchlist,
          color: Colors.amber,
        ),
        Text(isInWatchlist ? "In Your Watchlist" : "Add to Watchlist"),
      ],
    );
  }
}
