import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import 'package:rick_and_morty/res/icons.dart';
import 'package:rick_and_morty/res/text_styles.dart';

import '../../generated/locale_keys.g.dart';
import '../../models/characters_details.dart';
import 'details_bloc.dart';
import 'details_event.dart';
import 'details_state.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final int characterId;

  const CharactersDetailsScreen({
    super.key,
    required this.characterId,
  });

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
  final Character character;

  const _HeaderWidget({
    required this.character,
  });

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
                color: Colors.white,
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
  final Character character;

  const _DetailInfo({
    required this.character,
  });

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
  final String icon;
  final String subTitle;
  final String mainTitle;

  const _RowWidget({
    required this.icon,
    required this.subTitle,
    required this.mainTitle,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = Color(0xFFF8F8F8);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF11B0C8),
              borderRadius: BorderRadius.circular(50),
            ),
            child: SvgPicture.asset(
              icon,
              color: iconColor,
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subTitle,
                style: ProjectTextStyles.bodyMedium,
              ),
              Text(
                mainTitle,
                style: ProjectTextStyles.subtitle,
              ),
            ],
          )
        ],
      ),
    );
  }
}
