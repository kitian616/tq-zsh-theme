# => tq-zsh-theme

tq is a theme for ["Oh My Zsh!"](https://github.com/robbyrussell/oh-my-zsh).

## Feature

- Username
- Hostname
- Current directory
- Current git branch
- Git repo status:
  - `?` — untracked changes;
  - `+` — uncommitted changes in the index;
  - `!` — unstaged changes;
  - `»` — renamed files;
  - `✘` — deleted files;
  - `$` — stashed changes;
  - `=` — unmerged changes;
  - `⇡` — ahead of remote branch;
  - `⇣` — behind of remote branch;
  - `⇕` — diverged chages.
- Time stamp
- Exit code
- Tips:
  - `🍚` — time to lunch;
  - `🌙` — late at night.

## ScreenShot

![Screenshot](https://github.com/kitian616/tq-zsh-theme/blob/master/Screenshot.png?raw=true)

## How to install

### Install Powerline Fonts

You can see the installation guide [here](https://github.com/powerline/fonts).

### Install for oh-my-zsh

To install this theme for use in `oh-my-zsh`, clone this repository into your oh-my-zsh `custom/themes` directory.

`$ git clone https://github.com/kitian616/tq-zsh-theme.git ~/.oh-my-zsh/custom/themes/tq`

You then need to select this theme in your `~/.zshrc`:

`ZSH_THEME="tq/tq"`

### Install for Zplug

To install this theme for use in [Zplug](https://github.com/zplug/zplug), just add this in your `~/.zshrc`:

`zplug "kitian616/tq-zsh-theme", as:theme`

Note that you should define any customizations at the top of your .zshrc in your `~/.zshrc`.