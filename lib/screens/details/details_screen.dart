import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
            fit: BoxFit.fill,
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
              child: SvgPicture.asset('assets/icons/arrow-left.svg'),
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
    final iconColor = Color(0xFFF8F8F8);
    return Column(
      children: [
        _RowWidget(
          icon: SvgPicture.asset(
            'assets/icons/information.svg',
            color: iconColor,
          ),
          subTitle: 'Name',
          mainTitle: character.name,
        ),
        _RowWidget(
          icon: SvgPicture.asset(
            character.status.StatusIcon,
            color: iconColor,
          ),
          subTitle: 'Status',
          mainTitle: character.status.name,
        ),
        _RowWidget(
            icon: SvgPicture.asset(
              character.species.SpeciesIcon,
              color: iconColor,
            ),
            subTitle: 'Species',
            mainTitle: character.species.name),
        _RowWidget(
          icon: SvgPicture.asset(
            character.gender.GenderIcon,
            color: iconColor,
          ),
          subTitle: 'Gender',
          mainTitle: character.gender.name,
        ),
      ],
    );
  }
}

class _RowWidget extends StatelessWidget {
  final Widget icon;
  final String subTitle;
  final String mainTitle;

  const _RowWidget({
    required this.icon,
    required this.subTitle,
    required this.mainTitle,
  });

  @override
  Widget build(BuildContext context) {
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
            child: icon,
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subTitle,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF808080),
                  )),
              Text(
                mainTitle,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFF1F1F1F),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
