import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seo_renderer/renderers/image_renderer/image_renderer_vm.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';
import 'package:top_in_city/core/asset_constants.dart';
import 'package:top_in_city/modules/core/presentation/bloc/core_bloc.dart';
import 'package:top_in_city/modules/core/widgets/service_card_widget.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<CoreBloc, CoreState>(
      builder: (context, state) {
        return Column(
          children: [
            Align(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height:size.height * 0.66,
                  width:size.width * 0.70,
                  child: carouselImages.isNotEmpty
                      ? CarouselSlider(
                          items: List.generate(
                            carouselImages.length,
                            (index) => ImageRenderer(
                              alt: 'top in city services',
                              child: CachedNetworkImage(
                                imageUrl: carouselImages[index],
                                fit: BoxFit.cover,
                                height: size.height * 0.66,
                                width: size.width * 0.70,
                                memCacheWidth: (size.width * 0.70) ~/ 0.5,
                                memCacheHeight: (size.height * 0.66) ~/ 0.5,
                                fadeInDuration:
                                    const Duration(milliseconds: 200),
                                fadeOutDuration:
                                    const Duration(milliseconds: 200),
                                useOldImageOnUrlChange: true,
                              ),
                            ),
                          ),
                          options: CarouselOptions(
                            padEnds: false,
                            viewportFraction: 1,
                            autoPlay: true,
                            enlargeCenterPage: true,
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              child: TextRenderer(
                text: 'our services',
                child: Text(
                  'OUR SERVICES',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.30,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  ServiceCard(
                    imageUrl: cateringServiceImage,
                    heading: 'OUTDOOR-INDOOR\nCATERING SERVICES',
                    description:
                        'We offer on site catering and also we parcel the food for you and serve the delicious food.',
                  ),
                  ServiceCard(
                    imageUrl: eventManagementImage,
                    heading: 'EVENT\nMANAGEMENT',
                    description:
                        'Worried about the event management? Don’t worry! we have got you. Sit back and Relax.',
                  ),
                  ServiceCard(
                    imageUrl: videographyImage,
                    heading: 'PHOTO /\nVIDEOGRAPHY',
                    description:
                        'We have got photo / videographers who are professional in this field.',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        );
      },
    );
  }
}
