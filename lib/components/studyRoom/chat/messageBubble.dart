import 'package:cached_network_image/cached_network_image.dart';
import 'package:estudazz_main_code/models/studyRoom/chatMessageModel.dart';
import 'package:estudazz_main_code/models/user/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessageModel message;
  final UserModel sender;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.message,
    required this.sender,
    required this.isMe,
  });

  void _showCopyModal(BuildContext context, String text) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text('Copiar'),
            onTap: () {
              Clipboard.setData(ClipboardData(text: text));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mensagem copiada!')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return ClipOval(
      child: sender.photoUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: sender.photoUrl,
              placeholder: (context, url) => const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/no-profile-photo.png',
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            )
          : Image.asset(
              'assets/images/no-profile-photo.png',
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showCopyModal(context, message.text),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: _buildAvatar(),
            ),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  sender.displayName,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isMe
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[700],
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: isMe
                          ? const Radius.circular(12)
                          : const Radius.circular(0),
                      bottomRight: isMe
                          ? const Radius.circular(0)
                          : const Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        message.text,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('dd/MM/yy HH:mm')
                            .format(message.createdAt.toDate()),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isMe)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: _buildAvatar(),
            ),
        ],
      ),
    );
  }
}
