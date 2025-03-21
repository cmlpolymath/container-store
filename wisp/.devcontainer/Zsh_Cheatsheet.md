# Zsh Power User Guide & Cheatsheet

**Introduction:**

Zsh (Z Shell) is a powerful, extensible shell that enhances your command-line experience. This guide provides a focused overview of essential Zsh commands and features.

**I. Core Commands & Navigation:**

* **`ls [options] [directory]`:**
    * Lists directory contents.
    * `ls -l`: Long format (permissions, size, etc.).
    * `ls -a`: Show hidden files.
    * `ls -h`: Human readable file sizes.
    * `ls -t`: Sort by modification time.
    * Use when you need to view files and directories.
* **`cd [directory]`:**
    * Changes the current working directory.
    * `cd ..`: Move up one level.
    * `cd -`: Switch to the previous directory.
    * `cd ~`: Go to home directory.
    * Use for navigating the file system.
* **`pwd`:**
    * Prints the current working directory.
    * Use when you need to know your current location.
* **`mkdir [directory]`:**
    * Creates a new directory.
    * `mkdir -p [directory/subdirectory]`: Creates parent directories as needed.
    * Use for creating new directories.
* **`rm [options] [file/directory]`:**
    * Removes files or directories.
    * `rm [file]`: remove a file.
    * `rm -r [directory]`: Remove a directory recursively.
    * `rm -rf [directory]`: Force removal (use with caution).
    * Use for deleting files and directories.
* **`cp [source] [destination]`:**
    * Copies files or directories.
    * `cp -r [source_directory] [destination_directory]`: Copy directories recursively.
    * Use for copying files and directories.
* **`mv [source] [destination]`:**
    * Moves or renames files or directories.
    * Use for moving or renaming files and directories.
* **`cat [file]`:**
    * Displays the contents of a file.
    * Use for viewing file contents.
* **`less [file]`:**
    * Displays file contents one page at a time.
    * Use for viewing large files.
* **`grep [options] [pattern] [file]`:**
    * Searches for a pattern in a file.
    * `grep -i`: Case-insensitive search.
    * `grep -r`: Recursive search in directories.
    * Use for searching file contents.
* **`find [directory] [options]`:**
    * Searches for files and directories based on criteria.
    * `find . -name "filename"`: Find by filename.
    * `find . -type f`: Find only files.
    * `find . -type d`: Find only directories.
    * Use for complex file searches.
* **`history`:**
    * Display the command history.
    * `!n` : execute command from history line n.
    * `!!` : execute the previous command.
    * `!string` : execute the most recent command that begins with string.
* **`man [command]`:**
    * Display the manual page for a command.
    * Use to get detailed information about a command.

**II. Zsh Specific Features:**

* **Tab Completion:**
    * Press `Tab` to complete commands, filenames, and options.
    * Zsh's tab completion is highly context-aware.
* **Spelling Correction:**
    * Zsh can automatically correct typos in commands and filenames.
* **Globbing (Filename Expansion):**
    * `*.txt`: Matches all `.txt` files.
    * `**/*.txt`: Matches all `.txt` files in subdirectories recursively.
    * `{file1,file2}.txt`: Matches `file1.txt` and `file2.txt`.
    * `~`: represents the home directory.
* **Command History:**
    * Zsh shares command history across all terminal sessions.
    * `Ctrl + r`: Reverse search command history.
* **Aliases:**
    * `alias ll="ls -l"`: Creates an alias `ll` for `ls -l`.
    * Place aliases in your `.zshrc` file.
* **Functions:**
    * More powerful than aliases, allowing for complex operations.
    * Example: `myfunc() { echo "Hello, $1"; }`.
    * Place functions in your `.zshrc` file.
* **Prompts:**
    * Zsh prompts are highly customizable. Use Oh My Zsh for easy theming.
* **Plugins (Oh My Zsh):**
    * Extend Zsh functionality with plugins for Git, syntax highlighting, and more.
    * Edit your `.zshrc` to enable plugins.
* **Oh My Zsh Themes:**
    * Change the look of your prompt.
    * Change the `ZSH_THEME` variable in your `.zshrc` file.

**III. Commonly Unknown Commands & Techniques:**

* **`setopt` and `unsetopt`:**
    * Modify Zsh options.
    * `setopt nocaseglob`: Makes globbing case-insensitive.
    * `unsetopt nocaseglob`: Reverses the previous command.
* **`watch [command]`:**
    * Repeatedly executes a command and displays the output.
    * `watch ls -l`: Watch for file changes.
* **`zmv [source] [destination]`:**
    * Powerful batch renaming of files.
    * `zmv '(*).txt' '$1.bak'`: Rename all .txt files to .bak.
* **`zle` (Zsh Line Editor):**
    * Customize key bindings and line editing behavior.
    * Advanced users only.
* **`fc` (Fix Command):**
    * Edit and re-execute previous commands.
    * `fc -e vim 5`: Opens command number 5 in vim for editing.
* **`dirs` and `pushd/popd`:**
    * Manage a directory stack.
    * `pushd /path/to/dir`: Adds directory to the stack and changes to it.
    * `popd`: Returns to the previous directory in the stack.
* **`typeset`:**
    * Declares variables and sets attributes.
    * `typeset -i number=10`: declares an integer variable.
* **`autoload`:**
    * Loads a function only when it is used.
    * Used to speed up shell startup.

**IV. Tips & Best Practices:**

* **Use Oh My Zsh:** For easy customization and plugin management.
* **Customize your `.zshrc`:** Add aliases, functions, and custom settings.
* **Learn globbing:** It saves a lot of time.
* **Use tab completion:** It prevents typos and speeds up commands.
* **Explore Zsh options:** Use `setopt` and `unsetopt` to tailor your shell.
* **Practice:** The more you use Zsh, the more comfortable you'll become.

This guide provides a starting point. Explore the Zsh documentation and community resources to further enhance your command-line skills.