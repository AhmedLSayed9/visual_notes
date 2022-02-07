import 'package:flutter_test/flutter_test.dart';
import 'package:visual_notes/core/utils/validators.dart';

void main() {
  group('Add/Edit Note Form Field Validate', () {
    group('Note Id Validate', () {
      test('Given empty id When validate called Then validator is triggered',
          () async {
        // ARRANGE
        const id = '';
        // ACT
        final result = Validators.instance.validateInteger(id);
        // ASSERT
        expect(result, 'ThisFieldIsEmpty');
      });

      test(
          'Given non-numeric id When validate called Then validator is triggered',
          () async {
        const id = 'ABC123';
        final result = Validators.instance.validateInteger(id);
        expect(result, 'pleaseEnterOnlyNumericValues');
      });

      test(
          'Given more than 30 numbers id When validate called Then validator is triggered',
          () async {
        const id = '123456789123456789123456789123456789';
        final result = Validators.instance.validateInteger(id);
        expect(result, 'idMustBeAtMost30Numbers');
      });

      test(
          'Given valid id When validate called Then validator is not triggered',
          () async {
        const id = '1234';
        final result = Validators.instance.validateInteger(id);
        expect(result, null);
      });
    });

    group('Note Title Validate', () {
      test('Given empty title When validate called Then validator is triggered',
          () async {
        const title = '';
        final result = Validators.instance.validateTitle(title);
        expect(result, 'ThisFieldIsEmpty');
      });

      test(
          'Given more than 30 chars title When validate called Then validator is triggered',
          () async {
        const title = '123456789123456789123456789123456789';
        final result = Validators.instance.validateTitle(title);
        expect(result, 'titleMustBeAtMost30Letters');
      });

      test(
          'Given valid title When validate called Then validator is not triggered',
          () async {
        const title = 'title';
        final result = Validators.instance.validateTitle(title);
        expect(result, null);
      });
    });

    group('Note Description Validate', () {
      test(
          'Given empty description When validate called Then validator is triggered',
          () async {
        const description = '';
        final result = Validators.instance.validateDescription(description);
        expect(result, 'ThisFieldIsEmpty');
      });

      test(
          'Given valid description When validate called Then validator is not triggered',
          () async {
        const description = 'description';
        final result = Validators.instance.validateDescription(description);
        expect(result, null);
      });
    });
  });
}
