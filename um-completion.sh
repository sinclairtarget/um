# Defines a shell function used to provide tab completion for um
_um()
{
    local current previous subs user topic_path topic pages_directory

    COMPREPLY=()

    current="${COMP_WORDS[COMP_CWORD]}"
    previous="${COMP_WORDS[COMP_CWORD-1]}"
    subs="list read edit rm topic topics config help"

    user=$(whoami)

    # retrieve topic from tmp file, or fall back to invoking program
    topic_path="/var/tmp/um/${user}/current.topic"
    if [[ -e $topic_path ]]; then
        topic=$(cat $topic_path)
    else
        topic=$(um topic)
    fi

    # retrieve pages directory from tmp file, or fall back to invoking program
    pagedir_path="/var/tmp/um/${user}/current.pagedir"
    if [[ -e $pagedir_path ]]; then
        pages_directory=$(cat $pagedir_path)
    else
        pages_directory=$(um config pages_directory)
    fi

    case "${previous}" in
        list|topics|config)                # Unsupported / Nonsensical
            return 0
            ;;
        read|edit|rm)
            local pages=$(ls "${pages_directory}/${topic}" | sed 's/\..*$//')
            COMPREPLY=($(compgen -W "${pages}" -- ${current}))
            return 0
            ;;
        topic)
            COMPREPLY=($(cd "${pages_directory}" && compgen -d ${current}))
            return 0
            ;;
        help)
            COMPREPLY=($(compgen -W "${subs}" -- ${current}))
            return 0
            ;;
        *)
            ;;
    esac

    local pages=$(ls "${pages_directory}/${topic}" | sed 's/\..*$//')
    COMPREPLY=($(compgen -W "${subs} ${pages}" -- ${current}))
    return 0
}
    
complete -F _um um
