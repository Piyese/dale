import 'package:dale/storeroom/models.dart';
import 'package:dale/widgets/test_formats.dart';
import 'package:flutter/material.dart';

class ActivityTile extends StatefulWidget {
  final Activity activity;

  const ActivityTile({super.key, required this.activity});

  @override
  State<ActivityTile> createState() => _ActivityTileState();
}

class _ActivityTileState extends State<ActivityTile> {
  bool collapsed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: ExpansionTile(
        onExpansionChanged: (collapse){
          setState(() {
            collapsed = !collapsed;
          });
        },
        collapsedShape: Border.all(color: const Color.fromARGB(255, 46, 46, 44)),
        shape:Border.all(color: const Color.fromARGB(255, 37, 104, 138)) ,
        backgroundColor: const Color.fromARGB(255, 185, 198, 204),
        collapsedBackgroundColor: const Color.fromARGB(255, 221, 209, 166),
        textColor: Colors.black,
        collapsedTextColor: const Color.fromARGB(255, 0, 0, 0),
        leading: Text(
          widget.activity.startDate.toString().substring(0,10),
           style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
          ),
        ),
        title: Text(widget.activity.title),
        trailing: !collapsed ? const Icon(Icons.arrow_drop_down_outlined) : const Icon(Icons.arrow_drop_up_outlined),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Subtitle(subtitle: "Description"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.activity.description),
              ),
              widget.activity.cost != null ? const Subtitle(subtitle: "Cost") : const SizedBox(),
              widget.activity.cost != null ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: AdjustableText(
                  text: "Ksh. ${widget.activity.cost}", size: 15, bold: false,
                )
              ) : const SizedBox(),
              widget.activity.daysTaken != null ? const Subtitle(subtitle: "Days Taken") : const SizedBox(),
              widget.activity.daysTaken != null ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${widget.activity.daysTaken.toString()} days'),
              ) : const SizedBox(),
              widget.activity.remarks != null ? const Subtitle(subtitle: "Final Remarks") : const SizedBox(),
              widget.activity.remarks != null ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.activity.remarks!),
              ) : const SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  final String subtitle;
  const Subtitle({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Text(
            subtitle,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline
            ),
          ),
        ),
      ],
    );
  }
}