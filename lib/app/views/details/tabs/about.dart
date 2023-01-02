import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/views/details/states/details_state.dart';
import 'package:movies_app/app/views/details/stores/details_store.dart';
import 'package:provider/provider.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final store = context.read<DetailsStore>();
    final state = store.value;

    if (state is SuccessDetailsState) {
      return Text(
        state.details.overview,
        style: GoogleFonts.poppins(),
      );
    }
    return Container();
  }
}
