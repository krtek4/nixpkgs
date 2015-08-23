{ stdenv, fetchgit, config }:

stdenv.mkDerivation {
  name = "hotplug-monitor";

  src = fetchgit {
    url = "https://krtek@bitbucket.org/krtek/dotfiles.git";
    rev = "18c17f7b6481ffb1f7efa8cf5bd2d6b37ae312ca";
    sha256 = "0l7wkn4wb5kg8lvxk4gc3p46kzfvl6601hinizb5msabvaiyb0xh";
    deepClone = false;
    fetchSubmodules = false;
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp bin/hotplug_monitor.sh $out/bin/hotplug_monitor.sh
  '';

  config.environment.etc."udev/rules.d/10-hotplug-monitor.rules".text = ''
    # reload screen configuration
    ACTION=="change", SUBSYSTEM=="drm", RUN+="/home/krtek/bin/hotplug_monitor.sh"
  '';

  meta = {
    description = "A script to configure monitor upon plug and related udev rules";
    longDescription = "A script to configure monitor upon plug and related udev rules";
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = [ "Gilles Crettenand" ];
    platforms = stdenv.lib.platforms.all;
  };
}
