tap "homebrew/bundle"
tap "homebrew/core"
tap "homebrew/services"
tap "instrumenta/instrumenta"

brew "asdf"
brew "bash"
brew "coreutils"
brew "direnv"
brew "docker-completion"
brew "docker-compose-completion"
brew "fish"
brew "gcc"
brew "gh"
brew "git"
brew "git-flow-avh"
brew "git-lfs"
brew "gnupg"
brew "htop"
brew "kubernetes-cli"
brew "kubectx"
brew "openssh"
brew "pinentry-mac"
brew "testdisk"
brew "testssl"
brew "tree"
brew "util-linux"
brew "watch"
brew "watchman"
brew "wget"
brew "whalebrew"
brew "instrumenta/instrumenta/kubeval"

if OS.mac?
    tap "homebrew/cask"
    tap "homebrew/cask-drivers"

    brew "mas"

    cask "alacritty"
    cask "cloudflare-warp"
    cask "dbeaver-community"
    cask "docker"
    cask "git-credential-manager-core"
    cask "github"
    cask "google-earth-pro"
    cask "gpg-suite"
    cask "keybase"
    cask "logos"
    cask "raindropio"
    cask "signal"
    cask "vagrant"
    cask "vagrant-manager"
    cask "virtualbox"
    cask "virtualbox-extension-pack"
    cask "visual-studio-code"
    cask "yubico-yubikey-manager"

    if false  # TODO: Check if user is signed into Mac App Store
        ## To get a list of installed mas apps:
        ### $ mas list | sort -k2 --ignore-case
        mas "1Password 7", id: 1333542190
        mas "Boop", id: 1518425043
        mas "Desktop Verse", id: 572304633
        mas "Grammarly for Safari", id: 1462114288
        mas "Kindle", id: 405399194
        mas "Magnet", id: 441258766
        mas "Microsoft Excel", id: 462058435
        mas "Microsoft Word", id: 462054704
        mas "NewsGuard", id: 1438657064
        mas "OneDrive", id: 823766827
        mas "Parcel", id: 639968404
        mas "Raindrop.io for Safari", id: 957810159
        mas "Rakuten Cash Back", id: 1451893560
        mas "Termius", id: 1176074088
    end
end
