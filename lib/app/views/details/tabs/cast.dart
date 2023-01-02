import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/core/values/app_images.dart';

class CastTab extends StatelessWidget {
  const CastTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 24,
        children: [
          _buildCast(
            context,
            actorName: 'Tom Holland',
            actorPhoto: AppImages.actorOne,
          ),
          _buildCast(
            context,
            actorName: 'Zendaya',
            actorPhoto: AppImages.actorTwo,
          ),
          _buildCast(
            context,
            actorName: 'Benedict Cumberbatch',
            actorPhoto: AppImages.actorThree,
          ),
          _buildCast(
            context,
            actorName: 'Jacob Batalon',
            actorPhoto: AppImages.actorFour,
          ),
        ],
      ),
    );
  }

  Widget _buildCast(BuildContext context,
      {required String actorPhoto, required String actorName}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            actorPhoto,
          ),
          radius: (MediaQuery.of(context).size.width * .35) / 2,
        ),
        const SizedBox(
          height: 8,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 150),
          child: Text(
            actorName,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
