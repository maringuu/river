RIVERCTL(1) "github.com/ifreund/river" "General Commands Manual"
# NAME

riverctl - command-line interface for controlling river

# SYNOPSIS

*riverctl* _command_ [_command specific arguments_]

# DESCRIPTION

*riverctl* is a command-line interface inspired by bspc from bspwm
used to control and configure river.

# COMMANDS

## ACTIONS

*close*
	Close the focused view.

*csd-filter-add* _app-id_
	Add an app-id to the CSD filter list. Windows with this app-id are allowed
	to use client side decoration instead of the default server side decoration.

*exit*
	Exit the compositor, terminating the Wayland session.

*float-filter-add* _app-id_
	Add an app-id to the float filter list. Windows with this app-id will start
	floating.

*focus-output* *next*|*previous*
	Focus next or previous output.

*focus-view* *next*|*previous*
	Focus next or previous view in the stack.

*layout* *full*|_command_
	Provide a command which river will use for generating the layout of
	non-floating windows on the currently focused output. See
	*river-layouts*(7) for details on the expected formatting of the output
	of layout commands. Alternatively, “full” can be given instead of a
	command to cause river to use its single internal layout, in which
	windows span the entire width and height of the output.

*mod-master-count* _integer_
	Increase or decrease the number of master views. _integer_ can be
	positive or negative.

*mod-master-factor* _float_
	Make the master area bigger or smaller. _float_ is a positive or
	negative floating point number (such as 0.05) where 1 corresponds to
	the whole screen.

*move* *up*|*down*
	Moves the focused view either *up* or *down* the focus stack.

*send-to-output* *next*|*previous*
	Send the focused view to the next or the previous output.

*spawn* _shell_command_
	Run _shell_command_ using _/bin/sh -c_. Put single quotes around
	_shell_command_ if you do not want special characters to get
	interpreted by your shell before the command gets passed to _/bin/sh_.

*toggle-float*
	If the focused view is floating, make it tiled. If it is tiled, make
	it floating.

*toggle-fullscreen*
	Toggle the fullscreen state of the focused view.

*zoom*
	Bump the focused view to the top of the layout stack to make it the
	new master.

## ACTIONS ON TAGS

Tags are like workspaces but more flexible: You can assign views to
multiple tags and look at multiple tags at once. A _tagmask_ is used
to represent which tags are visible. The following commands take a
_tagmask_ in base 10 as argument but _tagmasks_ are best understood in
binary: 000000001 means that the first tag is visible; 111111111 means
that tag 1 through 9 are visible.

*set-focused-tags* _tagmask_
	Show the tags specified with _tagmask_.

*set-view-tags* _tagmask_
	Assign focused view to tags specified with _tagmask_.

*toggle-focused-tags* _tagmask_
	Toggle visibility of tags specified with _tagmask_.

*toggle-view-tags* _tagmask_
	Toggle tags of focused view as specified with _tagmask_.

## CONFIGURATION COMMANDS

*attach-mode* *top*|*bottom*
	Configure where new views should attach in the view stack for the currently focused output.

*background-color* _#RRGGBB_|_#RRGGBBAA_
	Set the background color.

*border-color-focused* _#RRGGBB_|_#RRGGBBAA_
	Set the border color of focused views.

*border-color-unfocused* _#RRGGBB_|_#RRGGBBAA_
	Set the border color of unfocused views.

*border-width* _pixels_
	Set the border width to _pixels_.

*declare-mode* _name_
	Create a new mode called _name_ for use in mappings.

*enter-mode* _name_
	Switch to given mode if it exits.

*focus-follows-cursor* *disabled*|*normal*|*strict*
	When _disabled_ moving the cursor will not influence the focus. This is the default setting.
	If set to _normal_ moving the cursor over a window will focus that window.
	The focus still can be changed and moving the cursor within the (now unfocused) window will not change the focus to that window
	but let the currently focused window in focus.
	When set to _strict_ this is not the case. The focus will be updated on every cursor movement.

*map* [-release] _mode_ _modifiers_ _key_ _command_
	_mode_ is either “normal” (the default mode) or a mode created with
	*declare-mode*.
	If _-release_ is specified the mapping is executed on key release rather than key press.
	_modifiers_ is a list of one or more of the following
	modifiers separated with a plus sign:

	- Shift
	- Lock (Caps lock)
	- Control (Ctrl)
	- Mod1 (Alt)
	- Mod2
	- Mod3
	- Mod4 (Super, Logo, Windows)
	- Mod5

	_key_ is an XKB key name. See _/usr/include/xkbcommon/xkbcommon-keysyms.h_
	for a list of special key names. _command_ can be any of the above commands.

	A mapping without modifiers can be created by passing an empty string as
	the modifiers argument.

*map-pointer* _mode_ _modifiers_ _button_ _action_
	_mode_ and _modifiers_ are the same as for *map*.

	_button_ is the name of a linux input event code. The most commonly used
	values are:

	- BTN_LEFT - left mouse button
	- BTN_RIGHT - right mouse button
	- BTN_MIDDLE - middle mouse button

	A complete list may be found in _/usr/include/linux/input-event-codes.h_

	_action_ is one of the following values:

	- move-view
	- resize-view

*outer-padding* _pixels_
	Set the padding around the edge of the screen to _pixels_.

*view-padding* _pixels_
	Set the padding around the edge of each view to _pixels_.

*xcursor-theme* _theme_name_ [_size_]
	Set the xcursor theme to _theme_name_ and optionally set the
	_size_. The theme of the default seat determines the default
	for XWayland and made available through the _XCURSOR_THEME_ and
	_XCURSOR_SIZE_ environment variables.

# EXAMPLES

Bind bemenu-run to Super+P:

	riverctl map normal Mod4 P spawn bemenu-run

See _contrib/config.sh_ for some basic keybindings.

# SEE ALSO

*river*(1), *river-layouts*(7), *rivertile*(1)
