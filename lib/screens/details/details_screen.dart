import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/characters_details.dart';
import '../../repos/characters_repo.dart';
import 'details_bloc.dart';

class CharactersDetailsScreenProvider extends StatelessWidget {
  final int characterId;

  const CharactersDetailsScreenProvider({
    super.key,
    required this.characterId,
  });

  @override
  Widget build(BuildContext context) {
    final repository = context.read<CharacterRepository>();
    return BlocProvider<CharactersDetailsBloc>(
      create: (context) => CharactersDetailsBloc(repository: repository),
      child: CharactersDetailsScreen(characterId: characterId),
    );
  }
}

class CharactersDetailsScreen extends StatefulWidget {
  final int characterId;

  const CharactersDetailsScreen({
    super.key,
    required this.characterId,
  });

  @override
  State<CharactersDetailsScreen> createState() =>
      _CharactersDetailsScreenState();
}

class _CharactersDetailsScreenState extends State<CharactersDetailsScreen> {
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
            data.image ??
                'https://i.pinimg.com/736x/85/08/0a/85080afc4cba3d34e2846e435fe3d802.jpg',
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
              child: Icon(
                Icons.arrow_back,
              ),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RowWidget(
          icon: Icon(
            Icons.arrow_back,
          ),
          subTitle: 'Name',
          mainTitle: data.name ?? 'не найдено',
        ),
        _RowWidget(
          icon: Icon(
            Icons.arrow_back,
          ),
          subTitle: 'Status',
          mainTitle: data.status ?? 'не найдено',
        ),
        _RowWidget(
            icon: Icon(
              Icons.arrow_back,
            ),
            subTitle: 'Species',
            mainTitle: data.species ?? 'не найдено'),
        _RowWidget(
          icon: Icon(
            Icons.arrow_back,
          ),
          subTitle: 'Gender',
          mainTitle: data.gender ?? 'не найдено',
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
