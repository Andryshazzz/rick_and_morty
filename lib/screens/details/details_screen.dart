import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rick_and_morty/res/icons.dart';
import 'package:rick_and_morty/res/text_styles.dart';

import '../../models/characters_details.dart';
import '../../repos/characters_repo.dart';
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
        final repository = context.read<CharacterRepository>();
        return CharactersDetailsBloc(repository: repository)
          ..add(CharactersDetailsLoadData(characterId: characterId));
      },
      child: _CharactersDetailsScreen(characterId: characterId),
    );
  }
}

class _CharactersDetailsScreen extends StatelessWidget {
  final int characterId;

  const _CharactersDetailsScreen({
    required this.characterId,
  });

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
          subTitle: 'Name',
          mainTitle: character.name,
        ),
        _RowWidget(
          icon: character.status.statusIcon,
          subTitle: 'Status',
          mainTitle: character.status.name,
        ),
        _RowWidget(
            icon: character.species.speciesIcon,
            subTitle: 'Species',
            mainTitle: character.species.name),
        _RowWidget(
          icon: character.gender.genderIcon,
          subTitle: 'Gender',
          mainTitle: character.gender.name.toUpperCase(),
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
