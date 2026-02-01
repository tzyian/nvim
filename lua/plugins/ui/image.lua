return {
  "3rd/image.nvim",
  build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  opts = {
    -- "kitty", or "ueberzug" or "sixel"
    processor = "magick_cli",
    backend = "sixel",
    integrations = {
      markdown = {
        -- Only render on cursor because performance is bad on sixel
        only_render_image_at_cursor = true,
        -- "popup" seems to cause "height is not integral" errors
        only_render_image_at_cursor_mode = "inline",
        floating_windows = true,
      },
    },
  }
}
