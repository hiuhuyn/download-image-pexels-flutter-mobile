import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class FullScreenWallpaperImagePage extends StatefulWidget {
  final ImageProvider? image;
  final String url;
  const FullScreenWallpaperImagePage(
      {super.key, this.image, required this.url});

  @override
  State<FullScreenWallpaperImagePage> createState() =>
      FullwScreenWaStatellpaperPage();
}

class FullwScreenWaStatellpaperPage
    extends State<FullScreenWallpaperImagePage> {
  late Stream<DateTime> _dateTimeStream;
  late StreamSubscription<DateTime> _dateTimeSubscription;
  DateTime _currentDateTime = DateTime.now();
  bool _isShowAppBar = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentDateTime = DateTime.now();
    _dateTimeStream = Stream<DateTime>.periodic(
        const Duration(seconds: 1), (_) => DateTime.now());
    _dateTimeSubscription = _dateTimeStream.listen((dateTime) {
      if (_currentDateTime.minute != dateTime.minute) {
        setState(() {
          _currentDateTime = dateTime;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _dateTimeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isShowAppBar = !_isShowAppBar;
            });
          },
          child: widget.image != null
              ? Image(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  image: widget.image!,
                  fit: BoxFit.fitHeight,
                )
              : CachedNetworkImage(
                  imageUrl: widget.url,
                  imageBuilder: (context, imageProvider) {
                    return Image(
                      image: imageProvider,
                      fit: BoxFit.fitHeight,
                    );
                  },
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height:
              _isShowAppBar ? (MediaQuery.of(context).size.height * 0.1) : 0,
          child: AppBar(
            backgroundColor: Colors.transparent.withOpacity(0.3),
            elevation: 1,
            foregroundColor: Colors.white,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "${_currentDateTime.hour}:${_currentDateTime.minute}",
                style: const TextStyle(
                    fontSize: 100,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                "${_currentDateTime.day}/${_currentDateTime.month}/${_currentDateTime.year}",
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
              const Spacer(
                flex: 4,
              ),
            ],
          ),
        )
      ],
    ));
  }
}
