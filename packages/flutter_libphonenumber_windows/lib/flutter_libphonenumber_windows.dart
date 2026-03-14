import 'package:dlibphonenumber/dlibphonenumber.dart' as phoneutil;
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber_platform_interface/flutter_libphonenumber_platform_interface.dart';

class FlutterLibphonenumberWindows extends FlutterLibphonenumberPlatform {
  /// Registers this class as the default instance of [FlutterLibphonenumberPlatform].
  static void registerWith() {
    FlutterLibphonenumberPlatform.instance = FlutterLibphonenumberWindows();
  }

  @override
  Future<Map<String, String>> format(
    final String phone,
    final String region,
  ) async {
    try {
      final util = phoneutil.PhoneNumberUtil.instance;
      final formatter = util.getAsYouTypeFormatter(region);
      formatter.clear();
      var formatted = '';
      for (final char in phone.split('')) {
        formatted = formatter.inputDigit(char);
      }
      return {'formatted': formatted};
    } catch (_) {
      throw PlatformException(
        code: 'InvalidNumber',
        message: 'Number $phone is invalid',
      );
    }
  }

  @override
  Future<Map<String, CountryWithPhoneCode>> getAllSupportedRegions() async {
    final util = phoneutil.PhoneNumberUtil.instance;
    final res = <String, CountryWithPhoneCode>{};

    final regions = util.supportedRegions;
    for (final region in regions) {
      final exampleNumberMobile = util.getExampleNumberForType(
            regionCode: region,
            type: phoneutil.PhoneNumberType.mobile,
          ) ??
          phoneutil.PhoneNumber();

      final exampleNumberFixedLine = util.getExampleNumberForType(
            regionCode: region,
            type: phoneutil.PhoneNumberType.fixedLine,
          ) ??
          phoneutil.PhoneNumber();

      final phoneCode = util.getCountryCodeForRegion(region).toString();

      res[region] = CountryWithPhoneCode(
        phoneCode: phoneCode,
        countryCode: region,
        exampleNumberMobileNational: _formatNational(exampleNumberMobile),
        exampleNumberFixedLineNational: _formatNational(exampleNumberFixedLine),
        phoneMaskMobileNational: _maskNumber(
          _formatNational(exampleNumberMobile),
          phoneCode,
        ),
        phoneMaskFixedLineNational: _maskNumber(
          _formatNational(exampleNumberFixedLine),
          phoneCode,
        ),
        exampleNumberMobileInternational: _formatInternational(exampleNumberMobile),
        exampleNumberFixedLineInternational: _formatInternational(exampleNumberFixedLine),
        phoneMaskMobileInternational: _maskNumber(
          _formatInternational(exampleNumberMobile),
          phoneCode,
        ),
        phoneMaskFixedLineInternational: _maskNumber(
          _formatInternational(exampleNumberFixedLine),
          phoneCode,
        ),
        countryName: _getCountryName(region),
      );
    }
    return res;
  }

  @override
  Future<Map<String, dynamic>> parse(
    final String phone, {
    final String? region,
  }) async {
    try {
      final util = phoneutil.PhoneNumberUtil.instance;
      final phoneNumber = util.parse(phone, region);
      
      if (!util.isValidNumber(phoneNumber)) {
        throw Exception('Invalid number');
      }

      return {
        'type': _numberTypeToString(util.getNumberType(phoneNumber)),
        'e164': util.format(phoneNumber, phoneutil.PhoneNumberFormat.e164),
        'international': util.format(phoneNumber, phoneutil.PhoneNumberFormat.international),
        'national': util.format(phoneNumber, phoneutil.PhoneNumberFormat.national),
        'country_code': phoneNumber.countryCode.toString(),
        'region_code': util.getRegionCodeForNumber(phoneNumber) ?? '',
        'national_number': phoneNumber.nationalNumber.toString(),
      };
    } catch (e) {
      throw PlatformException(
        code: 'InvalidNumber',
        message: 'Number $phone is invalid: $e',
      );
    }
  }

  @override
  Future<void> init({
    final Map<String, CountryWithPhoneCode> overrides = const {},
  }) async {
    return CountryManager().loadCountries(
      phoneCodesMap: await getAllSupportedRegions(),
      overrides: overrides,
    );
  }

  static String _maskNumber(final String phoneNumber, final String phoneCode) =>
      phoneNumber.replaceAll(RegExp(r'\d'), '0');

  static String _formatNational(final phoneutil.PhoneNumber phoneNumber) =>
      phoneutil.PhoneNumberUtil.instance.format(
        phoneNumber,
        phoneutil.PhoneNumberFormat.national,
      );

  static String _formatInternational(final phoneutil.PhoneNumber phoneNumber) =>
      phoneutil.PhoneNumberUtil.instance.format(
        phoneNumber,
        phoneutil.PhoneNumberFormat.international,
      );

  static String _numberTypeToString(phoneutil.PhoneNumberType type) {
    switch (type) {
      case phoneutil.PhoneNumberType.fixedLine:
        return 'fixedLine';
      case phoneutil.PhoneNumberType.mobile:
        return 'mobile';
      case phoneutil.PhoneNumberType.fixedLineOrMobile:
        return 'fixedOrMobile';
      case phoneutil.PhoneNumberType.tollFree:
        return 'tollFree';
      case phoneutil.PhoneNumberType.premiumRate:
        return 'premiumRate';
      case phoneutil.PhoneNumberType.sharedCost:
        return 'sharedCost';
      case phoneutil.PhoneNumberType.voip:
        return 'voip';
      case phoneutil.PhoneNumberType.personalNumber:
        return 'personalNumber';
      case phoneutil.PhoneNumberType.pager:
        return 'pager';
      case phoneutil.PhoneNumberType.uan:
        return 'uan';
      case phoneutil.PhoneNumberType.voicemail:
        return 'voicemail';
      case phoneutil.PhoneNumberType.unknown:
        return 'unknown';
      default:
        return 'notParsed';
    }
  }

  static String _getCountryName(String regionCode) {
    // For now returning the region code as the name. 
    // In a real scenario, we might want to use a localization package.
    return regionCode;
  }
}
