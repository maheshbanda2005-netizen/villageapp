import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../main.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  static const List<String> images = [
    "https://picsum.photos/seed/school/600/400",
    "https://picsum.photos/seed/streets/600/400",
    "https://picsum.photos/seed/postoffice/600/400",
    "https://picsum.photos/seed/panchayat/600/400",
    "https://picsum.photos/seed/hall/600/400",
    "https://picsum.photos/seed/watertank/600/400",
    "https://picsum.photos/seed/river/600/400",
    "https://picsum.photos/seed/pond/600/400",
    "https://picsum.photos/seed/farm/600/400",
    "https://picsum.photos/seed/temple/600/400",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Village Gallery')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.5,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _showFullScreenImage(context, images[index]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  images[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[100],
                      child: Icon(Icons.broken_image, color: Colors.grey[300]),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[100],
                      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  },
                ),
              ),
            ).animate().fadeIn(
              delay: (40 * index).ms,
              duration: 300.ms,
              curve: Curves.easeOutCubic,
            ).scale(begin: const Offset(0.95, 0.95));
          },
        ),
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: kDarkBg,
        insetPadding: const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            InteractiveViewer(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
