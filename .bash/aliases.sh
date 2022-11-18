# verbose file operations
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# common moving aliases
alias cd.='cd ..'
alias cd..='cd ../..'
alias cd...='cd ../../..'

# replace cat with bat
if [ -x "$(command -v bat)" ]; then
    alias cat='bat -pp' 
fi

# kubectl aliases
if [ -x "$(command -v kubectl)" ]; then
    alias kc='kubectl'
    alias kclsp='kubectl get pods -A -o wide'
    alias kclsn='kubectl get nodes -o wide'
    alias kclss='kubectl get services -A'
fi

# show the aliases
alias aliases='bat -pp /root/doc/ALIASES.md'

# pg_dump aliases
alias pg_dump10='/usr/lib/postgresql/10/bin/pg_dump'
alias pg_dump11='/usr/lib/postgresql/11/bin/pg_dump'
alias pg_dump12='/usr/lib/postgresql/12/bin/pg_dump'
alias pg_dump13='/usr/lib/postgresql/13/bin/pg_dump'
alias pg_dump14='/usr/lib/postgresql/14/bin/pg_dump'
alias pg_dump15='/usr/lib/postgresql/15/bin/pg_dump'

# pg_dump_all aliases
alias pg_dumpall10='/usr/lib/postgresql/10/bin/pg_dumpall'
alias pg_dumpall11='/usr/lib/postgresql/11/bin/pg_dumpall'
alias pg_dumpall12='/usr/lib/postgresql/12/bin/pg_dumpall'
alias pg_dumpall13='/usr/lib/postgresql/13/bin/pg_dumpall'
alias pg_dumpall14='/usr/lib/postgresql/14/bin/pg_dumpall'
alias pg_dumpall15='/usr/lib/postgresql/15/bin/pg_dumpall'

# pg_restore aliases
alias pg_restore10='/usr/lib/postgresql/10/bin/pg_restore'
alias pg_restore11='/usr/lib/postgresql/11/bin/pg_restore'
alias pg_restore12='/usr/lib/postgresql/12/bin/pg_restore'
alias pg_restore13='/usr/lib/postgresql/13/bin/pg_restore'
alias pg_restore14='/usr/lib/postgresql/14/bin/pg_restore'
alias pg_restore15='/usr/lib/postgresql/15/bin/pg_restore'
