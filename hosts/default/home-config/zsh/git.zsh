alias unadd='git reset HEAD'
alias ac='git add . && git commit -am'
alias lg='!git config -l | grep alias | cut -c 7-'
alias l=log --pretty-format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short
alias b="git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"
#alias clean-merged='git branch --merged | grep -v \"\\*\" | xargs -n 1 git branch -d'
alias clean-merged='git branch --merged | grep -v "\\*" | xargs -n 1 git branch -d'
alias rao='git remote add origin'
alias fu='git fetch && git fetch upstream'
alias fa='git fetch --all'
alias fairy-pick='git fetch && git cherry-pick'

# The rest of my fun git aliases
alias gp='git pull --prune'
alias glog="git log --graph --abbrev-commit --date-order --format=format:'%Cblue%h%Creset%C(bold red)%d%Creset %s <%an> %Cgreen(%ar)%Creset' --all"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'

# Remove `+` and `-` from start of diff lines; just rely upon color.
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'

alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gcb='git copy-branch-name'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gac='git add -A && git commit -m'
