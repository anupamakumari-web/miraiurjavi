import 'package:google_fonts/google_fonts.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:pinput/pinput.dart';

part 'pin_input_builder.g.dart';

@jsonWidget
abstract class _PinInputBuilder extends JsonWidgetBuilder {
  const _PinInputBuilder({required super.args});

  @override
  _PinInput buildCustom({
    ChildWidgetBuilder? childBuilder,
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
  }) {
    return _PinInput(
      key: key,
      onChanged: args['onChanged'],
      length: JsonClass.parseInt(args['length']),
      cursor: args['cursor'] != null
          ? JsonWidgetData.fromDynamic(args['cursor']).build(context: context)
          : null,
    );
  }
}

class _PinInput extends StatefulWidget {
  _PinInput({
    this.length,
    this.onChanged,
    this.controller,
    this.cursor,
    super.key,
  });

  final int? length;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final Widget? cursor;

  @override
  State<_PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<_PinInput> {
  final focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: widget.length ?? 4,
      controller: widget.controller,
      focusNode: focusNode,
      separatorBuilder: (index) {
        return SizedBox(width: 16);
      },
      defaultPinTheme: PinTheme(
        width: 50,
        height: 50,
        textStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0XFF2E3849),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0XFFBABABA)),
        ),
      ),
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      onChanged: widget.onChanged,
      cursor: widget.cursor,
      focusedPinTheme: PinTheme(
        width: 50,
        height: 50,
        textStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0XFF2E3849),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0XFFBABABA)),
        ),
      ),
      submittedPinTheme: PinTheme(
        width: 50,
        height: 50,
        textStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0XFF2E3849),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0XFFBABABA)),
        ),
      ),
      errorPinTheme: PinTheme(
        width: 50,
        height: 50,
        textStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0XFF2E3849),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.redAccent),
        ),
      ),
    );
  }
}
