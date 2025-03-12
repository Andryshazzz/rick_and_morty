import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/characters_details.dart';
import '../../repos/characters_repo.dart';
import 'details_bloc.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final int characterId;

  const CharactersDetailsScreen({
    super.key,
    required this.characterId,
  });

  @override
  Widget build(BuildContext context) {
    final repository = context.read<CharacterRepository>();
    return BlocProvider<CharactersDetailsBloc>(
      create: (context) => CharactersDetailsBloc(repository: repository),
      child: _CharactersDetailsScreen(characterId: characterId),
    );
  }
}

class _CharactersDetailsScreen extends StatefulWidget {
  final int characterId;

  const _CharactersDetailsScreen({
    required this.characterId,
  });

  @override
  State<_CharactersDetailsScreen> createState() =>
      _CharactersDetailsScreenState();
}

class _CharactersDetailsScreenState extends State<_CharactersDetailsScreen> {
  @override
  void initState() {
    context
        .read<CharactersDetailsBloc>()
        .add(CharactersDetailsLoadData(characterId: widget.characterId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersDetailsBloc, CharactersDetailsState>(
      builder: (context, state) {
        if (state is CharactersDetailsLoaded) {
          return Scaffold(
            body: Column(
              children: [
                _HeaderWidget(data: state.character),
                const SizedBox(height: 20),
                _DetailInfo(data: state.character),
              ],
            ),
          );
        } else if (state is CharactersDetailsInitial) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Text('ой-ой');
        }
      },
    );
  }
}

/////////////////////////////////////Header_Widget//////////////////////////////////////////////

class _HeaderWidget extends StatelessWidget {
  final Character data;

  const _HeaderWidget({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 260,
          child: Image.network(
            data.image,
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

/////////////////////////////////////Detail_Widget//////////////////////////////////////////////

class _DetailInfo extends StatelessWidget {
  final Character data;

  const _DetailInfo({
    required this.data,
  });

  Widget _getStatusIcon(Status status) {
    switch (status) {
      case Status.alive:
        return SvgPicture.asset(
          'assets/icons/alive.svg',
          color: const Color(0xFFF8F8F8),
        );
      case Status.dead:
        return SvgPicture.asset(
          'assets/icons/dead.svg',
          color: const Color(0xFFF8F8F8),
        );
      case Status.unknown:
        return SvgPicture.asset(
          'assets/icons/unknown.svg',
          color: const Color(0xFFF8F8F8),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RowWidget(
          icon: SvgPicture.asset(
            'assets/icons/information.svg',
            color: Color(0xFFF8F8F8),
          ),
          subTitle: 'Name',
          mainTitle: data.name,
        ),
        _RowWidget(
          icon: _getStatusIcon(Status.fromString(data.status)),
          subTitle: 'Status',
          mainTitle: data.status,
        ),
        _RowWidget(
            icon: Icon(
              Icons.arrow_back,
            ),
            subTitle: 'Species',
            mainTitle: data.species),
        _RowWidget(
          icon: Icon(
            Icons.arrow_back,
          ),
          subTitle: 'Gender',
          mainTitle: data.gender,
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

enum Status {
  alive,
  dead,
  unknown;

  static Status fromString(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Status.alive;
      case 'dead':
        return Status.dead;
      case 'unknown':
        return Status.unknown;
      default:
        throw ArgumentError('Unknown status: $status');
    }
  }
}
