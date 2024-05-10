{
  description = "Other Internet Sources flake";
  inputs = {
    wemeetSrc = rec {
      name = "wemeet-bin";
      version = "3.19.0.401";
      url = "https://updatecdn.meeting.qq.com/cos/bb4001c715553579a8b3e496233331d4/TencentMeeting_0300000000_${version}_x86_64_default.publish.deb";
      flake = false;
    };
    hmclSrc = rec {
      pname = "hmcl";
      version = "3.5.7";
      url = "https://github.com/huanghongxun/HMCL/releases/download/release-${version}/HMCL-${version}.jar";
    };
  };
  outputs = {hmclSrc
  }@inputs:
  {
    sources = {
      hmcl = hmclSrc;
    };
  };
}
