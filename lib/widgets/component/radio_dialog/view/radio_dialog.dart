import 'package:app_qldt/blocs/app_setting/app_setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RadioAlertDialog<T> extends StatefulWidget {
  final List<T> optionsList;
  final T currentOption;
  final String Function(T) stringFunction;
  final Color Function(T)? radioColorFunction;
  final void Function(T) onSelect;
  final TextStyle? optionTextStyle;
  final List<Widget>? actions;
  final Widget? title;

  const RadioAlertDialog({
    Key? key,
    required this.optionsList,
    required this.currentOption,
    required this.stringFunction,
    required this.onSelect,
    this.optionTextStyle,
    this.radioColorFunction,
    this.actions,
    this.title,
  }) : super(key: key);

  @override
  _RadioAlertDialogState<T> createState() => _RadioAlertDialogState<T>();
}

class _RadioAlertDialogState<T> extends State<RadioAlertDialog<T>> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: _listTiles(widget.currentOption),
      ),
      actions: widget.actions,
    );
  }

  List<Widget> _listTiles(T currentOption) {
    List<Widget> tiles = [];
    final themeData = context.read<AppSettingBloc>().state.theme.data;

    for (var option in widget.optionsList) {
      tiles.add(
        InkWell(
          onTap: () => widget.onSelect(option),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 12,
            ),
            child: Row(
              children: <Widget>[
                _radio(option, currentOption),
                Text(
                  widget.stringFunction(option),
                  style: widget.optionTextStyle ?? TextStyle(color: themeData.secondaryTextColor),
                )
              ],
            ),
          ),
        ),
      );
    }

    return tiles;
  }

  Widget _radio(T option, T currentOption) {
    if (widget.radioColorFunction == null) {
      return Radio<T>(
        value: option,
        groupValue: currentOption,
        onChanged: (_) => widget.onSelect(option),
      );
    }

    return _CustomRadio(
      color: widget.radioColorFunction!(option),
      isSelected: option == currentOption,
    );
  }
}

class _CustomRadio extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const _CustomRadio({
    Key? key,
    required this.color,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: isSelected ? color : null,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            width: 4,
            color: color,
          ),
        ),
      ),
    );
  }
}
