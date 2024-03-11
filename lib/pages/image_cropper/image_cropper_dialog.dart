// import 'dart:async';
// import 'dart:io';
//
// import 'package:crop/crop.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
//
// import '../../core/constants.dart';
// import '../../flutter_i18n/translation_keys.dart';
// import '../../widgets/close_icon.dart';
// import '../../widgets/elevated_button.dart';
//
// class ImageCropperDialog extends StatefulWidget {
//   final PlatformFile imageFile;
//
//   const ImageCropperDialog._({
//     required this.imageFile,
//   });
//
//   static Future<PlatformFile?> show(
//     BuildContext context, {
//     required PlatformFile imageFile,
//   }) {
//     return showDialog(
//       context: context,
//       builder: (_) => Dialog(
//         child: ImageCropperDialog._(
//           imageFile: imageFile,
//         ),
//       ),
//     );
//   }
//
//   @override
//   _ImageCropperDialogState createState() => _ImageCropperDialogState();
// }
//
// class _ImageCropperDialogState extends State<ImageCropperDialog> {
//   final _controller = CropController();
//   bool showCropper = true;
//   Timer? timer;
//
//   @override
//   void initState() {
//     // timer = Timer(const Duration(milliseconds: 100), () {
//     //   showCropper = true;
//     //   setState(() {});
//     // });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints(
//         maxWidth: DIALOG_WIDTH,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsetsDirectional.only(
//               top: 7,
//               end: 7,
//             ),
//             child: Align(
//               alignment: AlignmentDirectional.centerEnd,
//               child: CloseIcon(
//                 onTap: Navigator.of(context).pop,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 20,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Crop',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 if (showCropper) ...[
//                   SizedBox(
//                     height: 200,
//                     child: Crop(
//                       dimColor: Colors.transparent,
//                       shape: BoxShape.circle,
//                       controller: _controller,
//                       child: widget.imageFile.path != null
//                           ? Image.file(File(widget.imageFile.path!))
//                           : Image.memory(widget.imageFile.bytes!),
//                     ),
//                   ),
//                 ] else ...[
//                   Center(
//                     child: Text(translate(
//                         context, TranslationKeys.General_Please_Wait)!),
//                   ),
//                 ],
//                 const SizedBox(height: 16),
//                 if (showCropper) ...[
//                   Align(
//                     alignment: AlignmentDirectional.centerEnd,
//                     child: WCElevatedButton(
//                       'Crop',
//                       onTap: _controller.crop,
//                     ),
//                   ),
//                 ],
//                 const SizedBox(height: 16),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
