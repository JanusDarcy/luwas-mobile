import 'package:flutter/material.dart';

// Define a simple class for chat messages to manage different types of content
class ChatMessage {
  final String text;
  final bool isUser; // true for user, false for executive
  final List<String>? options; // For executive messages that offer choices
  final bool isDateSeparator; // To mark date messages like "June 13, 2022"
  final bool isStatusMessage; // For messages with a distinct style (e.g., confirmation)

  ChatMessage({
    this.text = '',
    required this.isUser,
    this.options,
    this.isDateSeparator = false,
    this.isStatusMessage = false,
  });
}

class ChatSupportPage extends StatefulWidget {
  const ChatSupportPage({super.key});

  @override
  State<ChatSupportPage> createState() => _ChatSupportPageState();
}

class _ChatSupportPageState extends State<ChatSupportPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = []; // List to hold all chat messages
  final ScrollController _scrollController = ScrollController(); // Controller for scrolling chat

  @override
  void initState() {
    super.initState();
    // Initialize chat with initial executive messages and options for travel issues
    _messages.add(ChatMessage(text: "You're currently talking with our executive", isUser: false));
    _messages.add(ChatMessage(text: "May 28, 2025", isUser: false, isDateSeparator: true)); // Updated date
    _messages.add(ChatMessage(
      text: "Hello! How can I assist you with your travel today?",
      isUser: false,
      options: [
        "Flight Delay/Cancellation",
        "Lost Luggage",
        "Booking Modification",
        "Emergency Assistance",
        "Other Issue"
      ],
    ));

    // Listen for changes in messages to scroll to the bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Function to handle sending a text message
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(text: _messageController.text, isUser: true));
      });
      // Simulate an executive reply after a short delay
      _simulateExecutiveReply(_messageController.text);
      _messageController.clear();
      _scrollToBottom(); // Scroll to the new message
    }
  }

  // Function to handle taps on option buttons (travel issues)
  void _handleOptionTap(String option) {
    setState(() {
      _messages.add(ChatMessage(text: option, isUser: true)); // Add the user's selected option as a message
    });
    // Simulate executive reply based on the selected travel issue option
    if (option == "Flight Delay/Cancellation") {
      setState(() {
        _messages.add(ChatMessage(
          text: "I understand. Please provide your flight number and airline.",
          isUser: false,
        ));
        _messages.add(ChatMessage(text: "Issue Reported: Flight Delay/Cancellation", isUser: false, isStatusMessage: true));
        _messages.add(ChatMessage(text: "Confirmation: We've received your request.", isUser: false, isStatusMessage: true));
      });
    } else if (option == "Lost Luggage") {
      setState(() {
        _messages.add(ChatMessage(
          text: "I'm sorry to hear about your luggage. Can you provide your baggage claim tag number and flight details?",
          isUser: false,
        ));
        _messages.add(ChatMessage(text: "Issue Reported: Lost Luggage", isUser: false, isStatusMessage: true));
        _messages.add(ChatMessage(text: "Confirmation: We've initiated a search.", isUser: false, isStatusMessage: true));
      });
    } else if (option == "Booking Modification") {
      setState(() {
        _messages.add(ChatMessage(
          text: "What changes would you like to make to your booking? Please provide your booking reference.",
          isUser: false,
        ));
        _messages.add(ChatMessage(text: "Issue Reported: Booking Modification", isUser: false, isStatusMessage: true));
        _messages.add(ChatMessage(text: "Confirmation: Request for modification received.", isUser: false, isStatusMessage: true));
      });
    } else if (option == "Emergency Assistance") {
      setState(() {
        _messages.add(ChatMessage(
          text: "Please describe your emergency and your current location. We will connect you to the appropriate support immediately.",
          isUser: false,
        ));
        _messages.add(ChatMessage(text: "Issue Reported: Emergency Assistance", isUser: false, isStatusMessage: true));
        _messages.add(ChatMessage(text: "Confirmation: Emergency team notified.", isUser: false, isStatusMessage: true));
      });
    } else if (option == "Other Issue") {
      setState(() {
        _messages.add(ChatMessage(
          text: "Please describe your issue in detail. Our executive will review it.",
          isUser: false,
        ));
        _messages.add(ChatMessage(text: "Issue Reported: Other Issue", isUser: false, isStatusMessage: true));
        _messages.add(ChatMessage(text: "Confirmation: Your query is being processed.", isUser: false, isStatusMessage: true));
      });
    }
    _scrollToBottom(); // Scroll to the new messages
  }

  // Basic function to simulate an executive reply based on text input
  void _simulateExecutiveReply(String userMessage) {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (userMessage.toLowerCase().contains("flight number")) {
          _messages.add(ChatMessage(text: "Thank you. We are checking the status of your flight.", isUser: false));
        } else if (userMessage.toLowerCase().contains("baggage tag")) {
          _messages.add(ChatMessage(text: "Got it. We are tracing your luggage now.", isUser: false));
        } else if (userMessage.toLowerCase().contains("booking reference")) {
          _messages.add(ChatMessage(text: "Understood. We are looking into your booking details.", isUser: false));
        } else if (userMessage.toLowerCase().contains("location")) {
          _messages.add(ChatMessage(text: "Assistance is being dispatched to your location.", isUser: false));
        } else {
          _messages.add(ChatMessage(text: "Thank you for the information. An executive will be with you shortly.", isUser: false));
        }
      });
      _scrollToBottom(); // Scroll to the new reply
    });
  }

  // Function to scroll the chat to the bottom
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Luwas Travel App Logo
            // IMPORTANT: You need to add your logo image file to the 'assets/' folder
            // and declare it in your pubspec.yaml file under the 'flutter: assets:' section.
            // Example: Image.asset('assets/luwas_logo.png', height: 30),
            // For now, using a placeholder icon, replace with your actual logo asset.
            const Icon(Icons.flight_takeoff, color: Colors.white, size: 30), // Placeholder icon
            const SizedBox(width: 10), // Spacing between logo and title
            const Text("Luwas Travel App Support"), // Changed title for clarity
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor, // Use your app's primary color
      ),
      body: Column(
        children: [
          // Expanded area for chat messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Attach the scroll controller
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];

                // Render date separator messages
                if (message.isDateSeparator) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        message.text,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  );
                }
                // Render status messages (e.g., "Issue Reported", "Confirmation")
                else if (message.isStatusMessage) {
                  return Align(
                    alignment: Alignment.centerRight, // Status messages align to the right
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.green[500], // Green background for status messages
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        message.text,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  );
                }
                // Render regular chat bubbles
                else {
                  return Align(
                    alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            // Use different colors for user and executive messages
                            color: message.isUser ? Theme.of(context).colorScheme.secondary.withOpacity(0.8) : Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: message.isUser ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                        // Display option buttons if available for executive messages
                        if (message.options != null && !message.isUser)
                          Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 8.0, // Space between buttons
                            runSpacing: 4.0, // Space between lines of buttons
                            children: message.options!.map((option) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white, // White background for option buttons
                                  foregroundColor: Theme.of(context).primaryColor, // Blue text for option buttons
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: Theme.of(context).primaryColor), // Blue border
                                  ),
                                  elevation: 0, // No shadow for option buttons
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                ),
                                onPressed: () => _handleOptionTap(option),
                                child: Text(option),
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          // The message input bar at the bottom (retained from previous version)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(
                          color: const Color(0xFF185C7C),
                          width: 1.0,
                        ),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}