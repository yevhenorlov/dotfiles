# list files, include hidden but ignore .git folders
export FZF_DEFAULT_COMMAND='rg --files -g '!.git/' --hidden'
