class TwitterInfo {
  int id;
  String idStr;
  String name;
  String screenName;
  String location;
  String description;
  Null url;
  bool protected;
  int followersCount;
  int friendsCount;
  int listedCount;
  String createdAt;
  int favouritesCount;
  Null utcOffset;
  Null timeZone;
  bool geoEnabled;
  bool verified;
  int statusesCount;
  Null lang;
  Status status;
  bool contributorsEnabled;
  bool isTranslator;
  bool isTranslationEnabled;
  String profileBackgroundColor;
  Null profileBackgroundImageUrl;
  Null profileBackgroundImageUrlHttps;
  bool profileBackgroundTile;
  String profileImageUrl;
  String profileImageUrlHttps;
  String profileBannerUrl;
  String profileLinkColor;
  String profileSidebarBorderColor;
  String profileSidebarFillColor;
  String profileTextColor;
  bool profileUseBackgroundImage;
  bool hasExtendedProfile;
  bool defaultProfile;
  bool defaultProfileImage;
  bool following;
  bool followRequestSent;
  bool notifications;
  String translatorType;
  bool suspended;
  bool needsPhoneVerification;

  TwitterInfo(
      {this.id,
      this.idStr,
      this.name,
      this.screenName,
      this.location,
      this.description,
      this.url,
      this.protected,
      this.followersCount,
      this.friendsCount,
      this.listedCount,
      this.createdAt,
      this.favouritesCount,
      this.utcOffset,
      this.timeZone,
      this.geoEnabled,
      this.verified,
      this.statusesCount,
      this.lang,
      this.status,
      this.contributorsEnabled,
      this.isTranslator,
      this.isTranslationEnabled,
      this.profileBackgroundColor,
      this.profileBackgroundImageUrl,
      this.profileBackgroundImageUrlHttps,
      this.profileBackgroundTile,
      this.profileImageUrl,
      this.profileImageUrlHttps,
      this.profileBannerUrl,
      this.profileLinkColor,
      this.profileSidebarBorderColor,
      this.profileSidebarFillColor,
      this.profileTextColor,
      this.profileUseBackgroundImage,
      this.hasExtendedProfile,
      this.defaultProfile,
      this.defaultProfileImage,
      this.following,
      this.followRequestSent,
      this.notifications,
      this.translatorType,
      this.suspended,
      this.needsPhoneVerification});

  TwitterInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idStr = json['id_str'];
    name = json['name'];
    screenName = json['screen_name'];
    location = json['location'];
    description = json['description'];
    url = json['url'];

    protected = json['protected'];
    followersCount = json['followers_count'];
    friendsCount = json['friends_count'];
    listedCount = json['listed_count'];
    createdAt = json['created_at'];
    favouritesCount = json['favourites_count'];
    utcOffset = json['utc_offset'];
    timeZone = json['time_zone'];
    geoEnabled = json['geo_enabled'];
    verified = json['verified'];
    statusesCount = json['statuses_count'];
    lang = json['lang'];
    status = json['status'] != null ? new Status.fromJson(json['status']) : null;
    contributorsEnabled = json['contributors_enabled'];
    isTranslator = json['is_translator'];
    isTranslationEnabled = json['is_translation_enabled'];
    profileBackgroundColor = json['profile_background_color'];
    profileBackgroundImageUrl = json['profile_background_image_url'];
    profileBackgroundImageUrlHttps = json['profile_background_image_url_https'];
    profileBackgroundTile = json['profile_background_tile'];
    profileImageUrl = json['profile_image_url'];
    profileImageUrlHttps = json['profile_image_url_https'];
    profileBannerUrl = json['profile_banner_url'];
    profileLinkColor = json['profile_link_color'];
    profileSidebarBorderColor = json['profile_sidebar_border_color'];
    profileSidebarFillColor = json['profile_sidebar_fill_color'];
    profileTextColor = json['profile_text_color'];
    profileUseBackgroundImage = json['profile_use_background_image'];
    hasExtendedProfile = json['has_extended_profile'];
    defaultProfile = json['default_profile'];
    defaultProfileImage = json['default_profile_image'];
    following = json['following'];
    followRequestSent = json['follow_request_sent'];
    notifications = json['notifications'];
    translatorType = json['translator_type'];
    suspended = json['suspended'];
    needsPhoneVerification = json['needs_phone_verification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_str'] = this.idStr;
    data['name'] = this.name;
    data['screen_name'] = this.screenName;
    data['location'] = this.location;
    data['description'] = this.description;
    data['url'] = this.url;

    data['protected'] = this.protected;
    data['followers_count'] = this.followersCount;
    data['friends_count'] = this.friendsCount;
    data['listed_count'] = this.listedCount;
    data['created_at'] = this.createdAt;
    data['favourites_count'] = this.favouritesCount;
    data['utc_offset'] = this.utcOffset;
    data['time_zone'] = this.timeZone;
    data['geo_enabled'] = this.geoEnabled;
    data['verified'] = this.verified;
    data['statuses_count'] = this.statusesCount;
    data['lang'] = this.lang;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['contributors_enabled'] = this.contributorsEnabled;
    data['is_translator'] = this.isTranslator;
    data['is_translation_enabled'] = this.isTranslationEnabled;
    data['profile_background_color'] = this.profileBackgroundColor;
    data['profile_background_image_url'] = this.profileBackgroundImageUrl;
    data['profile_background_image_url_https'] = this.profileBackgroundImageUrlHttps;
    data['profile_background_tile'] = this.profileBackgroundTile;
    data['profile_image_url'] = this.profileImageUrl;
    data['profile_image_url_https'] = this.profileImageUrlHttps;
    data['profile_banner_url'] = this.profileBannerUrl;
    data['profile_link_color'] = this.profileLinkColor;
    data['profile_sidebar_border_color'] = this.profileSidebarBorderColor;
    data['profile_sidebar_fill_color'] = this.profileSidebarFillColor;
    data['profile_text_color'] = this.profileTextColor;
    data['profile_use_background_image'] = this.profileUseBackgroundImage;
    data['has_extended_profile'] = this.hasExtendedProfile;
    data['default_profile'] = this.defaultProfile;
    data['default_profile_image'] = this.defaultProfileImage;
    data['following'] = this.following;
    data['follow_request_sent'] = this.followRequestSent;
    data['notifications'] = this.notifications;
    data['translator_type'] = this.translatorType;
    data['suspended'] = this.suspended;
    data['needs_phone_verification'] = this.needsPhoneVerification;
    return data;
  }
}

class Status {
  String createdAt;
  int id;
  String idStr;
  String text;
  bool truncated;
  String source;
  int inReplyToStatusId;
  String inReplyToStatusIdStr;
  int inReplyToUserId;
  String inReplyToUserIdStr;
  String inReplyToScreenName;
  Null geo;
  Null coordinates;
  Null place;
  Null contributors;
  bool isQuoteStatus;
  int retweetCount;
  int favoriteCount;
  bool favorited;
  bool retweeted;
  String lang;

  Status(
      {this.createdAt,
      this.id,
      this.idStr,
      this.text,
      this.truncated,
      this.source,
      this.inReplyToStatusId,
      this.inReplyToStatusIdStr,
      this.inReplyToUserId,
      this.inReplyToUserIdStr,
      this.inReplyToScreenName,
      this.geo,
      this.coordinates,
      this.place,
      this.contributors,
      this.isQuoteStatus,
      this.retweetCount,
      this.favoriteCount,
      this.favorited,
      this.retweeted,
      this.lang});

  Status.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    idStr = json['id_str'];
    text = json['text'];
    truncated = json['truncated'];

    source = json['source'];
    inReplyToStatusId = json['in_reply_to_status_id'];
    inReplyToStatusIdStr = json['in_reply_to_status_id_str'];
    inReplyToUserId = json['in_reply_to_user_id'];
    inReplyToUserIdStr = json['in_reply_to_user_id_str'];
    inReplyToScreenName = json['in_reply_to_screen_name'];
    geo = json['geo'];
    coordinates = json['coordinates'];
    place = json['place'];
    contributors = json['contributors'];
    isQuoteStatus = json['is_quote_status'];
    retweetCount = json['retweet_count'];
    favoriteCount = json['favorite_count'];
    favorited = json['favorited'];
    retweeted = json['retweeted'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['id_str'] = this.idStr;
    data['text'] = this.text;
    data['truncated'] = this.truncated;

    data['source'] = this.source;
    data['in_reply_to_status_id'] = this.inReplyToStatusId;
    data['in_reply_to_status_id_str'] = this.inReplyToStatusIdStr;
    data['in_reply_to_user_id'] = this.inReplyToUserId;
    data['in_reply_to_user_id_str'] = this.inReplyToUserIdStr;
    data['in_reply_to_screen_name'] = this.inReplyToScreenName;
    data['geo'] = this.geo;
    data['coordinates'] = this.coordinates;
    data['place'] = this.place;
    data['contributors'] = this.contributors;
    data['is_quote_status'] = this.isQuoteStatus;
    data['retweet_count'] = this.retweetCount;
    data['favorite_count'] = this.favoriteCount;
    data['favorited'] = this.favorited;
    data['retweeted'] = this.retweeted;
    data['lang'] = this.lang;
    return data;
  }
}

class UserMentions {
  String screenName;
  String name;
  int id;
  String idStr;
  List<int> indices;

  UserMentions({this.screenName, this.name, this.id, this.idStr, this.indices});

  UserMentions.fromJson(Map<String, dynamic> json) {
    screenName = json['screen_name'];
    name = json['name'];
    id = json['id'];
    idStr = json['id_str'];
    indices = json['indices'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['screen_name'] = this.screenName;
    data['name'] = this.name;
    data['id'] = this.id;
    data['id_str'] = this.idStr;
    data['indices'] = this.indices;
    return data;
  }
}
