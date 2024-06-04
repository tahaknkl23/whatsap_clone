import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/common/widgets/custom_buton.dart';
import 'package:country_picker/country_picker.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
      context: context,
      onSelect: (Country _country) {
        setState(() {
          country = _country;
        });
      },
    );
  }

// burda şunu yapıyoruz eğer kullanıcı telefon numarasını doğrulamışsa direk giriş yapmasını sağlıyoruz
  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref.read(authControllerProvider).signInWithPhoneNumber(
            context,
            "+${country!.phoneCode}$phoneNumber",
          );
    } else {
      showSnackBar(context: context, content: "Please enter a valid phone number");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const Text("WhatsApp will need to verify your phone number"),
            const SizedBox(height: 10),
            TextButton(
              onPressed: pickCountry,
              child: const Text("Pick country"),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                if (country != null) Text("+${country!.phoneCode}"),
                const SizedBox(width: 10),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      hintText: "phone number",
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.6,
            ),
            SizedBox(
              width: 90,
              child: Container(
                decoration: BoxDecoration(
                  color: tabColor,
                  borderRadius: BorderRadius.circular(1),
                ),
                child: CustomButton(
                  text: "NEXT",
                  onPressed: sendPhoneNumber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
