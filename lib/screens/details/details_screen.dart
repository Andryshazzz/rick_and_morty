import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../../generated/locale_keys.g.dart';
import '../../models/characters.dart';
import '../../res/colors.dart';
import '../../res/icons.dart';
import '../../res/text_styles.dart';
import 'details_bloc.dart';
import 'details_event.dart';
import 'details_state.dart';

class CharactersDetailsScreen extends StatelessWidget {
  const CharactersDetailsScreen({
    super.key,
    required this.characterId,
  });

  final int characterId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersDetailsBloc>(
      create: (context) {
        return GetIt.I<CharactersDetailsBloc>(param1: characterId)
          ..add(
            CharactersDetailsLoadData(),
          );
      },
      child: _CharactersDetailsScreen(),
    );
  }
}

class _CharactersDetailsScreen extends StatelessWidget {
  const _CharactersDetailsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CharactersDetailsBloc, CharactersDetailsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.character == null) {
            return const Text('ой-ой');
          }
          return Column(
            children: [
              _HeaderWidget(character: state.character!),
              const SizedBox(height: 20),
              _DetailInfo(character: state.character!),
            ],
          );
        },
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 260,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 45,
          left: 20,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ProjectColors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: SvgPicture.asset(ProjectIcons.arrowLeft),
            ),
          ),
        )
      ],
    );
  }
}

class _DetailInfo extends StatelessWidget {
  const _DetailInfo({
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RowWidget(
          icon: ProjectIcons.information,
          subTitle: LocaleKeys.name.tr(),
          mainTitle: character.name,
        ),
        _RowWidget(
          icon: character.status.statusIcon,
          subTitle: LocaleKeys.status.tr(),
          mainTitle: character.status.statusUpperCase,
        ),
        _RowWidget(
          icon: character.species.speciesIcon,
          subTitle: LocaleKeys.species.tr(),
          mainTitle: character.species.speciesUpperCase,
        ),
        _RowWidget(
          icon: character.gender.genderIcon,
          subTitle: LocaleKeys.gender.tr(),
          mainTitle: character.gender.genderUpperCase,
        ),
      ],
    );
  }
}

class _RowWidget extends StatelessWidget {
  const _RowWidget({
    required this.icon,
    required this.subTitle,
    required this.mainTitle,
  });

  final String icon;
  final String subTitle;
  final String mainTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ProjectColors.irisBlue,
              borderRadius: BorderRadius.circular(50),
            ),
            child: SvgPicture.asset(
              icon,
              color: ProjectColors.whiteSmoke,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subTitle,
                  style: ProjectTextStyles.bodyMedium,
                ),
                Text(
                  mainTitle,
                  overflow: TextOverflow.ellipsis,
                  style: ProjectTextStyles.subtitle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
