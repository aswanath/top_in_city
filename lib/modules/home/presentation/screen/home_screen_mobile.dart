import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:top_in_city/core/asset_constants.dart';
import 'package:top_in_city/core/constants.dart';
import 'package:top_in_city/modules/core/presentation/bloc/core_bloc.dart';
import 'package:top_in_city/modules/core/widgets/service_card_widget.dart';

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<CoreBloc, CoreState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            children: [
              Container(
                width: size.width * 0.75,
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: GradientText(
                  '"അമ്മയുടെ കയ്യിൽ നിന്നും നാവിൻ തുമ്പിലേക്ക് രുചിയുടെ മേള."',
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  colors: gradientColors,
                ),
              ),
              Align(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CarouselSlider(
                    items: List.generate(
                      carouselImages.length,
                      (index) => Image.network(
                        carouselImages[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                    options: CarouselOptions(
                      padEnds: false,
                      viewportFraction: 1,
                      autoPlay: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                child: Text(
                  'OUR SERVICES',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: size.width * 0.55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    ServiceCard(
                      imageUrl: cateringServiceImage,
                      heading: 'OUTDOOR-INDOOR\nCATERING SERVICES',
                      description: 'We offer on site catering and also we parcel the food for you and serve the delicious food.',
                    ),
                    ServiceCard(
                      imageUrl: eventManagementImage,
                      heading: 'EVENT\nMANAGEMENT',
                      description: 'Worried about the event management? Don’t worry! we have got you. Sit back and Relax.',
                    ),
                    ServiceCard(
                      imageUrl: videographyImage,
                      heading: 'PHOTO /\nVIDEOGRAPHY',
                      description: 'We have got photo / videographers who are professional in this field.',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              // const Footer(),
            ],
          ),
        );
      },
    );
  }
}
