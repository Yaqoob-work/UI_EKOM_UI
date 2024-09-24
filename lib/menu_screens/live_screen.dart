// import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:mobi_tv_entertainment/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:http/http.dart' as https;
// // import 'package:flutter_vlc_player/flutter_vlc_player.dart';
// import '../video_widget/vlc_player_screen.dart'; // Added VLC player package

// void main() {
//   runApp(LiveScreen());
// }

// class LiveScreen extends StatefulWidget {
//   @override
//   _LiveScreenState createState() => _LiveScreenState();
// }

// class _LiveScreenState extends State<LiveScreen> {
//   List<dynamic> entertainmentList = [];
//   List<int> allowedChannelIds = [];
//   bool isLoading = true;
//   String errorMessage = '';
//   bool _isNavigating = false;
//   bool tvenableAll = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchSettings();
//   }

//   Future<void> fetchSettings() async {
//     try {
//       final response = await https.get(
//         Uri.parse('https://api.ekomflix.com/android/getSettings'),
//         headers: {
//           'x-api-key': 'vLQTuPZUxktl5mVW',
//         },
//       );

//       if (response.statusCode == 200) {
//         final settingsData = json.decode(response.body);
//         setState(() {
//           allowedChannelIds = List<int>.from(settingsData['channels']);
//           tvenableAll = settingsData['tvenableAll'] == 1;
//         });

//         fetchEntertainment();
//       } else {
//         throw Exception(
//             'Failed to load settings, status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error in fetchSettings: $e';
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> fetchEntertainment() async {
//     try {
//       final response = await https.get(
//         Uri.parse('https://api.ekomflix.com/android/getFeaturedLiveTV'),
//         headers: {
//           'x-api-key': 'vLQTuPZUxktl5mVW',
//         },
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = json.decode(response.body);

//         setState(() {
//           entertainmentList = responseData.where((channel) {
//             int channelId = int.tryParse(channel['id'].toString()) ?? 0;
//             String channelStatus = channel['status'].toString();

//             return channelStatus.contains('1') &&
//                 (tvenableAll || allowedChannelIds.contains(channelId));
//           }).map((channel) {
//             channel['isFocused'] = false;
//             return channel;
//           }).toList();

//           isLoading = false;
//         });
//       } else {
//         throw Exception(
//             'Failed to load entertainment data, status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error in fetchEntertainment: $e';
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: cardColor,
//       body: isLoading
//           ? Center(
//               child: SpinKitFadingCircle(
//               color: borderColor,
//               size: 50.0,
//             ))
//           : errorMessage.isNotEmpty
//               ? Center(
//                   child: Text(
//                   errorMessage,
//                   style: TextStyle(fontSize: 20),
//                 ))
//               : entertainmentList.isEmpty
//                   ? Center(child: Text('No Channels Available'))
//                   :
//                   // Padding(
//                   // padding: const EdgeInsets.all(10.0),
//                   // child:
//                   Padding(
//                       padding: EdgeInsets.only(top: screenhgt * 0.1),
//                       child: GridView.builder(
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 6,
//                         ),
//                         itemCount: entertainmentList.length,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () => _navigateToVideoScreen(
//                                 context, entertainmentList[index]),
//                             child: _buildGridViewItem(index),
//                           );
//                         },
//                       ),
//                     ),
//       // ),
//     );
//   }

//   Widget _buildGridViewItem(int index) {
//     return Focus(
//       onKeyEvent: (node, event) {
//         if (event is KeyDownEvent &&
//             event.logicalKey == LogicalKeyboardKey.select) {
//           _navigateToVideoScreen(context, entertainmentList[index]);
//           return KeyEventResult.handled;
//         }
//         return KeyEventResult.ignored;
//       },
//       onFocusChange: (hasFocus) {
//         setState(() {
//           entertainmentList[index]['isFocused'] = hasFocus;
//         });
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Stack(
//             children: [
//               AnimatedContainer(
//                 curve: Curves.ease,
//                 width: screenwdt * 0.15,
//                 height: screenhgt * 0.2,
//                 duration: const Duration(milliseconds: 300),
//                 decoration: BoxDecoration(
//                     border: entertainmentList[index]['isFocused']
//                         ? Border.all(
//                             color: hintColor,
//                             width: 5.0,
//                           )
//                         : Border.all(
//                             color: Colors.transparent,
//                             width: 5.0,
//                           ),
//                     borderRadius: BorderRadius.circular(0)),
//                 child: ClipRRect(
//                   child: CachedNetworkImage(
//                     imageUrl: entertainmentList[index]['banner'] ?? '',
//                     placeholder: (context, url) => SizedBox(),
//                     width: screenwdt * 0.15,
//                     height: screenhgt * 0.2,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Positioned(
//                   left: entertainmentList[index]['isFocused'] ? 5 : 0,
//                   right: entertainmentList[index]['isFocused'] ? 5 : 0,
//                   top: entertainmentList[index]['isFocused'] ? 5 : 0,
//                   bottom: entertainmentList[index]['isFocused'] ? 5 : 0,
//                   child: Container(
//                     color: Colors.black26,
//                   ))
//             ],
//           ),
//           Container(
//             width: screenwdt * 0.15,
//             child: Text(
//               (entertainmentList[index]['name'] ?? 'Unknown')
//                   .toString()
//                   .toUpperCase(),
//               style: TextStyle(
//                 fontSize: 15,
//                 color: entertainmentList[index]['isFocused']
//                     ? Colors.yellow
//                     : Colors.white,
//               ),
//               textAlign: TextAlign.center,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _navigateToVideoScreen(
//       BuildContext context, dynamic entertainmentItem) async {
//     if (_isNavigating) return;
//     _isNavigating = true;

//     _showLoadingIndicator(context);

//     try {
//       if (entertainmentItem['stream_type'] == 'YoutubeLive') {
//         final response = await https.get(
//           Uri.parse('https://test.gigabitcdn.net/yt-dlp.php?v=' +
//               entertainmentItem['url']!),
//           headers: {'x-api-key': 'vLQTuPZUxktl5mVW'},
//         );

//         if (response.statusCode == 200) {
//           entertainmentItem['url'] = json.decode(response.body)['url']!;
//           entertainmentItem['stream_type'] = "M3u8";
//         } else {
//           throw Exception(
//               'Failed to load networks, status code: ${response.statusCode}');
//         }
//       }

//       // if (entertainmentItem['stream_type'] == 'VLC') {
//       //   Navigator.push(
//       //     context,
//       //     MaterialPageRoute(
//       //       builder: (context) => VlcPlayerScreen(
//       //         videoUrl: entertainmentItem['url'],
//       //         videoTitle: entertainmentItem['name'],
//       //       ),
//       //     ),
//       //   ).then((_) {
//       //     _isNavigating = false;
//       //     Navigator.of(context, rootNavigator: true).pop();
//       //   });
//       // } else {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => VlcPlayerScreen(
//             videoUrl: entertainmentItem['url'],
//             videoTitle: entertainmentItem['name'],
//             channelList: entertainmentList,
//             onFabFocusChanged: (bool) {},
//             genres: '',
//             channels: [],
//             initialIndex: 1,
//           ),
//         ),
//       ).then((_) {
//         _isNavigating = false;
//         Navigator.of(context, rootNavigator: true).pop();
//       });
//       // }
//     } catch (e) {
//       _isNavigating = false;
//       Navigator.of(context, rootNavigator: true).pop();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Link Error: $e')),
//       );
//     }
//   }

//   void _showLoadingIndicator(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Center(
//             child: SpinKitFadingCircle(
//           color: borderColor,
//           size: 50.0,
//         ));
//       },
//     );
//   }
// }

// // class VlcPlayerScreen extends StatefulWidget {
// // final String videoUrl;
// // final String videoTitle;

// // const VlcPlayerScreen({
// //   Key? key,
// //   required this.videoUrl,
// //   required this.videoTitle,
// // }) : super(key: key);

// //   @override
// //   _VlcPlayerScreenState createState() => _VlcPlayerScreenState();
// // }

// // class _VlcPlayerScreenState extends State<VlcPlayerScreen> {
// //   late VlcPlayerController _vlcPlayerController;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _vlcPlayerController = VlcPlayerController.network(
// //       widget.videoUrl,
// //       hwAcc: HwAcc.full,
// //       autoPlay: true,
// //       options: VlcPlayerOptions(),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _vlcPlayerController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: Stack(
// //         children: [
// //           Center(
// //             child: VlcPlayer(
// //               controller: _vlcPlayerController,
// //               aspectRatio: 16 / 9,
// //               placeholder: Center(child: SpinKitFadingCircle(
// // color: borderColor,
// // size: 50.0,
// // )
// // ),
// //             ),
// //           ),
// //           Positioned(
// //             top: 40,
// //             left: 20,
// //             child: Text(
// //               widget.videoTitle,
// //               style: TextStyle(color: Colors.white, fontSize: 20),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }





import 'dart:async';
import 'package:mobi_tv_entertainment/main.dart';
import 'package:mobi_tv_entertainment/video_widget/socket_service.dart';
import 'package:mobi_tv_entertainment/video_widget/video_screen.dart';
import 'package:mobi_tv_entertainment/widgets/items/news_item.dart';
import 'package:mobi_tv_entertainment/widgets/models/news_item_model.dart';
import 'package:mobi_tv_entertainment/widgets/services/api_service.dart';
import 'package:mobi_tv_entertainment/widgets/small_widgets/empty_state.dart';
import 'package:mobi_tv_entertainment/widgets/small_widgets/error_message.dart';
import 'package:mobi_tv_entertainment/widgets/small_widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class LiveScreen extends StatefulWidget {
  List<NewsItemModel> get entertainmentList => [];

  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  final List<NewsItemModel> _entertainmentList = [];
  final SocketService _socketService = SocketService();
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  String _errorMessage = '';
  bool _isNavigating = false;
  int _maxRetries = 3;
  int _retryDelay = 5; // seconds

  @override
  void initState() {
    super.initState();
    _socketService.initSocket();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      await _apiService.fetchSettings();
      await _apiService.fetchEntertainment();
      setState(() {
        _entertainmentList.addAll(_apiService.allChannelList);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Something Went Wrong';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return LoadingIndicator();
    } else if (_errorMessage.isNotEmpty) {
      return ErrorMessage(message: _errorMessage);
    } else if (_entertainmentList.isEmpty) {
      return EmptyState(message: 'Something Went Wrong');
    } else {
      return _buildNewsList();
    }
  }

  Widget _buildNewsList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        ),
      // scrollDirection: Axis.horizontal,
      itemCount: _entertainmentList.length ,
      itemBuilder: (context, index) {
        return _buildNewsItem(_entertainmentList[index]);
      },
    );
  }

  Widget _buildNewsItem(NewsItemModel item) {
    return NewsItem(
      key: Key(item.id),
      item: item,
      onTap: () => _navigateToVideoScreen(item),
      onEnterPress: _handleEnterPress,
    );
  }

  void _handleEnterPress(String itemId) {
      final selectedItem = _entertainmentList.firstWhere((item) => item.id == itemId);
      _navigateToVideoScreen(selectedItem);
  }

  void _navigateToVideoScreen(NewsItemModel newsItem) async {
    if (_isNavigating) return;
    _isNavigating = true;

    bool shouldPlayVideo = true;
    bool shouldPop = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            shouldPlayVideo = false;
            shouldPop = false;
            return true;
          },
          child: LoadingIndicator(),
        );
      },
    );

    Timer(Duration(seconds: 5), () {
      _isNavigating = false;
    });

    try {
      if (newsItem.streamType == 'YoutubeLive') {
        for (int i = 0; i < _maxRetries; i++) {
          try {
            String updatedUrl = await _socketService.getUpdatedUrl(newsItem.url);
            newsItem = NewsItemModel(
              id: newsItem.id,
              name: newsItem.name,
              description: newsItem.description,
              banner: newsItem.banner,
              url: updatedUrl,
              streamType: 'M3u8',
              genres: newsItem.genres,
              status: newsItem.status,
            );
            break;
          } catch (e) {
            if (i == _maxRetries - 1) rethrow;
            await Future.delayed(Duration(seconds: _retryDelay));
          }
        }
      }

      if (shouldPop) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      if (shouldPlayVideo) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoScreen(
              videoUrl: newsItem.url,
              videoTitle: newsItem.name,
              channelList: _entertainmentList,
              // onFabFocusChanged: (bool) {},
              genres: newsItem.genres,
              channels: [],
              initialIndex: 1,
            ),
          ),
        );
      }
    } catch (e) {
      if (shouldPop) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something Went Wrong')),
      );
    } finally {
      _isNavigating = false;
    }
  }

  @override
  void dispose() {
    _socketService.dispose();
    super.dispose();
  }
}