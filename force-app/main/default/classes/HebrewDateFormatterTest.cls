@isTest
public class HebrewDateFormatterTest {

    @isTest
    static void testFormatFullHebrewDate() {
        // Creating a test date instance
        Date testDate = Date.newInstance(2025, 4, 25); // April 25, 2025

        // Calling the formatFullHebrewDate function
        String formattedDate = HebrewDateFormatter.formatFullHebrewDate(testDate);

        // Expected result
        String expectedDate = 'יום שישי, כ״ה בניסן תשפ״ה';  // Expected Hebrew date format

        // Asserting that the formatted date matches the expected result
        System.assertEquals(expectedDate, formattedDate, 'The formatted Hebrew date is incorrect');
    }

    @isTest
    static void testNullDate() {
        // Testing for null date
        Date testDate = null;
        String formattedDate = HebrewDateFormatter.formatFullHebrewDate(testDate);

        // The expected result is an empty string when the date is null
        System.assertEquals('', formattedDate, 'The formatted date for null should be an empty string');
    }

    @isTest
    static void testEdgeCases() {
        // Testing edge cases for different dates
        Date testDate1 = Date.newInstance(2025, 1, 1); // January 1, 2025
        Date testDate2 = Date.newInstance(2025, 12, 31); // December 31, 2025

        // Getting formatted dates
        String formattedDate1 = HebrewDateFormatter.formatFullHebrewDate(testDate1);
        String formattedDate2 = HebrewDateFormatter.formatFullHebrewDate(testDate2);

        // Expected results for edge cases
        String expectedDate1 = 'יום חמישי, א׳ בטבת תשפ״ה';
        String expectedDate2 = 'יום רביעי, ל׳ בכסלו תשפ״ה';

        // Asserting that the formatted dates are correct
        System.assertEquals(expectedDate1, formattedDate1, 'The formatted date for January 1, 2025 is incorrect');
        System.assertEquals(expectedDate2, formattedDate2, 'The formatted date for December 31, 2025 is incorrect');
    }
}
