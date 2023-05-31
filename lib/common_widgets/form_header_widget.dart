import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  final String image, title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: Image(image: AssetImage(image), height: size.height * 0.2)),
        Center(
            child:
                Text(title, style: Theme.of(context).textTheme.headlineSmall)),
      ],
    );
  }
}
