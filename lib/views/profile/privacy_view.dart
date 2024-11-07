import 'package:flutter/material.dart';
import 'package:atma_cinema/utils/constants.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text(
          "Privacy and Policy",
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
              SizedBox(height: 0),
              Text(
                "At Atma Cinema, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, share, and protect your data when you use our services. By using the Atma Cinema app, you agree to the practices described in this policy.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "1. Information We Collect",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "We collect various types of information to provide and improve our services. This includes:",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 12),
              Text(
                "1.1. Personal Information\n"
                "When you register or make a purchase, we may collect the following personal data:\n\n"
                " • Name\n"
                " • Email address\n"
                " • Phone number\n"
                " • Payment details (such as credit or debit card information)\n"
                " • Billing and delivery addresses",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 12),
              Text(
                "1.2. Automatically Collected Information\n"
                "When you use the Atma Cinema app, we may collect certain data automatically, including:\n\n"
                " • IP address\n"
                " • Device type and model\n"
                " • Operating system\n"
                " • App usage statistics (e.g., pages visited, time spent on the app)\n"
                " • Location data (if enabled)",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 12),
              Text(
                "1.3. Cookies and Similar Technologies\n"
                "We may use cookies and similar tracking technologies to improve user experience, gather analytical data, and provide personalized content. You can manage cookie preferences through your device settings.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "2. How We Use Your Information",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "We use the information collected for the following purposes:",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 12),
              Text(
                "2.1. Providing Services\n"
                "To process transactions, issue tickets, manage bookings, and provide customer support.\n\n"
                "2.2. Personalization\n"
                "To tailor our app content, recommendations, and communications to suit your preferences.\n\n"
                "2.3. Communication\n"
                "To send you notifications about your bookings, updates, promotional offers, or other relevant information. You may opt-out of promotional communications at any time.\n\n"
                "2.4. Security and Fraud Prevention\n"
                "To protect against fraudulent activity, unauthorized access, and to ensure the security of your account and personal data.\n\n"
                "2.5. Analytics and Improvements\n"
                "To analyze usage trends, understand user behavior, and improve the functionality of the Atma Cinema app.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "3. Sharing Your Information",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "We do not sell or rent your personal information to third parties. However, we may share your data in the following circumstances:",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 12),
              Text(
                "3.1. Service Providers\n"
                "We may share your data with trusted third-party service providers who assist us in operating the app, processing payments, or delivering services. These providers are bound by confidentiality agreements and are not authorized to use your data for purposes other than providing services to Atma Cinema.\n\n"
                "3.2. Legal Requirements\n"
                "We may disclose your information if required by law, such as to comply with legal processes, government requests, or to protect our rights, privacy, safety, or property.\n\n"
                "3.3. Business Transfers\n"
                "In the event of a merger, acquisition, or asset sale, your data may be transferred to the new entity as part of the transaction.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "4. Data Security",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "Atma Cinema employs industry-standard security measures to protect your personal information. These include encryption, secure socket layer (SSL) technology, and other methods to safeguard your data during transmission and storage. However, no method of transmission over the Internet or electronic storage is 100% secure, so we cannot guarantee absolute security.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "5. Your Data Rights",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "You have certain rights regarding your personal data, including:",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 12),
              Text(
                "5.1. Access and Correction\n"
                "You can request access to or correction of your personal information by logging into your account or contacting us directly.\n\n"
                "5.2. Data Deletion\n"
                "You may request the deletion of your personal data by contacting us. However, some data may need to be retained for legal or operational reasons.\n\n"
                "5.3. Opt-out of Marketing Communications\n"
                "You can opt-out of receiving promotional messages by following the unsubscribe instructions in our communications or by updating your preferences in your account settings.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "6. Third-Party Links and Services",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "Our app may contain links to third-party websites or services that are not owned or controlled by Atma Cinema. We are not responsible for the privacy practices of these third parties. We recommend reviewing their privacy policies before sharing your information.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "7. Children’s Privacy",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "Atma Cinema does not knowingly collect personal information from children under the age of 13. If we discover that a child under 13 has provided us with personal data, we will delete such information immediately. If you believe we have collected data from a child under 13, please contact us.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "8. Changes to This Privacy Policy",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "We may update this Privacy Policy from time to time. When we make changes, we will notify you by updating the date at the top of this policy. If the changes are significant, we may also provide additional notice (e.g., by sending an in-app notification or email). Your continued use of the app after any changes indicates your acceptance of the updated policy.",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 20),
              Text(
                "9. Contact Us",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 8),
              Text(
                "If you have any questions or concerns about this Privacy Policy or how your personal information is handled, please contact us at:\n"
                "[Insert Contact Information]",
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
