public class HebrewDateFormatter {
    
    private static final String GERESH = '׳';
    private static final String GERSHAYIM = '״';

    private static final List<String> hebrewDays = new List<String>{
        'יום ראשון', 'יום שני', 'יום שלישי', 'יום רביעי', 'יום חמישי', 'יום שישי', 'שבת'
    };

    private static final List<String> hebrewMonths = new List<String>{
        'טבת',     // ינואר
        'שבט',     // פברואר
        'אדר',     // מרץ
        'ניסן',     // אפריל
        'אייר',     // מאי
        'סיוון',    // יוני
        'תמוז',     // יולי
        'אב',       // אוגוסט
        'אלול',     // ספטמבר
        'תשרי',     // אוקטובר
        'חשוון',    // נובמבר
        'כסלו'      // דצמבר
    };

    private static final Map<Integer, String> gematriaMap = new Map<Integer, String>{
        1 => 'א', 2 => 'ב', 3 => 'ג', 4 => 'ד', 5 => 'ה', 6 => 'ו', 7 => 'ז', 8 => 'ח', 9 => 'ט',
        10 => 'י', 20 => 'כ', 30 => 'ל', 40 => 'מ', 50 => 'נ', 60 => 'ס', 70 => 'ע', 80 => 'פ', 90 => 'צ',
        100 => 'ק', 200 => 'ר', 300 => 'ש', 400 => 'ת'
    };


    // Invocable method for use in Flow/Process Builder
    @InvocableMethod(label='Format Hebrew Date' description='Formats a Gregorian date to Hebrew date format')
    public static List<String> formatHebrewDate(List<Date> dateToFormat) {
        List<String> formattedDates = new List<String>();
        
        // Loop through each date in the input list
        for (Date dateVal : dateToFormat) {
            if (dateVal != null) {
                // Call the existing method to format the date
                String formattedDate = formatFullHebrewDate(dateVal);
                formattedDates.add(formattedDate);
            } else {
                // If the date is null, add an empty string
                formattedDates.add('');
            }
        }
        return formattedDates;
    }


    public static String formatFullHebrewDate(Date dateVal) {
        if (dateVal == null) return '';

        Integer dayOfWeek = dateVal.toStartOfWeek().daysBetween(dateVal); 
        String dayNameHeb = hebrewDays[dayOfWeek];

        Integer dayNum = dateVal.day();
        String dayInHebrew = convertNumberToHebrewDay(dayNum);

        String monthName = hebrewMonths[dateVal.month() - 1];

        Integer gregYear = dateVal.year();
        Integer hebrewYear = gregYear + 3760; // המרה מקורבת
        String hebrewYearStr = convertNumberToHebrewYear(hebrewYear);

        return dayNameHeb + ', ' + dayInHebrew + ' ב' + monthName + ' ' + hebrewYearStr;
    }

    private static String convertNumberToHebrewYear(Integer num) {
        Integer remaining = Math.mod(num, 1000);
        String result = '';

        List<Integer> values = new List<Integer>{400, 300, 200, 100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1};
        for (Integer val : values) {
            while (remaining >= val) {
                result += gematriaMap.get(val);
                remaining -= val;
            }
        }

        if (result.length() >= 2) {
            result = result.substring(0, result.length()-1) + GERSHAYIM + result.substring(result.length()-1);
        } else if (result.length() == 1) {
            result += GERESH;
        }

        return result;
    }

    private static String convertNumberToHebrewDay(Integer num) {
        if (num == null || num <= 0 || num > 31) return '';

        List<Integer> values = new List<Integer>{400, 300, 200, 100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1};
        String result = '';
        Integer remaining = num;

        for (Integer val : values) {
            while (remaining >= val) {
                result += gematriaMap.get(val);
                remaining -= val;
            }
        }

        if (result.length() >= 2) {
            result = result.substring(0, result.length()-1) + GERSHAYIM + result.substring(result.length()-1);
        } else if (result.length() == 1) {
            result += GERESH;
        }

        return result;
    }
}
