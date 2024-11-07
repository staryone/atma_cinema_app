import 'package:flutter/material.dart';
import 'package:atma_cinema/utils/constants.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text(
          "Terms and Conditions",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'Roboto',
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Welcome to Atma Cinema! By using our app to purchase movie tickets, you agree to the following terms and conditions. Please read them carefully before making any transaction.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "1. General Terms",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "1.1. These terms and conditions govern your use of the Atma Cinema app for purchasing movie tickets online.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "1.2. By accessing or using our app, you acknowledge that you have read, understood, and agree to be bound by these terms.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "1.3. If you do not agree to these terms, you may not use the app.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "2. Account Registration",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "2.1. Users are required to register for an account to purchase tickets. You must provide accurate and complete information during registration.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "2.2. You are responsible for maintaining the confidentiality of your account information, including your password. Any activity performed through your account is your responsibility.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "3. Ticket Purchase",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "3.1. Tickets can be purchased directly through the app using the available payment methods.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "3.2. Once payment is completed, a confirmation email or in-app notification will be sent to you containing the details of your purchase.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "3.3. All ticket prices are listed in the currency indicated on the app and may be subject to applicable taxes or service fees.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "3.4. Tickets are sold on a first-come, first-served basis and are subject to availability.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "4. Payment and Fees",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "4.1. Payment for movie tickets must be made at the time of purchase using a valid payment method (credit card, debit card, or other accepted digital payments).",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "4.2. The app is not responsible for any additional bank charges or transaction fees applied by your payment provider.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "4.3. All sales are final. No refunds or exchanges are allowed unless specified in these terms.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "5. Cancellation and Refund Policy",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "5.1. Tickets cannot be canceled or refunded after purchase, except in cases where the event is canceled or rescheduled by the cinema.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "5.2. If a movie screening is canceled or rescheduled, Atma Cinema will provide instructions on how to obtain a refund or reschedule your booking.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "5.3. In case of technical errors that prevent the successful delivery of tickets, Atma Cinema may issue a refund or offer alternative solutions.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "6. Ticket Use and Restrictions",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "6.1. Tickets are non-transferable and are only valid for the movie, time, and seat selected at the time of purchase.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "6.2. You must present a valid ticket (either digital or printed) along with a government-issued ID to gain entry to the cinema.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "6.3. The cinema reserves the right to refuse entry for tickets that have been altered, duplicated, or purchased fraudulently.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "7. Age Restrictions",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "7.1. Some movies may have age restrictions based on their content rating (e.g., PG-13, R). You are responsible for ensuring compliance with these restrictions.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "7.2. Atma Cinema is not responsible for any refusal of entry due to age restrictions if the user does not meet the criteria.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "8. Privacy and Data Security",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "8.1. By using the app, you agree to our Privacy Policy, which outlines how we collect, use, and protect your personal information.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "8.2. Atma Cinema uses industry-standard encryption to protect your personal and payment data, but we cannot guarantee absolute security.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "9. Limitation of Liability",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "9.1. The app is provided \"as is,\" and we make no warranties or representations regarding the accuracy, availability, or reliability of the app.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "9.2. Atma Cinema is not responsible for any direct, indirect, incidental, or consequential damages arising from your use of the app or inability to use the app.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "10. Changes to Terms and Conditions",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "10.1. We reserve the right to modify these terms and conditions at any time. Changes will be effective immediately upon posting.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "10.2. It is your responsibility to review these terms regularly. Your continued use of the app after changes constitutes acceptance of the updated terms.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "11. Governing Law",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "11.1. These terms and conditions are governed by and construed in accordance with the laws of [Insert Jurisdiction].",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "11.2. Any disputes arising from or in connection with the use of the app shall be subject to the exclusive jurisdiction of the courts in [Insert Jurisdiction].",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "12. Contact Information",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "If you have any questions or concerns regarding these terms, please contact us at:",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "[Insert Contact Information]",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "By using Atma Cinema, you agree to the above terms and conditions.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
