# GRUB Reboot Manager

This is a simple Bash script that allows you to easily select and reboot into a specific GRUB menu entry. It's especially useful for multi-boot systems where you frequently switch between operating systems.

The script lists all available GRUB menu entries, prompts you to choose one by number, and then uses `grub-reboot` to set the one-time boot entry. It will then ask for confirmation before rebooting the system.

## Prerequisites

  * **Root Access**: The script must be run with `sudo` or as the root user.
  * **GRUB**: The GRUB bootloader must be installed and configured on your system.
  * **`grub-reboot`**: The `grub-reboot` command, most systems will have this installed alongisde GRUB, but if it's not available, you can install it using your package manager.
    ```bash
      # On Debian/Ubuntu
    sudo apt-get install grub-common

    # On Arch Linux (you should already have this installed alongside GRUB!)
    sudo pacman -S grub

    # On Fedora/CentOS/RHEL
    sudo dnf install grub2-tools-extra
    ```

## Usage

1.  **Save the Script**: Save the script to a file, for example, `grub-reboot-manager.sh`.
2.  **Make it Executable**: Give the script execute permissions:
    ```bash
    chmod +x grub-reboot-manager.sh
    ```
3.  **Run the Script**: Execute the script with `sudo`:
    ```bash
    sudo ./grub-reboot-manager.sh
    ```

The script will display a list of your boot entries, and you can select the one you want to reboot into.

## Creating an Alias

For easier access, you can create a shell alias to run the script from anywhere.

1.  **Move the Script**: Move the script to a directory in your system's `PATH`, for example, `/usr/local/bin`:
    ```bash
    sudo mv grub-reboot-manager.sh /usr/local/bin/
    ```
2.  **Create the Alias**: Add the following line to your shell's configuration file (e.g., `~/.zshrc`, `~/.bashrc`):
    ```bash
    alias grbm='sudo grub-reboot-manager.sh'
    ```
3.  **Reload Your Shell**: Apply the changes by reloading your shell configuration:
    ```bash
    source ~/.zshrc  # or source ~/.bashrc; alternatively just restart your terminal
    ```

Now you can simply type `grbm` in your terminal to run the script.

## Contributing

Whilst it serves my purpose, if you have suggestions for improvements or additional features, feel free to fork the repository and submit a pull request. Contributions are welcome!


## License

This script is released under the MIT License. Feel free to use, modify, and distribute it as you wish.
