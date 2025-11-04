# Tmux Cheat Sheet & Quick Reference

## Sessions

### Start New Session
```bash
tmux
tmux new
tmux new-session
```
Or within tmux:
```bash
:new
```

### Start/Attach Named Session
```bash
tmux new-session -A -s mysession
```
Start new or attach to existing session named *mysession*

### Start Named Session
```bash
tmux new -s mysession
```
Or within tmux:
```
:new -s mysession
```

### Kill/Delete Session
Within tmux:
```
:kill-session
```
Kill current session

From shell:
```bash
tmux kill-ses -t mysession
tmux kill-session -t mysession
```
Kill session *mysession*

```bash
tmux kill-session -a
```
Kill all sessions except current

```bash
tmux kill-session -a -t mysession
```
Kill all sessions except *mysession*

### Session Management
- `Ctrl+b $` - Rename session
- `Ctrl+b d` - Detach from session
- `Ctrl+b s` - Show all sessions

### Detach Others
```
:attach -d
```
Detach others on session (maximize window by detaching other clients)

### List Sessions
```bash
tmux ls
tmux list-sessions
```
Or: `Ctrl+b s`

### Attach to Session
```bash
tmux a
tmux at
tmux attach
tmux attach-session
```
Attach to last session

```bash
tmux a -t mysession
tmux at -t mysession
tmux attach -t mysession
tmux attach-session -t mysession
```
Attach to session named *mysession*

### Session Navigation
- `Ctrl+b w` - Session and window preview
- `Ctrl+b (` - Move to previous session
- `Ctrl+b )` - Move to next session

## Windows

### Start Session with Named Window
```bash
tmux new -s mysession -n mywindow
```

### Window Management
- `Ctrl+b c` - Create window
- `Ctrl+b ,` - Rename current window
- `Ctrl+b &` - Close current window
- `Ctrl+b w` - List windows
- `Ctrl+b p` - Previous window
- `Ctrl+b n` - Next window
- `Ctrl+b 0...9` - Switch to window by number

### Reorder Windows
```
:swap-window -s 2 -t 1
```
Reorder window, swap window 2 and 1

```
:swap-window -t -1
```
Move current window to the left by one position

### Move Window
```
:move-window -t <session_name>
```
Move current window to another session

## Panes

### Split Panes
- `Ctrl+b ;` - Toggle last active pane
- `Ctrl+b %` - Split pane vertically
- `Ctrl+b "` - Split pane horizontally
- `Ctrl+b {` - Move current pane left
- `Ctrl+b }` - Move current pane right
- `Ctrl+b ↑` - Switch to pane above
- `Ctrl+b ↓` - Switch to pane below
- `Ctrl+b ←` - Switch to pane left
- `Ctrl+b →` - Switch to pane right
- `Ctrl+b o` - Switch to next pane
- `Ctrl+b q` - Show pane numbers
- `Ctrl+b q 0...9` - Switch to pane by number
- `Ctrl+b z` - Toggle pane zoom
- `Ctrl+b !` - Convert pane into window
- `Ctrl+b x` - Close current pane

### Resize Panes
- `Ctrl+b Ctrl+↑` - Resize pane up
- `Ctrl+b Ctrl+↓` - Resize pane down
- `Ctrl+b Ctrl+←` - Resize pane left
- `Ctrl+b Ctrl+→` - Resize pane right

### Resize by 5 Cells
- `Ctrl+b Alt+↑` - Resize pane up by 5
- `Ctrl+b Alt+↓` - Resize pane down by 5
- `Ctrl+b Alt+←` - Resize pane left by 5
- `Ctrl+b Alt+→` - Resize pane right by 5

### Pane Layouts
- `Ctrl+b Space` - Toggle between pane layouts

### Pane Movement
```
:setw synchronize-panes
```
Toggle synchronize-panes (send command to all panes)

## Copy Mode

### Enter Copy Mode
- `Ctrl+b [` - Enter copy mode

### Navigation in Copy Mode
- `q` - Quit mode
- `g` - Go to top line
- `G` - Go to bottom line
- `↑` - Scroll up
- `↓` - Scroll down
- `h` - Move cursor left
- `j` - Move cursor down
- `k` - Move cursor up
- `l` - Move cursor right
- `w` - Move cursor forward one word
- `b` - Move cursor backward one word
- `/` - Search forward
- `?` - Search backward
- `n` - Next keyword occurrence
- `N` - Previous keyword occurrence
- `Space` - Start selection
- `Esc` - Clear selection
- `Enter` - Copy selection

### Paste
- `Ctrl+b ]` - Paste contents of buffer

### List Buffers
```
:list-buffers
```
Show all buffers

```
:choose-buffer
```
Show all buffers and paste selected

```
:save-buffer buf.txt
```
Save buffer contents to file

```
:delete-buffer -b 1
```
Delete buffer 1

## Help

### Show Shortcuts
- `Ctrl+b ?` - List all key bindings

### Show Commands
```
:list-commands
tmux list-commands
```

### Show Config
```
:show-options -g
tmux show-options -g
```

### Show Window Options
```
:show-options -gw
tmux show-options -gw
```

## Misc

### Enter Command Mode
- `Ctrl+b :` - Enter command mode

### Set Options
```
:set -g OPTION
```
Set option for all sessions

```
:setw -g OPTION
```
Set option for all windows

```
:setw OPTION
```
Set option for current window

### Enable Mouse Mode
```
:set mouse on
```

## Configuration

Configuration file location: `~/.tmux.conf`

### Example Configuration
```bash
# Change prefix from Ctrl+b to Ctrl+a
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Enable mouse mode
set -g mouse on

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# Split panes using | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Reload config file
bind r source-file ~/.tmux.conf

# Switch panes using Alt-arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D
```

## Tips

- **Prefix key**: Default is `Ctrl+b`, press it before any command
- **Command mode**: `Ctrl+b :` then type tmux commands
- **Detach vs Exit**: Detach (`Ctrl+b d`) keeps session running, exit/kill closes it
- **Multiple sessions**: Run multiple independent sessions for different projects
- **Mouse mode**: Enable for easier pane/window selection and resizing
