import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({Key? key}) : super(key: key);

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  String location = "";

  Future<void> getLocation(context) async {
    bool result = await InternetConnectionChecker().hasConnection;
    try {
      if (result == true) {
        var response = await Dio().get("http://ip-api.com/json");

        if (response.statusCode == 200) {
          if (mounted) {
            setState(() {
              location = response.data["country"].toString();
            });
          }
        } else {
          if (mounted) {
            setState(() {
              location = "${response.statusMessage}";
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            location = "no internet Connection";
          });
        }
      }
    } catch (e) {
     print(e.toString()) ;
    }
  }

  initFunc(context) async {
    await getLocation(context);
  }

  bool isLoading = false;

  @override
  void initState() {
    initFunc(context);

    super.initState();
  }

  @override
  void dispose() {
    getLocation(context).ignore();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('location_setting'.tr(), style: TextStyle(fontSize: 20)),
            IconButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await getLocation(context);
                  setState(() {
                    isLoading = false;
                  });
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        isLoading == false
            ? Text(location)
            : Center(child: CircularProgressIndicator()),
        SizedBox(
          height: 15,
        ),
        Divider(color: Theme.of(context).textTheme.bodyText1?.color),
      ],
    );
  }
}
