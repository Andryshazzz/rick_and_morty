import 'package:flutter/material.dart';

import '../../entities/character.dart';

class DetailScreen extends StatelessWidget {
  final CharacterEntities data;

  const DetailScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _HeaderWidget(data: data),
          const SizedBox(height: 20),
          _DetailInfo(data: data),
        ],
      ),
    );
  }
}

/////////////////////////////////////Header_Widget//////////////////////////////////////////////

class _HeaderWidget extends StatelessWidget {
  final CharacterEntities data;

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
            data.imageUrl,
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
  final CharacterEntities data;

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
          mainTitle: data.name,
        ),
        _RowWidget(
          icon: Icon(
            Icons.arrow_back,
          ),
          subTitle: 'Status',
          mainTitle: data.status != null ? data.status! : 'ой',
        ),
        _RowWidget(
          icon: Icon(
            Icons.arrow_back,
          ),
          subTitle: 'Species',
          mainTitle: data.species != null ? data.species! : 'ой',
        ),
        _RowWidget(
          icon: Icon(
            Icons.arrow_back,
          ),
          subTitle: 'Gender',
          mainTitle: data.gender != null ? data.gender! : 'ой',
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
