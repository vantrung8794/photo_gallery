import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({
    Key? key,
    required this.urls,
  }) : super(key: key);

  final List<String> urls;

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  final pageController = PageController();
  bool isShowLeftNarrow = false;
  bool isShowRightNarrow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Container(
          color: Colors.black45.withOpacity(0.4),
          child: Stack(
            children: [
              Positioned.fill(
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      isShowLeftNarrow = value != 0;
                      isShowRightNarrow = value != (widget.urls.length - 1);
                    });
                  },
                  physics: const ClampingScrollPhysics(),
                  controller: pageController,
                  children: widget.urls.map((e) {
                    return Center(
                      child: CachedNetworkImage(
                        imageUrl: e,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          color: Colors.black87,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const CloseButton(),
              if (isShowLeftNarrow)
                LeftNarrow(
                  pageController: pageController,
                ),
              if (isShowRightNarrow)
                RightNarrow(
                  pageController: pageController,
                  maxLength: widget.urls.length,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeftNarrow extends StatelessWidget {
  const LeftNarrow({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Positioned(
      left: 0,
      top: height / 2 - 16,
      child: IconButton(
        onPressed: () {
          final currentIndex = pageController.page ?? 0;
          if (currentIndex > 0.0) {
            pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }
        },
        icon: Icon(
          Icons.keyboard_arrow_left,
          size: 40,
          color: Colors.white.withOpacity(0.8),
        ),
      ),
    );
  }
}

class RightNarrow extends StatelessWidget {
  const RightNarrow({
    Key? key,
    required this.pageController,
    required this.maxLength,
  }) : super(key: key);

  final PageController pageController;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Positioned(
      right: 0,
      top: height / 2 - 16,
      child: IconButton(
        onPressed: () {
          final currentIndex = pageController.page ?? 0;
          if (currentIndex < (maxLength - 1)) {
            pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }
        },
        icon: Icon(
          Icons.keyboard_arrow_right,
          size: 40,
          color: Colors.white.withOpacity(0.8),
        ),
      ),
    );
  }
}

class CloseButton extends StatelessWidget {
  const CloseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      right: 20,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
