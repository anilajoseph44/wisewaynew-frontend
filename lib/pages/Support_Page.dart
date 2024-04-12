import 'package:flutter/material.dart';
import 'package:google_maps_yt/pages/Support/Contact.dart';
import 'package:google_maps_yt/pages/Support/FAQ.dart';
import 'package:google_maps_yt/pages/Support/Privacy_Policy.dart';
import 'package:google_maps_yt/pages/Support/TermsOfService.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/final_logo.png', // Replace 'your_logo.png' with your logo asset path
              height: 120, // Adjust the height as needed
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                ListTile(
                  title: Text('Contact Us'),
                  subtitle: Text('support@wiseway.com'),
                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUsPage()));
                    // Implement email sending functionality
                    // Example: launch('mailto:support@wiseway.com');
                  },
                ),
                Divider(), // Add a divider between sections
                ListTile(
                  title: Text('Privacy Policy'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicyPage()));
                    // Navigate to Privacy Policy screen
                    // Example: Navigator.pushNamed(context, '/privacy_policy');
                  },
                ),
                Divider(), // Add a divider between sections
                ListTile(
                  title: Text('FAQs'),
                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQPage()));
                    // Navigate to FAQs screen
                    // Example: Navigator.pushNamed(context, '/faqs');
                  },
                ),
                Divider(), // Add a divider between sections
                ListTile(
                  title: Text('Terms of Service'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsOfServicePage()));
                    // Navigate to Terms of Service screen
                    // Example: Navigator.pushNamed(context, '/terms_of_service');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
