function fish_prompt
  # Cache exit status
  set --global last_status $status

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set --query __fish_prompt_remote
    set --global __fish_prompt_remote ''
    if set --query SSH_CONNECTION
      set --global __fish_prompt_remote 📡
    end
  end
  if not set --query __fish_prompt_char
    switch (id -u)
      case 0
        set --global __fish_prompt_char '#'
      case '*'
        set --global __fish_prompt_char '>'
    end
  end

  function _exit_indicator
    if test $last_status -ne 0
      echo (set_color red)'('$last_status')'(set_color normal)
    else
      echo ''
    end
  end

  function get_arrow_color
    if test $last_status -ne 0
      echo 'red'
    else
      echo 'green'
    end
  end

  # Setup colors
  set --local normal (set_color normal)
  set --local red (set_color red)
  set --local cyan (set_color cyan)
  set --local green (set_color green)
  set --local white (set_color white)
  set --local gray (set_color normal)
  set --local brwhite (set_color --bold white)
  set --local arrow_color (set_color (get_arrow_color))

  set prompt_char_color (set_color --bold cyan)

  function venv_status
    if set --query VIRTUAL_ENV
      echo -n ' 🐍 '
    end
  end

  # Configure __fish_git_prompt
  set --global __fish_git_prompt_showdirtystate true
  set --global __fish_git_prompt_showuntrackedfiles true
  set --global __fish_git_prompt_color green
  set --global __fish_git_prompt_color_flags red
  set --global ___fish_git_prompt_char_dirtystate '⚡'
  set --global ___fish_git_prompt_char_untrackedfiles '+'
  set --local exit_indicator (_exit_indicator)

  # Line 1
  echo -n $arrow_color'┌'🌟 $cyan$USER$normal ❄️ $__fish_prompt_remote $normal(prompt_pwd)$normal
  __fish_git_prompt
  __fish_svn_prompt
  venv_status
  echo -n ❄️
  echo

  # Line 2
  echo -n $arrow_color'└'$exit_indicator$prompt_char_color 🎁' '🎄$__fish_prompt_char $normal
end
