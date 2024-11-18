import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uts_mobile_programing_220010089/models/animal.dart';

void main() {
  final mockAnimalData = [
    Animal(
      id: '1',
      speciesName: 'Chamaeleonidae',
      localName: 'Bunglon',
      description: 'Hewan yang dapat merubah warnanya saat merasa terancam.',
      imageUrl: 'https://example.com/bunglon.jpg',
    ),
    Animal(
      id: '2',
      speciesName: ' Erinaceus Europaeus',
      localName: 'Landak',
      description: 'Hewan yang memiliki duri panjang untuk melindungi dirinya',
      imageUrl: 'https://example.com/landak.jpg',
    ),
  ];

  testWidgets('HomePage renders correctly', (WidgetTester tester) async {
    // Pass mock data to the app
    // Verify that the app bar contains the correct title.
    expect(find.text('Animal Data'), findsOneWidget);

    // Verify that the list of animals is displayed.
    expect(find.byType(ListView), findsOneWidget);

    // Verify that the first animal's name is in the list.
    expect(find.text(mockAnimalData[0].localName), findsOneWidget);
  });

  testWidgets('Navigates to DetailPage when a list item is tapped', (WidgetTester tester) async {
    // Pass mock data to the app

    // Tap on the first list item.
    await tester.tap(find.text(mockAnimalData[0].localName));
    await tester.pumpAndSettle();

    // Verify that the detail page is displayed with correct data.
    expect(find.text(mockAnimalData[0].speciesName), findsOneWidget);
    expect(find.text(mockAnimalData[0].description), findsOneWidget);
  });
}
