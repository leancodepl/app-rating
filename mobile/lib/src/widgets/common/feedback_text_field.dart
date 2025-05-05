import 'package:flutter/material.dart';
import 'package:leancode_app_rating/src/utils/strings.dart';
import 'package:leancode_app_rating/src/widgets/common/text_styles.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

class FeedbackTextField extends HookWidget {
  const FeedbackTextField({
    super.key,
    required this.textController,
  });

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    final focusNode = useFocusNode();
    final showLabel = useState<bool>(false);
    focusNode.addListener(() {
      showLabel.value = focusNode.hasFocus;
    });
    useEffect(() => null, [focusNode.hasFocus]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedOpacity(
          opacity: showLabel.value ? 1 : 0,
          duration: const Duration(milliseconds: 60),
          child: Text(s.textFieldHint, style: hintTextStyle),
        ),
        const SizedBox(height: 4),
        TextField(
          focusNode: focusNode,
          controller: textController,
          maxLines: 5,
          maxLength: 500,
          minLines: 5,
          decoration: InputDecoration(
            counter: const SizedBox(),
            hintText: !showLabel.value ? s.textFieldHint : '',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF7E17E5)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFCED3E0)),
            ),
          ),
        ),
      ],
    );
  }
}
