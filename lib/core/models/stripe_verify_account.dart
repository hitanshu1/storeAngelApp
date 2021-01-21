class StripeVerifyAccount {
  String id;
  String object;
  BusinessProfile businessProfile;
  Capabilities capabilities;
  bool chargesEnabled;
  String country;
  String defaultCurrency;
  bool detailsSubmitted;
  String email;
  bool payoutsEnabled;
  Requirements requirements;
  Settings settings;
  String type;

  StripeVerifyAccount({this.id, this.object, this.businessProfile, this.capabilities, this.chargesEnabled, this.country, this.defaultCurrency, this.detailsSubmitted, this.email, this.payoutsEnabled, this.requirements, this.settings, this.type});

  StripeVerifyAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    businessProfile = json['business_profile'] != null ? new BusinessProfile.fromJson(json['business_profile']) : null;
    capabilities = json['capabilities'] != null ? new Capabilities.fromJson(json['capabilities']) : null;
    chargesEnabled = json['charges_enabled'];
    country = json['country'];
    defaultCurrency = json['default_currency'];
    detailsSubmitted = json['details_submitted'];
    email = json['email'];
    payoutsEnabled = json['payouts_enabled'];
    requirements = json['requirements'] != null ? new Requirements.fromJson(json['requirements']) : null;
    settings = json['settings'] != null ? new Settings.fromJson(json['settings']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    if (this.businessProfile != null) {
      data['business_profile'] = this.businessProfile.toJson();
    }
    if (this.capabilities != null) {
      data['capabilities'] = this.capabilities.toJson();
    }
    data['charges_enabled'] = this.chargesEnabled;
    data['country'] = this.country;
    data['default_currency'] = this.defaultCurrency;
    data['details_submitted'] = this.detailsSubmitted;
    data['email'] = this.email;

    data['payouts_enabled'] = this.payoutsEnabled;
    if (this.requirements != null) {
      data['requirements'] = this.requirements.toJson();
    }
    if (this.settings != null) {
      data['settings'] = this.settings.toJson();
    }
    data['type'] = this.type;
    return data;
  }
}

class BusinessProfile {
  String mcc;
  Null name;
  Null supportAddress;
  Null supportEmail;
  String supportPhone;
  Null supportUrl;
  String url;

  BusinessProfile({this.mcc, this.name, this.supportAddress, this.supportEmail, this.supportPhone, this.supportUrl, this.url});

  BusinessProfile.fromJson(Map<String, dynamic> json) {
    mcc = json['mcc'];
    name = json['name'];
    supportAddress = json['support_address'];
    supportEmail = json['support_email'];
    supportPhone = json['support_phone'];
    supportUrl = json['support_url'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mcc'] = this.mcc;
    data['name'] = this.name;
    data['support_address'] = this.supportAddress;
    data['support_email'] = this.supportEmail;
    data['support_phone'] = this.supportPhone;
    data['support_url'] = this.supportUrl;
    data['url'] = this.url;
    return data;
  }
}

class Capabilities {
  String cardPayments;
  String transfers;

  Capabilities({this.cardPayments, this.transfers});

  Capabilities.fromJson(Map<String, dynamic> json) {
    cardPayments = json['card_payments'];
    transfers = json['transfers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_payments'] = this.cardPayments;
    data['transfers'] = this.transfers;
    return data;
  }
}



class Requirements {
  Null currentDeadline;
  List<String> currentlyDue;
  String disabledReason;
  List<Errors> errors;
  List<String> eventuallyDue;
  List<String> pastDue;
  List<Null> pendingVerification;

  Requirements({this.currentDeadline, this.currentlyDue, this.disabledReason, this.errors, this.eventuallyDue, this.pastDue, this.pendingVerification});

  Requirements.fromJson(Map<String, dynamic> json) {
    currentDeadline = json['current_deadline'];
    currentlyDue = json['currently_due'].cast<String>();
    disabledReason = json['disabled_reason'];
    if (json['errors'] != null) {
      errors = new List<Errors>();
      json['errors'].forEach((v) { errors.add(new Errors.fromJson(v)); });
    }
    eventuallyDue = json['eventually_due'].cast<String>();
    pastDue = json['past_due'].cast<String>();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_deadline'] = this.currentDeadline;
    data['currently_due'] = this.currentlyDue;
    data['disabled_reason'] = this.disabledReason;
    if (this.errors != null) {
      data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    data['eventually_due'] = this.eventuallyDue;
    data['past_due'] = this.pastDue;

    return data;
  }
}

class Errors {
  String code;
  String reason;
  String requirement;

  Errors({this.code, this.reason, this.requirement});

  Errors.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    reason = json['reason'];
    requirement = json['requirement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['reason'] = this.reason;
    data['requirement'] = this.requirement;
    return data;
  }
}

class Settings {
  Branding branding;
  CardPayments cardPayments;
  Dashboard dashboard;
  Payments payments;

  Settings({this.branding, this.cardPayments, this.dashboard, this.payments});

  Settings.fromJson(Map<String, dynamic> json) {
    branding = json['branding'] != null ? new Branding.fromJson(json['branding']) : null;
    cardPayments = json['card_payments'] != null ? new CardPayments.fromJson(json['card_payments']) : null;
    dashboard = json['dashboard'] != null ? new Dashboard.fromJson(json['dashboard']) : null;
    payments = json['payments'] != null ? new Payments.fromJson(json['payments']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.branding != null) {
      data['branding'] = this.branding.toJson();
    }
    if (this.cardPayments != null) {
      data['card_payments'] = this.cardPayments.toJson();
    }
    if (this.dashboard != null) {
      data['dashboard'] = this.dashboard.toJson();
    }
    if (this.payments != null) {
      data['payments'] = this.payments.toJson();
    }
    return data;
  }
}

class Branding {
  Null icon;
  Null logo;
  Null primaryColor;
  Null secondaryColor;

  Branding({this.icon, this.logo, this.primaryColor, this.secondaryColor});

  Branding.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    logo = json['logo'];
    primaryColor = json['primary_color'];
    secondaryColor = json['secondary_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['logo'] = this.logo;
    data['primary_color'] = this.primaryColor;
    data['secondary_color'] = this.secondaryColor;
    return data;
  }
}

class CardPayments {
  String statementDescriptorPrefix;

  CardPayments({this.statementDescriptorPrefix});

  CardPayments.fromJson(Map<String, dynamic> json) {
    statementDescriptorPrefix = json['statement_descriptor_prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statement_descriptor_prefix'] = this.statementDescriptorPrefix;
    return data;
  }
}

class Dashboard {
  String displayName;
  String timezone;

  Dashboard({this.displayName, this.timezone});

  Dashboard.fromJson(Map<String, dynamic> json) {
    displayName = json['display_name'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_name'] = this.displayName;
    data['timezone'] = this.timezone;
    return data;
  }
}

class Payments {
  String statementDescriptor;
  Null statementDescriptorKana;
  Null statementDescriptorKanji;

  Payments({this.statementDescriptor, this.statementDescriptorKana, this.statementDescriptorKanji});

  Payments.fromJson(Map<String, dynamic> json) {
    statementDescriptor = json['statement_descriptor'];
    statementDescriptorKana = json['statement_descriptor_kana'];
    statementDescriptorKanji = json['statement_descriptor_kanji'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statement_descriptor'] = this.statementDescriptor;
    data['statement_descriptor_kana'] = this.statementDescriptorKana;
    data['statement_descriptor_kanji'] = this.statementDescriptorKanji;
    return data;
  }
}