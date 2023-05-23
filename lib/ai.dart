import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';

class AiPage extends StatefulWidget {
  @override
  _AiPageState createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  List<ChatMessage> _messages = [];
  TextEditingController _textEditingController = TextEditingController();
  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type your message...',
                    ),
                    onSubmitted: _handleSubmitted,
                    onChanged: (text) {
                      setState(() {
                        _isTyping = text.isNotEmpty;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _isTyping
                      ? () => _handleSubmitted(_textEditingController.text)
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textEditingController.clear();
    setState(() {
      _isTyping = false;
      _messages.insert(0, ChatMessage(text: text, isUser: true));
    });

    _simulateChatResponse(text);
  }

  void _simulateChatResponse(String userInput) {
    // Simulate chatbot response after a delay
    Future.delayed(Duration(seconds: 1), () {
      String response = _getChatbotResponse(userInput);
      setState(() {
        _isTyping = true;
        _messages.insert(0, ChatMessage(text: response, isUser: false));
      });
      // Simulate "typing" indicator after a delay
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isTyping = false;
        });
      });
    });
  }

  String _getChatbotResponse(String userInput) {
    List<String> tokens = userInput.toLowerCase().split(' ');

    if (tokens.contains('hi') ||
        tokens.contains('hello') ||
        tokens.contains('hola')) {
      return 'Hello! How can I assist you today?';
    } else if (tokens.contains('help')) {
      return 'I understand you need help. Can you provide more details about your situation?';
    } else if (tokens.contains('danger')) {
      return 'I\'m sorry to hear that you\'re in danger. Please try to find a safe location and contact the authorities.';
    } else if (tokens.contains('safe spot')) {
      return 'Finding the nearest safe spot...';
    } else if (tokens.contains('weather')) {
      // Add weather API integration here
      return 'The current weather is sunny.';
    } else if (tokens.contains('suggestions')) {
      return 'Here are some suggestions for women: [Add your suggestions here]';
    } else if (tokens.contains('safety tips')) {
      return 'Here are some safety tips for women: [Add your safety tips here]';
    } else {
      return 'I\'m sorry, but I\'m unable to understand your request. Could you please rephrase or provide more information?';
    }
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          message.text,
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}
