# General Settings..

c = c

config = config

config.load_autoconfig(False)

# Setting up a user agent to avoid the blocking of websites..

config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}",
    "https://web.whatsapp.com/",
)

config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0",
    "https://accounts.google.com/*",
)

config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0",
    "https://docs.google.com/*",
)

config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0",
    "https://drive.google.com/*",
)

# Image Settings...

config.set("content.images", True, "chrome-devtools://*")

config.set("content.images", True, "devtools://*")

# Javascript Settings...

config.set("content.javascript.enabled", True, "chrome-devtools://*")

config.set("content.javascript.enabled", True, "devtools://*")

config.set("content.javascript.enabled", True, "chrome://*/*")

config.set("content.javascript.enabled", True, "qute://*/*")

# colors and position and fonts customisation..

c.aliases = {"q": "quit", "w": "session-save", "wq": "quit --save"}

c.downloads.location.directory = "~/Downloads"

c.tabs.show = "always"

c.url.default_page = "https://start.duckduckgo.com/"

c.url.start_pages = "https://start.duckduckgo.com/"

c.colors.completion.fg = ["#cdd6f4", "#cdd6f4", "#cdd6f4"]

c.colors.completion.item.selected.fg = "#cdd6f4"

c.colors.completion.item.selected.bg = "#000000"

c.colors.completion.item.selected.match.fg = "#cdd6f4"

c.colors.completion.item.selected.border.top = "#cdd6f4"

c.colors.completion.item.selected.border.bottom = "#cdd6f4"

c.colors.completion.match.fg = "#e06c75"

c.colors.completion.scrollbar.fg = "#cdd6f4"

c.colors.completion.category.bg = "#000000"

c.colors.completion.category.fg = "#cdd6f4"

c.colors.contextmenu.menu.bg = "#000000"

c.colors.contextmenu.menu.fg = "#cdd6f4"

c.colors.downloads.bar.bg = "#000000"

c.colors.statusbar.normal.bg = "#000000"

c.colors.statusbar.insert.fg = "white"

c.colors.statusbar.insert.bg = "#000000"

c.colors.statusbar.passthrough.bg = "#000000"

c.colors.statusbar.command.bg = "#000000"

c.colors.statusbar.url.warn.fg = "#f00000"

c.colors.tabs.bar.bg = "#000000"

c.fonts.default_family = '"Jetbrains Mono Nerd"'

c.fonts.default_size = "10.5pt"

c.fonts.completion.entry = "default_size default_family"

c.fonts.prompts = "default_size default_family"

c.fonts.statusbar = "default_size default_family"

c.fonts.tooltip = "default_size default_family"

c.colors.completion.even.bg = "#1c1c1c"

c.colors.completion.odd.bg = "#1c1c1c"

c.completion.open_categories = ["searchengines"]

c.completion.scrollbar.width = 10

c.confirm_quit = ["never"]

c.statusbar.widgets = ["keypress", "scroll"]

c.colors.tabs.even.fg = "#ffffff"

c.colors.tabs.even.bg = "rgba(43,59,43,1)"

c.colors.tabs.odd.fg = "#ffffff"

c.colors.tabs.odd.bg = "rgba(43,59,43,0.4)"

c.colors.statusbar.caret.bg = "#000000"

c.colors.statusbar.caret.fg = "#cdd6f4"

c.colors.webpage.bg = "#000000"

c.colors.statusbar.caret.selection.bg = "#000000"

c.colors.statusbar.caret.selection.fg = "#cdd6f4"

c.colors.statusbar.command.private.bg = "#000000"

c.colors.statusbar.command.private.fg = "#cdd6f4"

c.colors.statusbar.caret.selection.bg = "#1c1c1c"

c.colors.statusbar.caret.selection.fg = "#cdd6f4"

c.colors.statusbar.private.bg = "#000000"

c.colors.statusbar.private.fg = "#cdd6f4"

c.colors.tooltip.bg = "#1c1c1c"

c.colors.tooltip.fg = "#cdd6f4"

c.colors.downloads.bar.bg = "#000000"

c.colors.downloads.error.bg = "#f00000"

c.colors.downloads.error.fg = "#cdd6f4"

c.colors.downloads.start.bg = "#000000"

c.colors.downloads.start.fg = "#cdd6f4"

c.colors.downloads.stop.bg = "#000000"

c.colors.downloads.stop.fg = "#cdd6f4"

c.colors.hints.bg = "#000000"

c.colors.hints.fg = "#cdd6f4"

c.colors.hints.match.fg = "#f38ba8"

c.colors.keyhint.bg = "#000000"

c.colors.keyhint.fg = "#cdd6f4"

config.set("downloads.position", "bottom")

config.set("tabs.background", True)

config.set("window.transparent", True)

config.set("colors.webpage.darkmode.policy.images", "smart")

config.set("colors.webpage.darkmode.enabled", True)

config.set("colors.webpage.darkmode.policy.page", "smart")

config.set("colors.webpage.preferred_color_scheme", "dark")


# binding keys..

config.bind("sa", "config-cycle statusbar.show always never")

config.bind("ta", "config-cycle tabs.show always never")

config.bind(
    "st",
    "config-cycle statusbar.show always never;; config-cycle tabs.show always never",
)

config.bind("<Ctrl-Y>", "open https://www.youtube.com/?gl=IN")

config.bind("<Ctrl-Shift-M>", "hint links spawn mpv {hint-url}")

config.bind("<Ctrl-A>", "open https://archlinux.org/")


# Privacy Settings

config.set("completion.show", "always")

config.set("tabs.close_mouse_button", "none")

config.set("tabs.last_close", "startpage")

config.set("qt.force_software_rendering", "none")

config.set("completion.cmd_history_max_items", 0)

config.set("content.webrtc_ip_handling_policy", "default-public-and-private-interfaces")

config.set("content.webgl", False, "*")

config.set("content.canvas_reading", False)

config.set("content.geolocation", False)

config.set("content.blocking.method", "both")

c.content.blocking.enabled = True

c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://easylist.to/easylist/fanboy-social.txt",
]

config.set("qt.highdpi", False)

config.set("qt.chromium.experimental_web_platform_features", "never")

config.set("content.blocking.hosts.block_subdomains", True)

config.set("content.headers.referer", "same-domain")

config.set("auto_save.session", False)

# Cookies..

config.set("content.cookies.accept", "all")

config.set("content.cookies.store", False)
