class Country {
  String name;
  String urlFlag;
  String currency;

  Country(this.name, this.urlFlag, this.currency);

  static num getConversionRate(String fromCurrency, String toCurrency) {
    // Define conversion rates between currencies
    const conversionRates = {
      'USD': {'EUR': 0.85, 'Rp': 15500, 'JPY': 150, 'CNY': 7.3, 'GBP': 0.75, 'AUD': 1.5, 'CAD': 1.35, 'INR': 83, 'CHF': 0.9, 'KRW': 1330, 'RUB': 95, 'MXN': 18, 'BRL': 5.0, 'ZAR': 19, 'SAR': 3.75, 'TRY': 28},
      'EUR': {'USD': 1.08, 'Rp': 17110, 'JPY': 158, 'CNY': 7.8, 'GBP': 0.88, 'AUD': 1.6, 'CAD': 1.42, 'INR': 88, 'CHF': 0.95, 'KRW': 1400, 'RUB': 103, 'MXN': 19, 'BRL': 5.3, 'ZAR': 20, 'SAR': 4.1, 'TRY': 30},
      'Rp': {'USD': 0.000063, 'EUR': 0.000058, 'JPY': 0.0097, 'CNY': 0.00047, 'GBP': 0.000048, 'AUD': 0.000096, 'CAD': 0.000087, 'INR': 0.0053, 'CHF': 0.000053, 'KRW': 0.086, 'RUB': 0.0061, 'MXN': 0.0012, 'BRL': 0.00032, 'ZAR': 0.0013, 'SAR': 0.00024, 'TRY': 0.0018},
      'JPY': {'USD': 0.0067, 'EUR': 0.0063, 'Rp': 103, 'CNY': 0.048, 'GBP': 0.0056, 'AUD': 0.0096, 'CAD': 0.0090, 'INR': 0.56, 'CHF': 0.006, 'KRW': 9.0, 'RUB': 0.64, 'MXN': 0.12, 'BRL': 0.033, 'ZAR': 0.13, 'SAR': 0.025, 'TRY': 0.19},
      'CNY': {'USD': 0.14, 'EUR': 0.13, 'Rp': 2180, 'JPY': 20.9, 'GBP': 0.11, 'AUD': 0.21, 'CAD': 0.18, 'INR': 11.4, 'CHF': 0.13, 'KRW': 185, 'RUB': 13, 'MXN': 2.6, 'BRL': 0.68, 'ZAR': 2.6, 'SAR': 0.53, 'TRY': 3.6},
      'GBP': {'USD': 1.33, 'EUR': 1.14, 'Rp': 20850, 'JPY': 178, 'CNY': 9.2, 'AUD': 1.9, 'CAD': 1.8, 'INR': 100, 'CHF': 1.15, 'KRW': 1580, 'RUB': 120, 'MXN': 24, 'BRL': 6.1, 'ZAR': 24, 'SAR': 5.0, 'TRY': 36},
      'AUD': {'USD': 0.67, 'EUR': 0.62, 'Rp': 10600, 'JPY': 96, 'CNY': 4.8, 'GBP': 0.53, 'CAD': 0.91, 'INR': 53, 'CHF': 0.6, 'KRW': 880, 'RUB': 66, 'MXN': 13, 'BRL': 3.5, 'ZAR': 13, 'SAR': 2.5, 'TRY': 18},
      'CAD': {'USD': 0.74, 'EUR': 0.7, 'Rp': 11760, 'JPY': 105, 'CNY': 5.4, 'GBP': 0.57, 'AUD': 1.1, 'INR': 61, 'CHF': 0.66, 'KRW': 960, 'RUB': 72, 'MXN': 14, 'BRL': 3.7, 'ZAR': 15, 'SAR': 2.8, 'TRY': 20},
      'INR': {'USD': 0.012, 'EUR': 0.011, 'Rp': 146, 'JPY': 1.8, 'CNY': 0.087, 'GBP': 0.01, 'AUD': 0.019, 'CAD': 0.016, 'CHF': 0.011, 'KRW': 15.6, 'RUB': 1.18, 'MXN': 0.23, 'BRL': 0.06, 'ZAR': 0.23, 'SAR': 0.046, 'TRY': 0.35},
      'CHF': {'USD': 1.1, 'EUR': 1.05, 'Rp': 17600, 'JPY': 165, 'CNY': 7.6, 'GBP': 0.87, 'AUD': 1.65, 'CAD': 1.5, 'INR': 91, 'KRW': 1430, 'RUB': 105, 'MXN': 20, 'BRL': 5.4, 'ZAR': 21, 'SAR': 4.2, 'TRY': 31},
      'KRW': {'USD': 0.00075, 'EUR': 0.00071, 'Rp': 13, 'JPY': 0.11, 'CNY': 0.0054, 'GBP': 0.00063, 'AUD': 0.0011, 'CAD': 0.001, 'INR': 0.064, 'CHF': 0.0007, 'RUB': 0.073, 'MXN': 0.014, 'BRL': 0.0038, 'ZAR': 0.015, 'SAR': 0.0028, 'TRY': 0.021},
      'RUB': {'USD': 0.010, 'EUR': 0.0097, 'Rp': 160, 'JPY': 1.56, 'CNY': 0.077, 'GBP': 0.0083, 'AUD': 0.015, 'CAD': 0.014, 'INR': 0.85, 'CHF': 0.0095, 'KRW': 13.7, 'MXN': 0.18, 'BRL': 0.048, 'ZAR': 0.19, 'SAR': 0.050, 'TRY': 0.35},
      'MXN': {'USD': 0.055, 'EUR': 0.053, 'Rp': 867, 'JPY': 9.1, 'CNY': 0.39, 'GBP': 0.042, 'AUD': 0.077, 'CAD': 0.072, 'INR': 4.6, 'CHF': 0.049, 'KRW': 70.2, 'RUB': 5.6, 'BRL': 0.26, 'ZAR': 1.1, 'SAR': 0.20, 'TRY': 1.4},
      'BRL': {'USD': 0.20, 'EUR': 0.19, 'Rp': 3300, 'JPY': 34, 'CNY': 1.5, 'GBP': 0.17, 'AUD': 0.30, 'CAD': 0.28, 'INR': 17, 'CHF': 0.19, 'KRW': 280, 'RUB': 20, 'MXN': 3.9, 'ZAR': 4.2, 'SAR': 0.74, 'TRY': 5.3},
      'ZAR': {'USD': 0.053, 'EUR': 0.051, 'Rp': 830, 'JPY': 8.7, 'CNY': 0.38, 'GBP': 0.042, 'AUD': 0.077, 'CAD': 0.072, 'INR': 4.3, 'CHF': 0.049, 'KRW': 68, 'RUB': 5.2, 'MXN': 0.93, 'BRL': 0.24, 'SAR': 0.14, 'TRY': 1.2},
      'SAR': {'USD': 0.27, 'EUR': 0.26, 'Rp': 4150, 'JPY': 43.5, 'CNY': 1.9, 'GBP': 0.22, 'AUD': 0.41, 'CAD': 0.38, 'INR': 23, 'CHF': 0.27, 'KRW': 405, 'RUB': 30, 'MXN': 5.2, 'BRL': 1.4, 'ZAR': 7.1, 'TRY': 7.5},
      'TRY': {'USD': 0.036, 'EUR': 0.034, 'Rp': 560, 'JPY': 5.8, 'CNY': 0.25, 'GBP': 0.028, 'AUD': 0.05, 'CAD': 0.048, 'INR': 2.7, 'CHF': 0.032, 'KRW': 47, 'RUB': 3.4, 'MXN': 0.64, 'BRL': 0.19, 'ZAR': 0.83, 'SAR': 0.13}
    };

    if (fromCurrency == toCurrency) return 1.0;
    return conversionRates[fromCurrency]?[toCurrency] ?? 1.0;
  }
}

final List<Country> datas = [
  Country(
    'Indonesia',
    'https://i.pinimg.com/564x/f6/1f/b2/f61fb28c446c032e27ffe2899a3f2699.jpg',
    'Rp',
  ),
  Country(
    'USA',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f5/Flag_of_the_United_States_%281912-1959%29.svg/2560px-Flag_of_the_United_States_%281912-1959%29.svg.png',
    'USD',
  ),
  Country(
    'EU',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/Flag_of_Europe.svg/1200px-Flag_of_Europe.svg.png',
    'EUR',
  ),
  Country(
    'Japan',
    'https://upload.wikimedia.org/wikipedia/en/thumb/9/9e/Flag_of_Japan.svg/1200px-Flag_of_Japan.svg.png',
    'JPY',
  ),
  Country(
    'China',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_the_People%27s_Republic_of_China.svg/800px-Flag_of_the_People%27s_Republic_of_China.svg.png',
    'CNY',
  ),
  Country(
    'UK',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Flag_of_the_United_Kingdom_%281-2%29.svg/1200px-Flag_of_the_United_Kingdom_%281-2%29.svg.png',
    'GBP',
  ),
  Country(
    'Australia',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Flag_of_Australia.svg/1200px-Flag_of_Australia.svg.png',
    'AUD',
  ),
  Country(
    'Canada',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Flag_of_Canada_%28Pantone%29.svg/1200px-Flag_of_Canada_%28Pantone%29.svg.png',
    'CAD',
  ),
  Country(
    'India',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Flag_of_India.svg/2560px-Flag_of_India.svg.png',
    'INR',
  ),
  Country(
    'Switzerland',
    'https://content.app-sources.com/s/39330979433008693/uploads/store/Switzerland-flag-1-5957046.jpg',
    'CHF',
  ),
  Country(
    'South Korea',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Flag_of_South_Korea.svg/255px-Flag_of_South_Korea.svg.png',
    'KRW',
  ),
  Country(
    'Russia',
    'https://upload.wikimedia.org/wikipedia/en/thumb/f/f3/Flag_of_Russia.svg/1200px-Flag_of_Russia.svg.png',
    'RUB',
  ),
  Country(
    'Mexico',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Flag_of_Mexico.svg/800px-Flag_of_Mexico.svg.png',
    'MXN',
  ),
  Country(
    'Brazil',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnsNg2daE_d_2-AWS91dL7d4ObUWOvZmxggg&s',
    'BRL',
  ),
  Country(
    'South Africa',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Flag_of_South_Africa.svg/1200px-Flag_of_South_Africa.svg.png',
    'ZAR',
  ),
  Country(
    'Saudi Arabia',
    'https://cdn02.plentymarkets.com/k8j71m70f8ri/item/images/1004/full/Produktbilder-Saudi-Arabien-01.jpeg',
    'SAR',
  ),
  Country(
    'Turkey',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-vbZ2M0K-mS3lL_EXtixHy8vIqzCjiqdkzg&s',
    'TRY',
  ),
];

