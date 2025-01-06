final Map<String, List<String>> levelYears = {
  'الإبتدائي': [
    "الأولى إبتدائي",
    "الثانية إبتدائي",
    "الثالثة إبتدائي",
    "الرابعة إبتدائي",
    "الخامسة إبتدائي"
  ],
  'المتوسط': [
    "الأولى متوسط",
    "الثانية متوسط",
    "الثالثة متوسط",
    "الرابعة متوسط"
  ],
  'الثانوي': ["الأولى ثانوي", "الثانية ثانوي", "الثالثة ثانوي"],
  'الجامعي': [
    "الأولى جامعي",
    "الثانية جامعي",
    "الثالثة جامعي",
    "الرابعة جامعي",
    "الخامسة جامعي",
  ],
};

// Function to get the abbreviated form of a year
String getAbbreviation(String fullYear) {
  if (fullYear.contains("إبتدائي")) {
    return fullYear.replaceAllMapped(RegExp(r"(\d+) إبتدائي"), (match) => "${match.group(1)} إبتدائي");
  } else if (fullYear.contains("متوسط")) {
    return fullYear.replaceAllMapped(RegExp(r"(\d+) متوسط"), (match) => "${match.group(1)} متوسط");
  } else if (fullYear.contains("ثانوي")) {
    return fullYear.replaceAllMapped(RegExp(r"(\d+) ثانوي"), (match) => "${match.group(1)} ثانوي");
  } else if (fullYear.contains("جامعي")) {
    return fullYear.replaceAllMapped(RegExp(r"(\d+) جامعي"), (match) => "${match.group(1)} جامعي");
  }
  return fullYear;  // In case no match, return the original string
}
