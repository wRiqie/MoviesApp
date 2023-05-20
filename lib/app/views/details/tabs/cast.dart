import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/core/utils/helpers.dart';
import 'package:movies_app/app/core/values/app_images.dart';
import 'package:movies_app/app/global/skeleton_card.dart';
import 'package:movies_app/app/views/details/states/cast_state.dart';
import 'package:movies_app/app/views/details/stores/cast_store.dart';
import 'package:provider/provider.dart';

class CastTab extends StatefulWidget {
  final int movieId;
  const CastTab({super.key, required this.movieId});

  @override
  State<CastTab> createState() => _CastTabState();
}

class _CastTabState extends State<CastTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CastStore>().fetchAll(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<CastStore>();
    final state = store.value;

    if (state is LoadingCastState) {
      return _buildCasts(
        [
          SkeletonCard(
            width: MediaQuery.of(context).size.width * .35,
            height: MediaQuery.of(context).size.width * .35,
            radius: BorderRadius.circular(MediaQuery.of(context).size.width * .35),
          ),
          SkeletonCard(
            width: MediaQuery.of(context).size.width * .35,
            height: MediaQuery.of(context).size.width * .35,
            radius: BorderRadius.circular(MediaQuery.of(context).size.width * .35),
          ),
          SkeletonCard(
            width: MediaQuery.of(context).size.width * .35,
            height: MediaQuery.of(context).size.width * .35,
            radius: BorderRadius.circular(MediaQuery.of(context).size.width * .35),
          ),
          SkeletonCard(
            width: MediaQuery.of(context).size.width * .35,
            height: MediaQuery.of(context).size.width * .35,
            radius: BorderRadius.circular(MediaQuery.of(context).size.width * .35),
          ),
        ],
      );
    }
    if (state is SuccessCastState) {
      return _buildCasts(
        state.movieActors.actors
            .map(
              (e) => _buildCast(
                context,
                actorPhoto: e.profilePath,
                actorName: e.name,
              ),
            )
            .toList(),
      );
    }
    return Container();
  }

  Widget _buildCast(BuildContext context,
      {required String? actorPhoto, required String actorName}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        actorPhoto != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(AppHelpers.getImageUrl(actorPhoto)),
                radius: (MediaQuery.of(context).size.width * .35) / 2,
              )
            : CircleAvatar(
                backgroundImage: const AssetImage(AppImages.noPhoto),
                backgroundColor: Theme.of(context).colorScheme.onBackground,
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

  Widget _buildCasts(List<Widget> casts) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 24,
          children: casts),
    );
  }
}
