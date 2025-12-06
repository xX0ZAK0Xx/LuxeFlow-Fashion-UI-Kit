import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Service')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: const Text(
          '''
**Terms of Service for LuxeFlow**

**1. Acceptance of Terms**
By accessing and using this application, you accept and agree to be bound by the terms and provision of this agreement.

**2. Provision of Services**
We reserve the right to modify or terminate the LuxeFlow service for any reason, without notice at any time.

**3. User Account**
You are responsible for maintaining the security of your account and password. LuxeFlow cannot and will not be liable for any loss or damage from your failure to comply with this security obligation.

**4. Content**
You retain ownership of all content that you submit to the LuxeFlow application.

**5. Prohibited Uses**
You may not use the Service for any illegal or unauthorized purpose. You must not, in the use of the Service, violate any laws in your jurisdiction.

**6. Changes to Terms**
We reserve the right, at our sole discretion, to update, change or replace any part of these Terms of Service by posting updates and changes to our website/app.
          ''',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
    );
  }
}
