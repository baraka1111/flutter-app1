import 'dart:async';
import 'dart:convert';
import 'dart:typed_data' as td;

import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact> _contacts = const [];
  String? _text;

  bool _isLoading = false;

  List<ContactField> _fields = ContactField.values.toList();

  final _ctrl = ScrollController();

  Future<void> loadContacts() async {
    try {
      await Permission.contacts.request();
      _isLoading = true;
      if (mounted) setState(() {});
      final sw = Stopwatch()..start();
      _contacts = await FastContacts.getAllContacts(fields: _fields);
      sw.stop();
      _text =
          'Contacts: ${_contacts.length}\nTook: ${sw.elapsedMilliseconds}ms';
    } on PlatformException catch (e) {
      _text = 'Failed to get contacts:\n${e.details}';
    } finally {
      _isLoading = false;
    }
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: loadContacts,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 24,
                  width: 24,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Icon(Icons.refresh),
                  ),
                ),
              ],
            ),
          ),
          ExpansionTile(
            title: Row(
              children: [
                Text('Fields:'),
                const SizedBox(width: 8),
                const Spacer(),
                TextButton(
                  child: Row(
                    children: [
                      if (_fields.length == ContactField.values.length) ...[
                        Icon(Icons.check),
                        const SizedBox(width: 8),
                      ],
                      Text('All'),
                    ],
                  ),
                  onPressed: () => setState(() {
                    _fields = ContactField.values.toList();
                  }),
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: Row(
                    children: [
                      if (_fields.length == 0) ...[
                        Icon(Icons.check),
                        const SizedBox(width: 8),
                      ],
                      Text('None'),
                    ],
                  ),
                  onPressed: () => setState(() {
                    _fields.clear();
                  }),
                ),
              ],
            ),
            children: [
              Wrap(
                spacing: 4,
                children: [
                  for (final field in ContactField.values)
                    ChoiceChip(
                      label: Text(field.name),
                      selected: _fields.contains(field),
                      onSelected: (selected) => setState(() {
                        if (selected) {
                          _fields.add(field);
                        } else {
                          _fields.remove(field);
                        }
                      }),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(_text ?? 'Tap to load contacts', textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Expanded(
            child: Scrollbar(
              controller: _ctrl,
              interactive: true,
              thickness: 24,
              child: ListView.builder(
                controller: _ctrl,
                itemCount: _contacts.length,
                itemExtent: _ContactItem.height,
                itemBuilder: (_, index) =>
                    _ContactItem(contact: _contacts[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({
    Key? key,
    required this.contact,
  }) : super(key: key);

  static final height = 86.0;

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final phones = contact.phones.map((e) => e.number).join(', ');
    final emails = contact.emails.map((e) => e.address).join(', ');
    final name = contact.structuredName;
    final nameStr = name != null
        ? [
            if (name.namePrefix.isNotEmpty) name.namePrefix,
            if (name.givenName.isNotEmpty) name.givenName,
            if (name.middleName.isNotEmpty) name.middleName,
            if (name.familyName.isNotEmpty) name.familyName,
            if (name.nameSuffix.isNotEmpty) name.nameSuffix,
          ].join(', ')
        : '';
    final organization = contact.organization;
    final organizationStr = organization != null
        ? [
            if (organization.company.isNotEmpty) organization.company,
            if (organization.department.isNotEmpty) organization.department,
            if (organization.jobDescription.isNotEmpty)
              organization.jobDescription,
          ].join(', ')
        : '';

    return SizedBox(
      height: height,
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => _ContactDetailsPage(
              contactId: contact.id,
            ),
          ),
        ),
        leading: _ContactImage(contact: contact),
        title: Text(
          contact.displayName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (phones.isNotEmpty)
              Text(
                phones,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (emails.isNotEmpty)
              Text(
                emails,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (nameStr.isNotEmpty)
              Text(
                nameStr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (organizationStr.isNotEmpty)
              Text(
                organizationStr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}

class _ContactDetailsPage extends StatefulWidget {
  const _ContactDetailsPage({Key? key, required this.contactId})
      : super(key: key);

  final String contactId;

  @override
  State<_ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<_ContactDetailsPage> {
  late Future<Contact?> _contactFuture;
  Duration? _timeTaken;

  @override
  void initState() {
    super.initState();
    final sw = Stopwatch()..start();
    _contactFuture = FastContacts.getContact(widget.contactId).then((value) {
      _timeTaken = (sw..stop()).elapsed;
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Details'), centerTitle: true),
      body: FutureBuilder<Contact?>(
        future: _contactFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final contact = snapshot.data;
          if (contact == null) {
            return const Center(child: Text('Contact not found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Image
                _ContactImage(contact: contact),
                const SizedBox(height: 16),

                // Contact Name
                Text(
                  contact.displayName,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),

                // Contact Details (Phone, Email, etc.)
                _ContactDetails(contact: contact),

                // Action Buttons
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ActionButton(
                      icon: Icons.call,
                      label: 'Call',
                      color: Colors.green,
                      onPressed: () {
                        // Handle call action
                      },
                    ),
                    const SizedBox(width: 16),
                    _ActionButton(
                      icon: Icons.message,
                      label: 'Message',
                      color: Colors.blue,
                      onPressed: () {
                        // Handle message action
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Profile Image Widget
class _ContactImage extends StatefulWidget {
  const _ContactImage({Key? key, required this.contact}) : super(key: key);

  final Contact contact;

  @override
  State<_ContactImage> createState() => _ContactImageState();
}

class _ContactImageState extends State<_ContactImage> {
  late Future<Uint8List?> _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = FastContacts.getContactImage(widget.contact.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _imageFuture,
      builder: (context, snapshot) {
        return CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[300],
          child: snapshot.hasData && snapshot.data != null
              ? ClipOval(
                  child: Image.memory(
                    snapshot.data!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    gaplessPlayback: true, // Smooth image updates
                  ),
                )
              : const Icon(Icons.person, size: 50, color: Colors.grey),
        );
      },
    );
  }
}

// Contact Details Widget
class _ContactDetails extends StatelessWidget {
  final Contact contact;

  const _ContactDetails({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (contact.phones.isNotEmpty)
          _DetailRow(icon: Icons.phone, text: contact.phones.first.number),
        if (contact.emails.isNotEmpty)
          _DetailRow(icon: Icons.email, text: contact.emails.first.address),
      ],
    );
  }
}

// Single Detail Row Widget
class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DetailRow({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: Colors.blueGrey),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

// Action Button Widget
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton(
      {Key? key,
      required this.icon,
      required this.label,
      required this.color,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
