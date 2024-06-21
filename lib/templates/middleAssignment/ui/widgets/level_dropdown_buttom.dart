import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:education/templates/middleAssignment/ui/theme/constants.dart';
import 'package:flutter/material.dart';

class LevelDropdownButton extends StatefulWidget {
  final Function(String value) function;

  const LevelDropdownButton({super.key, required this.function});

  @override
  State<LevelDropdownButton> createState() => _StatusDropdownButton();
}

class _StatusDropdownButton extends State<LevelDropdownButton> {
  late String selectedItem;
  @override
  void initState() {
    super.initState();
    selectedItem = "Easy";
    widget.function(selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: DropdownButton2<String>(
          customButton: Container(
            padding: const EdgeInsets.all(smallPaddingSize),
            decoration: BoxDecoration(
              color: bgLevelColors[levelList.indexOf(selectedItem)],
              border: Border.all(
                  color: levelColors[levelList.indexOf(selectedItem)],
                  width: 1),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedItem,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                const Padding(padding: EdgeInsets.only(left: tinyPaddingSize)),
                const Icon(
                  Icons.arrow_downward_rounded,
                  size: smallIconSize,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          isExpanded: true,
          dropdownStyleData: DropdownStyleData(
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            selectedMenuItemBuilder: (ctx, child) {
              return Container(
              
                child: child,
              );
            },
          ),
          alignment: Alignment.center,
          value: selectedItem,
          style: TextStyle(backgroundColor: Colors.white),
          onChanged: (value) {
            setState(() {
              selectedItem = value!;
             
            });
             widget.function(selectedItem);
          },
          items: levelList.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      maxLines: 1,
                      item,
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
