import 'package:currency_converter/models/country.dart';
import 'package:flutter/material.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  Country fromCountry = datas[0]; // Starting with USA as the default from country
  Country toCountry = datas[1]; // Starting with EU as the default to country
  double value = 0; // Input value
  double result = 0; // Conversion result
  final TextEditingController _toCountryController = TextEditingController();

  Future<void> _requestConvert() async {
    setState(() {
      final rate = Country.getConversionRate(fromCountry.currency, toCountry.currency);
      result = value * rate;
      _toCountryController.text = result.toStringAsFixed(2);
    });
  }

  void _selectCountry(bool isFromCountry) async {
    final selectedCountry = await showDialog<Country>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Country"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: datas.length,
              itemBuilder: (context, index) {
                final country = datas[index];
                return ListTile(
                  leading: Image.network(country.urlFlag, height: 20, width: 30),
                  title: Text(country.name),
                  onTap: () {
                    Navigator.pop(context, country);
                  },
                );
              },
            ),
          ),
        );
      },
    );

    if (selectedCountry != null) {
      setState(() {
        if (isFromCountry) {
          fromCountry = selectedCountry;
        } else {
          toCountry = selectedCountry;
        }
      });
      _requestConvert(); // Request conversion after selection
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "CURRENCY CONVERTER",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            _buildCurrencyView(fromCountry, true, (newValue) {
              setState(() {
                value = newValue;
              });
            }),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _requestConvert, // Trigger conversion on tap
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.indigo.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "=",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      final temp = fromCountry;
                      fromCountry = toCountry;
                      toCountry = temp;

                      value = double.tryParse(_toCountryController.text) ?? 0;
                      _requestConvert(); // Re-calculate after switching
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.indigo[50],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.indigo),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Image.network(
                            "https://static.thenounproject.com/png/1182124-200.png",
                            height: 30,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Switch Currencies",
                            style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildCurrencyView(toCountry, false, (_) {}),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyView(Country country, bool isFromCountry, ValueChanged<double> onChanged) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    country.urlFlag,
                    height: 30,
                    width: 50,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        country.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        country.currency,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.grey),
                  onPressed: () => _selectCountry(isFromCountry),
                ),
              ],
            ),
            TextFormField(
              controller: isFromCountry ? null : _toCountryController,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              initialValue: isFromCountry ? value.toString() : null,
              decoration: InputDecoration(
                hintText: '0',
                hintStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    country.currency,
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              ),
              keyboardType: TextInputType.number,
              onChanged: (text) {
                if (isFromCountry) {
                  final inputValue = double.tryParse(text) ?? 0;
                  onChanged(inputValue);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _toCountryController.dispose();
    super.dispose();
  }
}
