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
brew "doctl"
brew "faas-cli"
brew "fish"
brew "gcc"
brew "geckodriver"
brew "gh"
brew "git"
brew "git-flow-avh"
brew "git-lfs"
brew "gnupg"
brew "helm"
brew "helmfile"
brew "htop"
brew "jq"
brew "kubernetes-cli"
brew "kubectx"
brew "nmap"
brew "openapi-generator"
brew "openssh"
brew "pinentry-mac"
brew "shellcheck"
brew "testdisk"
brew "testssl"
brew "tree"
brew "util-linux"
brew "watch"
brew "watchman"
brew "wget"
brew "whalebrew"
brew "ykman"
brew "youtube-dl"
brew "zsh"
brew "instrumenta/instrumenta/kubeval"

if OS.mac?
    tap "homebrew/cask"
    tap "homebrew/cask-drivers"
    tap "homebrew/cask-fonts"
    tap "homebrew/cask-versions"

    brew "mas"

    cask "alacritty"
    cask "cloudflare-warp"
    cask "dbeaver-community"
    cask "docker"
    cask "dropbox"
    cask "font-hack-nerd-font"
    cask "git-credential-manager-core"
    cask "github"
    cask "gpg-suite"
    cask "postman"
    cask "signal"
    cask "virtualbox"
    cask "virtualbox-extension-pack"
    cask "visual-studio-code"
    cask "yubico-yubikey-manager"

    if false  # TODO: Check if user is signed into Mac App Store
        ## To get a list of installed mas apps:
        ### $ mas list | sort -k2 --ignore-case
        mas "1Password 7", id: 1333542190
        mas "Grammarly for Safari", id: 1462114288
        mas "Kindle", id: 405399194
        mas "Magnet", id: 441258766
        mas "Microsoft Excel", id: 462058435
        mas "Microsoft OneNote", id: 784801555
        mas "Microsoft Outlook", id: 985367838
        mas "Microsoft PowerPoint", id: 462062816
        mas "Microsoft To Do", id: 1274495053
        mas "Microsoft Word", id: 462054704
        mas "NewsGuard", id: 1438657064
        mas "OneDrive", id: 823766827
        mas "Parcel", id: 639968404
        mas "Rakuten Cash Back", id: 1451893560
        mas "Termius", id: 1176074088
    end
end
