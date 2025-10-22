import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './../../../../core/api/api_constants.dart';
import '../../domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;

  const MovieCard({super.key, required this.movie, this.onTap});

  @override
  Widget build(BuildContext context) {
    final poster = movie.posterPath.isNotEmpty ? '${ApiConstants.baseUrl}${movie.posterPath}' : null;

    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: poster != null
                ? CachedNetworkImage(
                    imageUrl: poster,
                    fit: BoxFit.cover,
                    placeholder: (c, s) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (c, s, e) => const Icon(Icons.broken_image),
                  )
                : Container(color: Colors.grey[300]),
          ),
          const SizedBox(height: 8),
          Text(movie.title, maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
