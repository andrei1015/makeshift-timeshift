# Makeshift-Timeshift

The idea behind Timeshift is pretty simple, but it doesn't seem to be able to run in a terminal-only mode, XServer is a dependency, so I made the same thing, but for terminal-only situations.

## Usage/Examples

#### -c / --create

This parameter is used to create a new snapshot

#### -l / --list

List all currently available local snapshots

#### -D / --clean-all

Delete everything inside the /backups folder, including archives

#### -d / --clean-archives

Delete everything inside the `archives` folder

#### -r / --restore (NOT YET IMPLEMENTED)

Restore the selected backup

## Run

Clone the project

```bash
  git clone https://github.com/andrei1015/makeshift-timeshift
```

Go to the project directory

```bash
  cd makeshift-timeshift
```

(make the file executable)Run the script to create a new snapshot (or whatever)

```bash
  sudo ./snap.sh -c
```

You can also add an alias into your .bashrc file

```bash
alias mkshift='~/makeshift-timeshift/snap.sh'
```

## Disclaimer

Needless to say, I am not responsible for what horrible things might happen to you on restore. Good luck!
