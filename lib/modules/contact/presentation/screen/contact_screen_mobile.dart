import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_in_city/core/helpers/email_helper.dart';
import 'package:top_in_city/modules/contact/helpers/validator_mixin.dart';
import 'package:top_in_city/modules/contact/model/user_field_model.dart';
import 'package:top_in_city/modules/core/presentation/bloc/core_bloc.dart';

import 'package:url_launcher/url_launcher.dart';

class ContactScreenMobile extends StatefulWidget {
  const ContactScreenMobile({Key? key}) : super(key: key);

  @override
  State<ContactScreenMobile> createState() => _ContactScreenMobileState();
}

class _ContactScreenMobileState extends State<ContactScreenMobile> with ValidatorMixin {
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
    return BlocListener<CoreBloc, CoreState>(
      listener: (context, state) {
        if (state is ContactFormResult) {
          if (state.isSuccess) {
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
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                            onTap: () => launchAnyUrl(emailLaunchUri),
                            child: Text(
                              "topincitypalakkad@gmail.com",
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
                const SizedBox(
                  height: 75,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                      child: AutoSizeText(
                        "Please fill the form and submit\nyour enquiry or suggestion about our products.",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                            textInputAction: TextInputAction.next,
                          ),
                          _TextField(
                            label: "Email: ",
                            hintText: "Email",
                            validator: emailValidator,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          _TextField(
                            label: "Phone: ",
                            hintText: "Phone",
                            validator: phoneValidator,
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
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
                            width: MediaQuery.of(context).size.width * .80,
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
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                final form = {
                                  UserFields.name: nameController.text,
                                  UserFields.email: emailController.text,
                                  UserFields.phone: phoneController.text,
                                  UserFields.message: messageController.text,
                                };
                                BlocProvider.of<CoreBloc>(context).add(ContactFormSubmitted(form: form));
                              }
                            },
                            child: Text(
                              "SUBMIT",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
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
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const _TextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
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
            maxWidth: MediaQuery.of(context).size.width * .80,
            minHeight: 40,
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
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
