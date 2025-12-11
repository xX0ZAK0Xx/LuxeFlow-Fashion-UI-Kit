import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Text(
          '''
**Privacy Policy for LuxeFlow**

**1. Introduction**
Welcome to LuxeFlow. We respect your privacy and are committed to protecting your personal data. This privacy policy will inform you as to how we look after your personal data when you visit our website (regardless of where you visit it from) and tell you about your privacy rights and how the law protects you.

**2. Important Information and Who We Are**
[Insert Company Name] is the controller and responsible for your personal data.

**3. The Data We Collect About You**
We may collect, use, store and transfer different kinds of personal data about you which we have grouped together follows:
- Identity Data.
- Contact Data.
- Financial Data.
- Transaction Data.

**4. How We Use Your Personal Data**
We will only use your personal data when the law allows us to. Most commonly, we will use your personal data in the following circumstances:
- Where we need to perform the contract we are about to enter into or have entered into with you.
- Where it is necessary for our legitimate interests (or those of a third party) and your interests and fundamental rights do not override those interests.
- Where we need to comply with a legal or regulatory obligation.

**5. Data Security**
We have put in place appropriate security measures to prevent your personal data from being accidentally lost, used or accessed in an unauthorised way, altered or disclosed.

**6. Contact Us**
If you have any questions about this privacy policy, please contact us.
          ''',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
    );
}
