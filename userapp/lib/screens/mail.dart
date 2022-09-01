import 'package:flutter/material.dart';
import 'package:userapp/main.dart';

class MailScreen extends StatefulWidget {
  const MailScreen({Key? key}) : super(key: key);

  @override
  _MailScreenState createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  final controllerTo = TextEditingController();
  final controllerSubject = TextEditingController();
  final controllerMessage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mail"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextField(title: 'To', controller: controllerTo),
            SizedBox(
              height: 16,
            ),
            buildTextField(title: 'Subject', controller: controllerSubject),
            SizedBox(
              height: 16,
            ),
            buildTextField(
              title: 'Message',
              controller: controllerMessage,
              maxLines: 8,
            ),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
              child: Text("SEND"),
              onPressed: () => launchEmail(
                toEmail: controllerTo.text,
                subject: controllerTo.text,
                message: controllerMessage.text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future launchEmail({
    required String toEmail,
    required String subject,
    required String message,
  }) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
/*
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
*/
  }

  Widget buildTextField({
    required String title,
    required TextEditingController controller,
    int maxLines = 1,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      );
}
