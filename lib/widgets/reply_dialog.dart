import 'package:flutter/material.dart';

class ReplyDialog extends StatefulWidget {
  const ReplyDialog({super.key});

  @override
  _ReplyDialogState createState() => _ReplyDialogState();
}

class _ReplyDialogState extends State<ReplyDialog> {
  String reply = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Reply to Review'),
      content: TextField(
        onChanged: (val) => setState(() => reply = val),
        decoration: InputDecoration(hintText: "Your reply"),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
        ElevatedButton(onPressed: () => Navigator.pop(context, reply), child: Text('Send')),
      ],
    );
  }
}
