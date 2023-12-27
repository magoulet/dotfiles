# Dotfiles Managed with Chezmoi

This repository contains my personal dotfiles, managed using [Chezmoi](https://chezmoi.io/), a robust and user-friendly dotfiles manager. Chezmoi helps you manage your configuration files (dotfiles) across multiple machines, keeping them in sync and allowing you to easily replicate your setup on any new system.

## Prerequisites

This guide assumes you have a basic understanding of dotfiles and shell environments. Before starting, ensure you have the following installed:

- Git
- Chezmoi (you can install it following the [official documentation](https://www.chezmoi.io/install/))

## Setup

To apply the dotfiles to your system, follow these steps:

1. Install Chezmoi on your system if you haven't already:

   ```bash
   sh -c "$(curl -fsLS git.io/chezmoi)"
   ```

2. Clone this repository using Chezmoi:

   ```bash
   chezmoi init https://github.com/magoulet/dotfiles.git
   ```

3. Once cloned, you can apply the configurations to your home directory:

   ```bash
   chezmoi apply
   ```

   Hint: use the `-v` (verbose) and `-n` (dry-run) flags to inspect changes without executing them.

4. For future updates or modifications, you can pull and apply the changes as follows:

   ```bash
   chezmoi update
   ```