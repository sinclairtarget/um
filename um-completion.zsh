#compdef _um um

_um() {
    local state line
    typeset -A opt_args
 
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

    local -a pages=(${(f)"$(ls "${pages_directory}/${topic}" | \
        sed 's/\.[^\.]*$//')"})

    # First argument to the script is a subcommand the second is always
    # another argument
    _arguments \
        '1: :->subcommand' \
        '2: :->argument'
 
    # Complete differently depending on whether we are at position 1 or 2
    case $state in
    subcommand)
        local -a subcommands
        subcommands=(
            'config:Display configuration environment' \
            'edit:Create or edit the given page under the current topic' \
            'help:Display a help message, or the help message for a sub-command' \
            'list:List the available pages for the current topic' \
            'read:Read the given page under the current topic' \
            'rm:Remove the given page' \
            'topic:Get or set the current topic' \
            'topics:List all topics'
        )
        # Complete all subcommands (only the long versions)
        _describe 'Subcommands' subcommands
        # Additionally complete all pages, e.g. 'um grep'
        compadd $pages
    ;;
    argument)
        # Now we are at position 2 and need to complete differently
        # depending on the chosen subcommand
        case $line[1] in
        rm|edit|read|r|e)
            compadd $pages
        ;;
        topic|t)
            local -a topics=(${(f)"$(ls "${pages_directory}")"})
            compadd $topics
        ;;
        help|h)
            compadd config edit help list read rm topic topics
        ;;
        esac
    ;;
    esac
}
# vim: expandtab sw=4 ts=4:
