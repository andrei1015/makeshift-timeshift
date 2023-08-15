# Makeshift-Timeshift

The idea behind Timeshift is pretty simple, but itdoesn't seem to be able to run in a terminal-only mode, XServer is a dependency, so I made the same thing, but for terminal-only situations.

## Usage/Examples

#### -c / --create

This parameter is used to create a new snapshot

#### -l / --list

List all currently available local snapshots

#### -R / --clean-all

Delete everything inside the /backups folder, including archives

#### -r / --clean-archives

Delete everything inside the `archives` folder

## Run

Clone the project

```bash
  git clone https://github.com/andrei1015/makeshift-timeshift
```

Go to the project directory

```bash
  cd makeshift-timeshift
```

Run the script to create a new snapshot (or whatever)

```bash
  sudo ./snap.sh -c
```