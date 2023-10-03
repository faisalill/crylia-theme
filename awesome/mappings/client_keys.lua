-- Awesome Libs
require("awful.autofocus")
local awful = require("awful")
local gears = require("gears")

local modkey = user_vars.modkey

return gears.table.join(
  awful.key(
    { modkey },
    "#41",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "Toggle fullscreen", group = "Client" }
  ),
  awful.key(
    { modkey },
    "#45",
    function(c)
      c:kill()
    end,
    { description = "Close focused client", group = "Client" }
  ),
  awful.key(
    { modkey },
    "#42",
    awful.client.floating.toggle,
    { description = "Toggle floating window", group = "Client" }
  ),
  awful.key(
    { modkey },
    "#58",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = "(un)maximize", group = "Client" }
  ),
  awful.key(
    { modkey },
    "#57",
    function(c)
      if c == client.focus then
        c.minimized = true
      else
        c.minimized = false
        if not c:isvisible() and c.first_tag then
          c.first_tag:view_only()
        end
        c:emit_signal('request::activate')
        c:raise()
      end
    end,
    { description = "(un)hide", group = "Client" }
  ),
  awful.key(
    { modkey },
    "#113",
    function(c)
      local client_x = c.x
      local client_y = c.y
      local client_width = c.width
      local client_height = c.height
      local screen_x = awful.screen.focused().geometry.x
      local screen_y = awful.screen.focused().geometry.y
      local screen_width = awful.screen.focused().geometry.width
      local screen_height = awful.screen.focused().geometry.height
      local distance_to_left = client_x - screen_x
      local distance_to_top = client_y - screen_y
      local new_width = screen_width / 2
      local new_height = screen_height
    
      if client_width == screen_width and client_height == screen_height / 2 and client_x == screen_x and client_y == screen_height / 2 then
        new_height = screen_height / 2
        c:relative_move(0, 0, new_width - client_width, new_height - client_height)
      elseif client_x == screen_width / 2 and client_y == screen_x and client_width == screen_width / 2 and client_height == screen_height / 2 then
        new_width = screen_width 
        new_height = screen_height / 2
        c:relative_move(-distance_to_left, 0, new_width - client_width, new_height - client_height)
      elseif client_x == screen_width / 2 and client_y == screen_height / 2 and client_width == screen_width / 2 and client_height == screen_height / 2 then
        new_width = screen_width 
        new_height = screen_height / 2
        c:relative_move(-distance_to_left, 0, new_width - client_width, new_height - client_height)
      elseif client_width == screen_width and client_height == screen_height / 2 then
        new_height = screen_height / 2
        c:relative_move(-distance_to_left, -distance_to_top, new_width - client_width, new_height - client_height)
      elseif client_width == screen_width / 2 and client_height == screen_height and client_x == screen_width / 2 and client_y == screen_x then
        new_width = screen_width
        c:relative_move(-distance_to_left, 0, new_width - client_width, new_height - client_height)
      else 
        c:relative_move(-distance_to_left, -distance_to_top, new_width - client_width, new_height - client_height)
      end
    end,
    { description = "Move Focused Client To Left(50%Width)", group = "Client" }
  ),
  awful.key(
    { modkey },
    "#114",
    function(c)
      local client_x = c.x
      local client_y = c.y
      local client_width = c.width
      local client_height = c.height
      local screen_x = awful.screen.focused().geometry.x
      local screen_y = awful.screen.focused().geometry.y
      local screen_width = awful.screen.focused().geometry.width
      local screen_height = awful.screen.focused().geometry.height
      local distance_to_right = (screen_width / 2) - client_x
      local distance_to_left = client_x - screen_x
      local distance_to_top = client_y - screen_y
      local new_width = screen_width / 2
      local new_height = screen_height

      if client_width == screen_width and client_height == screen_height / 2 and client_x == screen_x and client_y == screen_height / 2 then
        new_height = screen_height / 2
        c:relative_move(distance_to_right, 0, new_width - client_width, new_height - client_height)
      elseif client_x == screen_x and client_y == screen_height / 2 and client_width == screen_width / 2 and client_height == screen_height / 2 then
        new_width = screen_width 
        new_height = screen_height / 2
        c:relative_move(0, 0, new_width - client_width, new_height - client_height)
      elseif client_width == screen_width / 2 and client_height == screen_height and client_x == screen_x and client_y == screen_y then
        new_width = screen_width 
        c:relative_move(0, 0, new_width - client_width, new_height - client_height)        
      elseif client_width == screen_width / 2 and client_height == screen_height / 2 and client_x == screen_x and client_y == screen_y then
        new_width = screen_width 
        new_height = screen_height / 2
        c:relative_move(0, 0, new_width - client_width, new_height - client_height)
      elseif client_width == screen_width and client_height == screen_height / 2 then
        new_height = screen_height / 2
        c:relative_move(distance_to_right, -distance_to_top, new_width - client_width, new_height - client_height)
      else 
        c:relative_move(distance_to_right, -distance_to_top, new_width - client_width, new_height - client_height)
      end
    end,
    { description = "Move Focused Client To Right(50% Width) ", group = "Client" }
  ),
  awful.key(
    { modkey },
    "#111",
    function(c)
      local client_x = c.x
      local client_y = c.y
      local client_width = c.width
      local client_height = c.height
      local screen_x = awful.screen.focused().geometry.x
      local screen_y = awful.screen.focused().geometry.y
      local screen_width = awful.screen.focused().geometry.width
      local screen_height = awful.screen.focused().geometry.height
      local distance_to_left = client_x - screen_x
      local distance_to_top = client_y - screen_y
      local new_width = screen_width 
      local new_height = screen_height / 2
      if client_x == screen_x and client_y == screen_y and client_width == screen_width / 2 and client_height == screen_height then
        new_width = screen_width / 2
        c:relative_move(-distance_to_left, -distance_to_top, new_width - client_width, new_height - client_height)
      elseif client_x == screen_x and client_y == screen_height / 2 and client_width == screen_width / 2 and client_height == screen_height / 2 then
        new_width = screen_width / 2
        new_height = screen_height
        c:relative_move(0, -distance_to_top, new_width - client_width, new_height - client_height)
      elseif client_x == screen_width / 2 and client_y == screen_height / 2 and client_width == screen_width / 2 and client_height == screen_height / 2 then
        new_width = screen_width / 2
        new_height = screen_height
        c:relative_move(0, -distance_to_top, new_width - client_width, new_height - client_height)
      elseif client_x == screen_width / 2 and client_y == screen_y and client_width == screen_width / 2 and client_height == screen_height then
        new_width = screen_width / 2
        c:relative_move(0, -distance_to_top, new_width - client_width, new_height - client_height)
      elseif client_x == screen_x and client_y == screen_height / 2 and client_width == screen_width and client_height == screen_height / 2 then
        new_height = screen_height 
        c:relative_move(0, -distance_to_top, new_width - client_width, new_height - client_height)
      else 
        c:relative_move(-distance_to_left, -distance_to_top, new_width - client_width, new_height - client_height) 
      end
    end,
    { description = "Move Focused Client To Upper Top", group = "Client" }
  ),
  awful.key(
    { modkey },
    "#116",
    function(c)
      local client_x = c.x
      local client_y = c.y
      local client_width = c.width
      local client_height = c.height
      local screen_x = awful.screen.focused().geometry.x
      local screen_y = awful.screen.focused().geometry.y
      local screen_width = awful.screen.focused().geometry.width
      local screen_height = awful.screen.focused().geometry.height
      local distance_to_left = client_x - screen_x
      local distance_to_top = client_y - (screen_height / 2)
      local new_width = screen_width 
      local new_height = screen_height / 2
      if client_width == screen_width and client_height == screen_height / 2 then
        new_height = screen_height 
        c:relative_move(-distance_to_left, -client_y, new_width - client_width, new_height - client_height)
      elseif client_x == screen_width / 2 and client_y == screen_x and client_width == screen_width / 2 and client_height == screen_height / 2 then
        new_width = screen_width / 2
        new_height = screen_height 
        c:relative_move(0, 0, new_width - client_width, new_height - client_height)
      elseif client_x == screen_x and client_y == screen_y and client_width == screen_width / 2 and client_height == screen_height then
        new_width = screen_width / 2
        c:relative_move(-distance_to_left, -distance_to_top, new_width - client_width, new_height - client_height)
      elseif client_x == screen_width / 2 and client_y == screen_y and client_width == screen_width / 2 and client_height == screen_height then
        new_width = screen_width / 2
        c:relative_move(0, -distance_to_top, new_width - client_width, new_height - client_height)
      elseif client_width == screen_width / 2 and client_height == screen_height / 2 and client_x == screen_x and client_y == screen_y then
        new_width = screen_width / 2
        new_height = screen_height
        c:relative_move(0, 0, new_width - client_width, new_height - client_height)        
      else 
        c:relative_move(-distance_to_left, -distance_to_top, new_width - client_width, new_height - client_height)
      end
    end,
    { description = "Move Focused Client to Bottom Half", group = "Client" }
  )
)
