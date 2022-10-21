import 'package:flutter/material.dart';

class UnsusedTextInputField extends StatefulWidget {
  // the controllers arent functional, bc 3 inputs use the same
  TextEditingController passedController;
  FocusNode passedFocus;
  UnsusedTextInputField({
    super.key,
    required this.passedController,
    required this.passedFocus,
  });

  @override
  State<UnsusedTextInputField> createState() => _UnsusedTextInputFieldState();
}

class _UnsusedTextInputFieldState extends State<UnsusedTextInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: Theme.of(context).canvasColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                side: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontSize: 16,
                        ),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(width: 0)),
                  ),
                  controller: widget.passedController,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(widget.passedFocus);
                  },
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            autofocus: false,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
            decoration: InputDecoration(
              hintText: 'Card holder name',
              hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: 16,
                  ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    width: 1,
                    color:
                        Theme.of(context).colorScheme.surface), //<-- SEE HERE
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    width: 1,
                    color:
                        Theme.of(context).colorScheme.surface), //<-- SEE HERE
              ),
            ),
            //wtf
            //controller: _nameController,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(widget.passedFocus);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            autofocus: false,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 16,
                ),
            decoration: InputDecoration(
              hintText: 'Post Code',
              hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: 16,
                  ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    width: 1,
                    color:
                        Theme.of(context).colorScheme.surface), //<-- SEE HERE
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    width: 1,
                    color:
                        Theme.of(context).colorScheme.surface), //<-- SEE HERE
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    BorderSide(width: 1, color: Colors.red), //<-- SEE HERE
              ),
            ),
            controller: widget.passedController,
            validator: (value) {
              bool isZipValid = false;
              if (value != null && value.isEmpty) {
                isZipValid =
                    RegExp(r"/(^\d{5}$)|(^\d{5}-\d{4}$)/", caseSensitive: false)
                        .hasMatch(value);
                if (isZipValid) {
                  // yay zip is valid
                  return null;
                }
              }
              return 'Not a Valid Post Code';
            },
          ),
        ),
      ],
    );
  }
}

// Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   textInputAction: TextInputAction.next,
//                   autofocus: false,
//                   textAlign: TextAlign.start,
//                   style: Theme.of(context).textTheme.bodyText1?.copyWith(
//                         fontSize: 16,
//                       ),
//                   decoration: InputDecoration(
//                     hintText: 'Post Code',
//                     hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
//                           fontSize: 16,
//                         ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       borderSide: BorderSide(
//                           width: 1,
//                           color: Theme.of(context)
//                               .colorScheme
//                               .surface), //<-- SEE HERE
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       borderSide: BorderSide(
//                           width: 1,
//                           color: Theme.of(context)
//                               .colorScheme
//                               .surface), //<-- SEE HERE
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       borderSide: const BorderSide(
//                           width: 1, color: Colors.red), //<-- SEE HERE
//                     ),
//                   ),
//                   controller: _postcodeController,
//                   validator: (value) {
//                     bool isZipValid = false;
//                     if (value != null && value.isEmpty) {
//                       isZipValid = RegExp(r"/(^\d{5}$)|(^\d{5}-\d{4}$)/",
//                               caseSensitive: false)
//                           .hasMatch(value);
//                       if (isZipValid) {
//                         // yay zip is valid
//                         return null;
//                       }
//                     }
//                     return 'Not a Valid Post Code';
//                   },
//                 ),
//               ),
