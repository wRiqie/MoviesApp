import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.',
      style: GoogleFonts.poppins(),
    );
  }
}
