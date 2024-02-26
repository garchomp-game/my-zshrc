if [ ! -d "$HOME/.oh-my-zsh" ]; then
  # KEEP_ZSHRC 環境変数を設定して Oh My Zsh インストールスクリプトを実行
  KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  exit
fi

# ここに zinit のインストールやその他の後続処理を記述する
# 例: zinit のインストール処理（省略）
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
  command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
    print -P "%F{33} %F{34}Installation successful.%f%b" || \
    print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Oh My Zsh のプラグイン
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::docker
# OMZL Shorthand Syntax
zi snippet OMZL::clipboard.zsh
zi snippet OMZL::termsupport.zsh
# 外部プラグイン
zinit light zsh-users/zsh-syntax-highlighting
zinit light unixorn/fzf-zsh-plugin
zinit load zdharma/history-search-multi-word
# Plugin history-search-multi-word loaded with investigating.
zinit load zdharma-continuum/history-search-multi-word

# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

# httpstat プラグインの設定
zinit ice as"program" cp"httpstat.sh -> httpstat" pick"httpstat"
zinit light b4b4r07/httpstat

# その他の設定をここに追加
source $ZSH/oh-my-zsh.sh
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.cargo/bin
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
neofetch

