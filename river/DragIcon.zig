// This file is part of river, a dynamic tiling wayland compositor.
//
// Copyright 2020 Isaac Freund
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

const Self = @This();

const std = @import("std");

const c = @import("c.zig");

const Seat = @import("Seat.zig");

seat: *Seat,
wlr_drag_icon: *c.wlr_drag_icon,

layout_x: f64,
layout_y: f64,

listen_commit: c.wl_listener = undefined,

pub fn init(self: *Self, seat: *Seat, wlr_drag_icon: *c.wlr_drag_icon) void {
    self.* = .{
        .seat = seat,
        .wlr_drag_icon = wlr_drag_icon,
        .layout_x = seat.cursor.wlr_cursor.x,
        .layout_y = seat.cursor.wlr_cursor.y,
    };

    self.listen_commit.notify = handleCommit;
    c.wl_signal_add(&wlr_drag_icon.surface.*.events.commit, &self.listen_commit);
}

pub fn updatePos(self: *Self) void {
    switch (self.wlr_drag_icon.drag.grab_type) {
        .WLR_DRAG_GRAB_KEYBOARD_POINTER => {
            self.layout_x = self.seat.cursor.wlr_cursor.x;
            self.layout_y = self.seat.cursor.wlr_cursor.y;
        },
        else => unreachable,
    }
}

fn handleCommit(listener: ?*c.wl_listener, data: ?*c_void) callconv(.C) void {
    const self = @fieldParentPtr(Self, "listen_commit", listener.?);
}
