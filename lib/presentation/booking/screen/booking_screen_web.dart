import 'package:flutter/material.dart';
import 'package:top_in_city/core/network/google_sheets_api.dart';
import 'package:top_in_city/presentation/booking/helpers/validator_mixin.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreenWeb extends StatefulWidget {
  const ContactScreenWeb({Key? key}) : super(key: key);

  @override
  State<ContactScreenWeb> createState() => _ContactScreenWebState();
}

class _ContactScreenWebState extends State<ContactScreenWeb> with ValidatorMixin {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    messageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldMessenger = ScaffoldMessenger.of(context);
    return Column(
      children: [
        Center(
          child: Text(
            "CONTACT US",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "TOP IN CITY",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Near moyans school,\nPalakkad, Kerala",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Phone:",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            height: 1.2,
                            fontWeight: FontWeight.w800,
                          ),
                      children: [
                        TextSpan(
                          text: " +919995755339, +919961147164",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Email: ",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              height: 1.2,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => _launchUrl(emailLaunchUri),
                          child: Text(
                            "atozwehelp@gmail.com",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  height: 1.2,
                                  color: Colors.red,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Please fill the form and submit\nyour enquiry or suggestion about our products",
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _TextField(
                          label: "Name: ",
                          hintText: "Name",
                          validator: nameValidator,
                          controller: nameController,
                        ),
                        _TextField(
                          label: "Email: ",
                          hintText: "Email",
                          validator: emailValidator,
                          controller: emailController,
                        ),
                        _TextField(
                          label: "Phone: ",
                          hintText: "Phone",
                          validator: phoneValidator,
                          controller: phoneController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Message: ",
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .30,
                          child: TextFormField(
                            controller: messageController,
                            maxLines: 5,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: messageValidator,
                            decoration: const InputDecoration(
                              hintText: "Message",
                              hintStyle: TextStyle(fontSize: 14),
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 11),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final form = {
                                UserFields.name: nameController.text,
                                UserFields.email: emailController.text,
                                UserFields.phone: phoneController.text,
                                UserFields.message: messageController.text,
                              };
                              var result = await GoogleSheetsApi.createField(form);
                              if (result) {
                                nameController.clear();
                                emailController.clear();
                                phoneController.clear();
                                messageController.clear();
                                formKey.currentState!.reset();
                                scaffoldMessenger.showSnackBar(
                                  const SnackBar(
                                    content: Text("Submitted the form successfully"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } else {
                                scaffoldMessenger.showSnackBar(
                                  const SnackBar(
                                    content: Text("Form submission failed"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                            "SUBMIT",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const _TextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 2,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * .30,
            minHeight: 40,
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'atozwehelp@gmail.com',
);
