import 'package:flutter/cupertino.dart';

class FadeImageSwitcher extends StatefulWidget {
  final ImageProvider<Object> image;
  final BoxFit fit;

  const FadeImageSwitcher({super.key, required this.image, this.fit = BoxFit.cover});

  @override
  State<FadeImageSwitcher> createState() => _FadeImageSwitcherState();
}

class _FadeImageSwitcherState extends State<FadeImageSwitcher> {
  ImageProvider<Object>? prevImage;

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        if (prevImage != null)
          Image(image: prevImage!, fit: widget.fit),
        FadeInImage(placeholder: prevImage ?? widget.image, image: widget.image)
      ],
    );
  }
}
