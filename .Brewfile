tap "homebrew/bundle"
tap "homebrew/core"
tap "homebrew/services"

brew "asdf"
brew "bash"
brew "coreutils"
brew "direnv"
brew "docker-completion"
brew "docker-compose-completion"
brew "fish"
brew "gcc"
brew "git"
brew "git-lfs"
brew "gnupg"
brew "htop"
brew "openssh"
brew "pinentry"
brew "testdisk"
brew "testssl"
brew "tree"
brew "util-linux"
brew "watch"
brew "watchman"
brew "wget"

if OS.mac?
    tap "homebrew/cask"
    tap "homebrew/cask-drivers"

    brew "mas"
    brew "pinentry-mac"
    brew "geckodriver"

    cask "adobe-creative-cloud"
    cask "alacritty"
    cask "authy"
    cask "dbeaver-community"
    cask "disk-drill"
    cask "docker"
    cask "dropbox"
    cask "firefox"
    cask "git-credential-manager-core"
    cask "github"
    cask "google-earth-pro"
    cask "gpg-suite"
    cask "keybase"
    cask "notion"
    cask "raindropio"
    cask "signal"
    cask "visual-studio-code"

    if false  # TODO: Check if user is signed into Mac App Store
        ## To get a list of installed mas apps:
        ### $ mas list | sort -k2 --ignore-case
        mas "1Password 7", id: 1333542190
        mas "Compressor", id: 424390742
        mas "Desktop Verse", id: 572304633
        mas "Final Cut Pro", id: 424389933
        mas "Grammarly for Safari", id: 1462114288
        mas "iMovie", id: 408981434
        mas "Keynote", id: 409183694
        mas "Kindle", id: 405399194
        mas "Magnet", id: 441258766
        mas "Microsoft Excel", id: 462058435
        mas "Microsoft Word", id: 462054704
        mas "Motion", id: 434290957
        mas "NewsGuard", id: 1438657064
        mas "NordVPN IKE", id: 1116599239
        mas "Parcel", id: 639968404
        mas "Raindrop.io for Safari", id: 957810159
        mas "Rakuten Cash Back", id: 1451893560
    end
end
