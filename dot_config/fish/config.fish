tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Sparse --icons='Many icons' --transient=No

status is-login; and begin

    # Login shell initialisation


end

status is-interactive; and begin
    # Aliases
    alias ls 'eza --icons'

    # Interactive shell initialisation
    set fish_greeting # Disable greeting
end
