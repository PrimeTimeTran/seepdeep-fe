import 'package:app/utils.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [Text('Main')],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('Name'),
                    Text('Contact Us'),
                    Text('Social'),
                    Text('Legal'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('Mission'),
                    Text('Awards'),
                    Text('Visualizations'),
                    Text('Help Center'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('Investors'),
                    Text('Careers'),
                    Text('Creators'),
                    Text('Partners'),
                    Text('Media Kit'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('About Us'),
                    Text('Team'),
                    Text('Terms of Use'),
                    Text('Privacy Policy'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
