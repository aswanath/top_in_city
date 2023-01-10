import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String heading;
  final String description;

  const ServiceCard({
    Key? key,
    required this.description,
    required this.imageUrl,
    required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15,
      borderRadius: BorderRadius.circular(10),
      child: AspectRatio(
        aspectRatio: .67,
        child: Padding(
          padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 12 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              AutoSizeText(
                heading,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                maxLines: 2,
                minFontSize: 10,
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Center(
                  child: AutoSizeText(
                    description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.1),
                    maxLines: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}