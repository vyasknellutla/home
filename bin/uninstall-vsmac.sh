#!/bin/sh

# Uninstall Visual Studio for Mac
echo "Uninstalling Visual Studio for Mac..."

sudo rm -rf "/Applications/Visual Studio.app"
rm -rf "${HOME}/Library/Caches/VisualStudio"
rm -rf "${HOME}/Library/Preferences/VisualStudio"
rm -rf "${HOME}/Library/Preferences/Visual Studio"
rm -rf "${HOME}/Library/Logs/VisualStudio"
rm -rf "${HOME}/Library/VisualStudio"
rm -rf "${HOME}/Library/Preferences/Xamarin/"
rm -rf "${HOME}/Library/Application Support/VisualStudio"
rm -rf "${HOME}/Library/Application Support/VisualStudio/7.0/LocalInstall/Addins/"

# Uninstall Xamarin.Android
echo "Uninstalling Xamarin.Android..."

sudo rm -rf "/Developer/MonoDroid"
rm -rf "${HOME}/Library/MonoAndroid"
sudo pkgutil --forget com.xamarin.android.pkg
sudo rm -rf "/Library/Frameworks/Xamarin.Android.framework"

# Uninstall Xamarin.iOS
echo "Uninstalling Xamarin.iOS..."

rm -rf "${HOME}/Library/MonoTouch"
sudo rm -rf "/Library/Frameworks/Xamarin.iOS.framework"
sudo rm -rf "/Developer/MonoTouch"
sudo pkgutil --forget com.xamarin.monotouch.pkg
sudo pkgutil --forget com.xamarin.xamarin-ios-build-host.pkg

# Uninstall Xamarin.Mac
echo "Uninstalling Xamarin.Mac..."

sudo rm -rf "/Library/Frameworks/Xamarin.Mac.framework"
rm -rf "${HOME}/Library/Xamarin.Mac"

# Uninstall Workbooks and Inspector
echo "Uninstalling Workbooks and Inspector..."

sudo "/Library/Frameworks/Xamarin.Interactive.framework/Versions/Current/uninstall"

# Uninstall the Visual Studio for Mac Installer
echo "Uninstalling the Visual Studio for Mac Installer..."

rm -rf "${HOME}/Library/Caches/XamarinInstaller/"
rm -rf "${HOME}/Library/Caches/VisualStudioInstaller/"
rm -rf "${HOME}/Library/Logs/XamarinInstaller/"
rm -rf "${HOME}/Library/Logs/VisualStudioInstaller/"

# Uninstall the Xamarin Profiler
echo "Uninstalling the Xamarin Profiler..."

sudo rm -rf "/Applications/Xamarin Profiler.app"

echo "Finished Uninstallation process."
