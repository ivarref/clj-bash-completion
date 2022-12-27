

_clj_complete () {
  if [[ "$2" == "-T" ]]; then
    COMPREPLY=($(compgen -W "$(clj-alils.clj)"))
  elif [[ "$2" == "-X" ]]; then
    COMPREPLY=($(compgen -W "$(clj-alils.clj)"))
  elif [[ "$2" == "" ]] && [[ "$3" == "-T" ]]; then
    COMPREPLY=($(compgen -W "$(clj-alils.clj)"))
  elif [[ "$2" == "" ]] && [[ "$3" == "-X" ]]; then
    COMPREPLY=($(compgen -W "$(clj-alils.clj)"))
  elif [[ "$3" == ":" ]]; then
    COMPREPLY=($(compgen -W "$(clj-alils.clj)" -- ${COMP_WORDS[COMP_CWORD]}))
  elif [[ "$2" =~ ^-T.+ ]]; then
    COMPREPLY=($(compgen -W "$(clj-alils.clj | sed -e 's/^/-T/g')" -- ${COMP_WORDS[COMP_CWORD]}))
  elif [[ "$2" =~ ^-X.+ ]]; then
    COMPREPLY=($(compgen -W "$(clj-alils.clj | sed -e 's/^/-X/g')" -- ${COMP_WORDS[COMP_CWORD]}))
  else
    COMPREPLY=($(compgen -o default $2))
  fi
}

complete -o filenames -F _clj_complete clojure
complete -o filenames -F _clj_complete clj
