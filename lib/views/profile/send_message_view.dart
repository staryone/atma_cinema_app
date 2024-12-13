import 'package:atma_cinema/clients/message_client.dart';
import 'package:atma_cinema/components/custom_snackbar_component.dart';
import 'package:flutter/material.dart';

class SendMessageView extends StatelessWidget {
  const SendMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController questionController = TextEditingController();
    final TextEditingController paymentIdController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    void _showThankYouDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Thanks for Your Complaint"),
            content: const Text("We will reply to your message soon."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }

    void _submitMessage() async {
      final messageClient = MessageClient();

      if (questionController.text.isEmpty) {
        return CustomSnackbarComponent.showCustomError(
            context, "Title cannot be empty");
      }

      if (paymentIdController.text.isEmpty) {
        return CustomSnackbarComponent.showCustomError(
            context, "Payment ID cannot be empty");
      }

      if (messageController.text.isEmpty) {
        return CustomSnackbarComponent.showCustomError(
            context, "Message cannot be empty");
      }

      final Map<String, dynamic> formData = {
        'title': questionController.text,
        'paymentID': paymentIdController.text,
        'description': messageController.text,
      };

      try {
        await messageClient.createMessage(formData);
        questionController.text = "";
        paymentIdController.text = "";
        messageController.text = "";
        _showThankYouDialog();
      } catch (e) {
        CustomSnackbarComponent.showCustomError(
            context, "Failed to send message");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Send Message",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF001F3F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Question About",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: questionController,
                decoration: InputDecoration(
                  hintText: "Question Keywords",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Payment ID",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: paymentIdController,
                decoration: InputDecoration(
                  hintText: "Your Payment ID",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Message",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: messageController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Write a message of at least 50 characters",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF001F3F),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _submitMessage();
                  },
                  child: const Text(
                    "Send Message",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    );
  }
}
