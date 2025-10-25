/* See LICENSE file for copyright and license details. */

/* Helper macros for spawning commands */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define CMD(...)   { .v = (const char*[]){ __VA_ARGS__, NULL } }

/* appearance */
static const unsigned int borderpx       = 3;   /* border pixel of windows */
static const unsigned int snap           = 32;  /* snap pixel */
static const int swallowfloating         = 0;   /* 1 means swallow floating windows by default */
static const unsigned int gappih         = 20;  /* horiz inner gap between windows */
static const unsigned int gappiv         = 10;  /* vert inner gap between windows */
static const unsigned int gappoh         = 10;  /* horiz outer gap between windows and screen edge */
static const unsigned int gappov         = 30;  /* vert outer gap between windows and screen edge */
static const int smartgaps_fact          = 1;   /* gap factor when there is only one client; 0 = no gaps, 3 = 3x outer gaps */
static const int showbar                 = 1;   /* 0 means no bar */
static const int topbar                  = 1;   /* 0 means bottom bar */
/* Status is to be shown on: -1 (all monitors), 0 (a specific monitor by index), 'A' (active monitor) */
static const int statusmon               = 'A';

/* Indicators: see patch/bar_indicators.h for options */
static int tagindicatortype              = INDICATOR_TOP_LEFT_SQUARE;
static int tiledindicatortype            = INDICATOR_NONE;
static int floatindicatortype            = INDICATOR_TOP_LEFT_SQUARE;
static int aotindicatortype              = INDICATOR_TOP_LEFT_LARGER_SQUARE;
static const char *fonts[]               = { "monospace:size=10" };
static const char dmenufont[]            = "monospace:size=10";

static char c000000[]                    = "#000000"; // placeholder value

static char normfgcolor[]                = "#cccccc";
static char normbgcolor[]                = "#000000";
static char normbordercolor[]            = "#444444";
static char normfloatcolor[]             = "#cccccc";

static char selfgcolor[]                 = "#000000";
static char selbgcolor[]                 = "#ffffff";
static char selbordercolor[]             = "#ffffff";
static char selfloatcolor[]              = "#000000";

static char titlenormfgcolor[]           = "#aaaaaa";
static char titlenormbgcolor[]           = "#000000";
static char titlenormbordercolor[]       = "#444444";
static char titlenormfloatcolor[]        = "#888888";

static char titleselfgcolor[]            = "#000000";
static char titleselbgcolor[]            = "#ffffff";
static char titleselbordercolor[]        = "#ffffff";
static char titleselfloatcolor[]         = "#ffffff";

static char tagsnormfgcolor[]            = "#aaaaaa";
static char tagsnormbgcolor[]            = "#000000";
static char tagsnormbordercolor[]        = "#444444";
static char tagsnormfloatcolor[]         = "#888888";

static char tagsselfgcolor[]             = "#000000";
static char tagsselbgcolor[]             = "#ffffff";
static char tagsselbordercolor[]         = "#ffffff";
static char tagsselfloatcolor[]          = "#ffffff";

static char hidnormfgcolor[]             = "#666666";
static char hidselfgcolor[]              = "#aaaaaa";
static char hidnormbgcolor[]             = "#000000";
static char hidselbgcolor[]              = "#000000";

static char urgfgcolor[]                 = "#ffffff";
static char urgbgcolor[]                 = "#000000";
static char urgbordercolor[]             = "#ff0000";
static char urgfloatcolor[]              = "#888888";

static char *colors[][ColCount] = {
	/*                       fg                bg                border                float */
	[SchemeNorm]         = { normfgcolor,      normbgcolor,      normbordercolor,      normfloatcolor },
	[SchemeSel]          = { selfgcolor,       selbgcolor,       selbordercolor,       selfloatcolor },
	[SchemeTitleNorm]    = { titlenormfgcolor, titlenormbgcolor, titlenormbordercolor, titlenormfloatcolor },
	[SchemeTitleSel]     = { titleselfgcolor,  titleselbgcolor,  titleselbordercolor,  titleselfloatcolor },
	[SchemeTagsNorm]     = { tagsnormfgcolor,  tagsnormbgcolor,  tagsnormbordercolor,  tagsnormfloatcolor },
	[SchemeTagsSel]      = { tagsselfgcolor,   tagsselbgcolor,   tagsselbordercolor,   tagsselfloatcolor },
	[SchemeHidNorm]      = { hidnormfgcolor,   hidnormbgcolor,   c000000,              c000000 },
	[SchemeHidSel]       = { hidselfgcolor,    hidselbgcolor,    c000000,              c000000 },
	[SchemeUrg]          = { urgfgcolor,       urgbgcolor,       urgbordercolor,       urgfloatcolor },
};

const char *spcmd1[] = {"st", "-n", "spterm", "-g", "120x34", NULL };
const char *spcmd2[] = {"st", "-n", "spcalc", "-f", "monospace:size=16", "-g", "50x20", "-e", "bc", "-lq", NULL };
static Sp scratchpads[] = {
   /* name          cmd  */
   {"spterm",      spcmd1},
   {"spcalc",      spcmd2},
};

/* Tags
 * In a traditional dwm the number of tags in use can be changed simply by changing the number
 * of strings in the tags array. This build does things a bit different which has some added
 * benefits. If you need to change the number of tags here then change the NUMTAGS macro in dwm.c.
 *
 * Examples:
 *
 *  1) static char *tagicons[][NUMTAGS*2] = {
 *         [DEFAULT_TAGS] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I" },
 *     }
 *
 *  2) static char *tagicons[][1] = {
 *         [DEFAULT_TAGS] = { "•" },
 *     }
 *
 * The first example would result in the tags on the first monitor to be 1 through 9, while the
 * tags for the second monitor would be named A through I. A third monitor would start again at
 * 1 through 9 while the tags on a fourth monitor would also be named A through I. Note the tags
 * count of NUMTAGS*2 in the array initialiser which defines how many tag text / icon exists in
 * the array. This can be changed to *3 to add separate icons for a third monitor.
 *
 * For the second example each tag would be represented as a bullet point. Both cases work the
 * same from a technical standpoint - the icon index is derived from the tag index and the monitor
 * index. If the icon index is is greater than the number of tag icons then it will wrap around
 * until it an icon matches. Similarly if there are two tag icons then it would alternate between
 * them. This works seamlessly with alternative tags and alttagsdecoration patches.
 */
static char *tagicons[][NUMTAGS] =
{
	[DEFAULT_TAGS]        = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
	[ALTERNATIVE_TAGS]    = { "A", "B", "C", "D", "E", "F", "G", "H", "I" },
	[ALT_TAGS_DECORATION] = { "<1>", "<2>", "<3>", "<4>", "<5>", "<6>", "<7>", "<8>", "<9>" },
};

/* There are two options when it comes to per-client rules:
 *  - a typical struct table or
 *  - using the RULE macro
 *
 * A traditional struct table looks like this:
 *    // class      instance  title  wintype  tags mask  isfloating  monitor
 *    { "Gimp",     NULL,     NULL,  NULL,    1 << 4,    0,          -1 },
 *    { "Firefox",  NULL,     NULL,  NULL,    1 << 7,    0,          -1 },
 *
 * The RULE macro has the default values set for each field allowing you to only
 * specify the values that are relevant for your rule, e.g.
 *
 *    RULE(.class = "Gimp", .tags = 1 << 4)
 *    RULE(.class = "Firefox", .tags = 1 << 7)
 *
 * Refer to the Rule struct definition for the list of available fields depending on
 * the patches you enable.
 */
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 *	WM_WINDOW_ROLE(STRING) = role
	 *	_NET_WM_WINDOW_TYPE(ATOM) = wintype
	 */
	RULE(.wintype = WTYPE "DIALOG", .isfloating = 1)
	RULE(.wintype = WTYPE "UTILITY", .isfloating = 1)
	RULE(.wintype = WTYPE "TOOLBAR", .isfloating = 1)
	RULE(.wintype = WTYPE "SPLASH", .isfloating = 1)

	RULE(.class = "St", .isterminal = 1)
	RULE(.class = "Gimp", .tags = 1 << 8)
	RULE(.class = "mpv", .title = "Now Playing", .isfloating = 1)
	RULE(.class = "qBittorrent", .tags = 1 << 8)
	RULE(.class = "org.nicotine_plus.Nicotine", .tags = 1 << 8)
	RULE(.instance = "spterm", .tags = SPTAG(0), .isfloating = 1)
	RULE(.instance = "spcalc", .tags = SPTAG(1), .isfloating = 1, .isterminal = 1)
};

/* Bar rules allow you to configure what is shown where on the bar, as well as
 * introducing your own bar modules.
 *
 *    monitor:
 *      -1  show on all monitors
 *       0  show on monitor 0
 *      'A' show on active monitor (i.e. focused / selected) (or just -1 for active?)
 *    bar - bar index, 0 is default, 1 is extrabar
 *    alignment - how the module is aligned compared to other modules
 *    widthfunc, drawfunc, clickfunc - providing bar module width, draw and click functions
 *    name - does nothing, intended for visual clue and for logging / debugging
 */
static const BarRule barrules[] = {
	/* monitor   bar    alignment         widthfunc                 drawfunc                clickfunc                hoverfunc                name */
	{ -1,        0,     BAR_ALIGN_LEFT,   width_tags,               draw_tags,              click_tags,              hover_tags,              "tags" },
	{ -1,        0,     BAR_ALIGN_LEFT,   width_ltsymbol,           draw_ltsymbol,          click_ltsymbol,          NULL,                    "layout" },
	{ statusmon, 0,     BAR_ALIGN_RIGHT,  width_status,             draw_status,            click_statuscmd,         NULL,                    "status" },
	{ -1,        0,     BAR_ALIGN_NONE,   width_wintitle,           draw_wintitle,          click_wintitle,          NULL,                    "wintitle" },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int refreshrate = 120;  /* refresh rate (per second) for client move/resize */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

#define STACKKEYS(MOD,ACTION) \
	{ MOD, XK_j,     ACTION##stack, {.i = INC(+1) } }, \
	{ MOD, XK_k,     ACTION##stack, {.i = INC(-1) } }, \
	{ MOD, XK_s,     ACTION##stack, {.i = PREVSEL } }, \
	{ MOD, XK_w,     ACTION##stack, {.i = 0 } }, \
	{ MOD, XK_e,     ACTION##stack, {.i = 1 } }, \
	{ MOD, XK_a,     ACTION##stack, {.i = 2 } }, \
	{ MOD, XK_z,     ACTION##stack, {.i = -1 } },

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {
	"dmenu_run",
	"-m", dmenumon,
	"-fn", dmenufont,
	"-nb", normbgcolor,
	"-nf", normfgcolor,
	"-sb", selbgcolor,
	"-sf", selfgcolor,
	NULL
};
static const char *termcmd[]  = { "st", NULL };

/* This defines the name of the executable that handles the bar (used for signalling purposes) */
#define STATUSBAR "dwmblocks"

/*
* Xresources preferences to load at startup.
*
*     Name                      Type       Address
*    ------------------------------------------------
*     "nmaster"                 INTEGER    &nmaster
*     "mfact"                   FLOAT      &mfact
*     "color1"                  STRING     &color1
*
* In the Xresources file setting resources shoud be prefixed with "dwm.", e.g.
*
*    dwm.nmaster: 1
*    dwm.mfact: 0.50
*    dwm.color1: #FA6EFA
*
* Note that the const qualifier must be removed from the variables if you plan on
* overriding them with values from Xresources. While resources can be reloaded
* using the xrdb function some changes may only take effect following a restart.
*/
ResourcePref resources[] = {
	/* Resource name            Type       Address                */
	{ "normfgcolor",            STRING,    &normfgcolor },
	{ "normbgcolor",            STRING,    &normbgcolor },
	{ "normbordercolor",        STRING,    &normbordercolor },
	{ "normfloatcolor",         STRING,    &normfloatcolor },
	{ "selfgcolor",             STRING,    &selfgcolor },
	{ "selbgcolor",             STRING,    &selbgcolor },
	{ "selbordercolor",         STRING,    &selbordercolor },
	{ "selfloatcolor",          STRING,    &selfloatcolor },
	{ "titlenormfgcolor",       STRING,    &titlenormfgcolor },
	{ "titlenormbgcolor",       STRING,    &titlenormbgcolor },
	{ "titlenormbordercolor",   STRING,    &titlenormbordercolor },
	{ "titlenormfloatcolor",    STRING,    &titlenormfloatcolor },
	{ "titleselfgcolor",        STRING,    &titleselfgcolor },
	{ "titleselbgcolor",        STRING,    &titleselbgcolor },
	{ "titleselbordercolor",    STRING,    &titleselbordercolor },
	{ "titleselfloatcolor",     STRING,    &titleselfloatcolor },
	{ "tagsnormfgcolor",        STRING,    &tagsnormfgcolor },
	{ "tagsnormbgcolor",        STRING,    &tagsnormbgcolor },
	{ "tagsnormbordercolor",    STRING,    &tagsnormbordercolor },
	{ "tagsnormfloatcolor",     STRING,    &tagsnormfloatcolor },
	{ "tagsselfgcolor",         STRING,    &tagsselfgcolor },
	{ "tagsselbgcolor",         STRING,    &tagsselbgcolor },
	{ "tagsselbordercolor",     STRING,    &tagsselbordercolor },
	{ "tagsselfloatcolor",      STRING,    &tagsselfloatcolor },
	{ "hidnormfgcolor",         STRING,    &hidnormfgcolor },
	{ "hidnormbgcolor",         STRING,    &hidnormbgcolor },
	{ "hidselfgcolor",          STRING,    &hidselfgcolor },
	{ "hidselbgcolor",          STRING,    &hidselbgcolor },
	{ "urgfgcolor",             STRING,    &urgfgcolor },
	{ "urgbgcolor",             STRING,    &urgbgcolor },
	{ "urgbordercolor",         STRING,    &urgbordercolor },
	{ "urgfloatcolor",          STRING,    &urgfloatcolor },
};

#include <X11/XF86keysym.h>

static const Key keys[] = {
	/* modifier                     key            function                argument */

  /* IDK maybe important */
	STACKKEYS(MODKEY,                              focus)
	STACKKEYS(MODKEY|ShiftMask,                    push)

  /* Navigation */
	TAGKEYS(                        XK_1,                                  0)
	TAGKEYS(                        XK_2,                                  1)
	TAGKEYS(                        XK_3,                                  2)
	TAGKEYS(                        XK_4,                                  3)
	TAGKEYS(                        XK_5,                                  4)
	TAGKEYS(                        XK_6,                                  5)
	TAGKEYS(                        XK_7,                                  6)
	TAGKEYS(                        XK_8,                                  7)
	TAGKEYS(                        XK_9,                                  8)
	{ MODKEY,                       XK_Tab,        view,                   {0} },
	{ MODKEY,                       XK_0,          view,                   {.ui = ~SPTAGMASK } },

  /* Tab Shenanigans */
	{ MODKEY|ShiftMask,             XK_g,          shifttag,               { .i = +1 } }, // note keybinding conflict with focusadjacenttag tagtoleft
	{ MODKEY|ShiftMask,             XK_semicolon,  shifttag,               { .i = -1 } }, // note keybinding conflict with focusadjacenttag tagtoright
	{ MODKEY,                       XK_g,          shiftview,              { .i = +1 } },
	{ MODKEY,                       XK_semicolon,  shiftview,              { .i = -1 } },

	/* Volume control */
	{ MODKEY,			                  XK_minus,      spawn,                  SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-; kill -44 $(pidof dwmblocks)") },
	{ MODKEY|ShiftMask,		          XK_minus,      spawn,                  SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 15%-; kill -44 $(pidof dwmblocks)") },
	{ MODKEY,			                  XK_equal,      spawn,                  SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+; kill -44 $(pidof dwmblocks)") },
	{ MODKEY|ShiftMask,		          XK_equal,      spawn,                  SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 15%+; kill -44 $(pidof dwmblocks)") },
	{ MODKEY|ShiftMask,		          XK_m,          spawn,                  SHCMD("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle; kill -44 $(pidof dwmblocks)") },
	{ 0, XF86XK_AudioMute,                         spawn,                  SHCMD("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle; kill -44 $(pidof dwmblocks)") },
	{ 0, XF86XK_AudioRaiseVolume,                  spawn,                  SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%- && wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+; kill -44 $(pidof dwmblocks)") },
	{ 0, XF86XK_AudioLowerVolume,                  spawn,                  SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%+ && wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-; kill -44 $(pidof dwmblocks)") },

  /* Controls */
	{ MODKEY,                       XK_d,          spawn,                  {.v = dmenucmd } },
	{ MODKEY,                       XK_Return,     spawn,                  {.v = termcmd } },
  { MODKEY,                       XK_w,          spawn,                  {.v = (const char*[]) { "librewolf", NULL } } },
	{ MODKEY,                       XK_b,          togglebar,              {0} },
	{ MODKEY,                       XK_h,          setmfact,               {.f = -0.05} },
	{ MODKEY,                       XK_l,          setmfact,               {.f = +0.05} },
	{ MODKEY,                       XK_space,      zoom,                   {0} },
	{ MODKEY,                       XK_q,          killclient,             {0} },
	{ MODKEY,                       XK_f,          togglefullscreen,       {0} },
	{ MODKEY,                       XK_s,          togglesticky,           {0} },
	{ MODKEY|ShiftMask,             XK_space,      togglefloating,         {0} },

  /* Master Control */
	{ MODKEY,                       XK_o,          incnmaster,             {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_o,          incnmaster,             {.i = -1 } },

  /* Gap Control */
	{ MODKEY|ControlMask,           XK_u,          incrgaps,               {.i = +1 } },
	{ MODKEY|ControlMask|ShiftMask, XK_u,          incrgaps,               {.i = -1 } },
	{ MODKEY|ControlMask,           XK_i,          incrigaps,              {.i = +1 } },
	{ MODKEY|ControlMask|ShiftMask, XK_i,          incrigaps,              {.i = -1 } },
	{ MODKEY|ControlMask,           XK_o,          incrogaps,              {.i = +1 } },
	{ MODKEY|ControlMask|ShiftMask, XK_o,          incrogaps,              {.i = -1 } },
	{ MODKEY|ControlMask,           XK_6,          incrihgaps,             {.i = +1 } },
	{ MODKEY|ControlMask|ShiftMask, XK_6,          incrihgaps,             {.i = -1 } },
	{ MODKEY|ControlMask,           XK_7,          incrivgaps,             {.i = +1 } },
	{ MODKEY|ControlMask|ShiftMask, XK_7,          incrivgaps,             {.i = -1 } },
	{ MODKEY|ControlMask,           XK_8,          incrohgaps,             {.i = +1 } },
	{ MODKEY|ControlMask|ShiftMask, XK_8,          incrohgaps,             {.i = -1 } },
	{ MODKEY|ControlMask,           XK_9,          incrovgaps,             {.i = +1 } },
	{ MODKEY|ControlMask|ShiftMask, XK_9,          incrovgaps,             {.i = -1 } },
	{ MODKEY,                       XK_a,          togglegaps,             {0} },
	{ MODKEY|ShiftMask,             XK_a,          defaultgaps,            {0} },

	/* Function Keys */
	{ MODKEY,			                  XK_F1,	       spawn,		               SHCMD("st -e nmtui") },
  { MODKEY,                       XK_F2,         spawn,                  SHCMD("setxkbmap -option caps:swapescape")},
  { MODKEY,                       XK_F3,         spawn,                  {.v = (const char*[]){ "toggle_touchpad", NULL } } },
	{ MODKEY,			                  XK_F5,         xrdb,                   {.v = NULL } },
	{ MODKEY,			                  XK_F11,        spawn,                  SHCMD("mpv --untimed --vf=hflip --no-cache --no-osc --no-input-default-bindings --profile=low-latency --input-conf=/dev/null --title=webcam $(ls /dev/video[0,2,4,6,8] | tail -n 1)") },

  /* Power Off */
	{ MODKEY|ShiftMask,		          XK_q,          spawn,                  {.v = (const char*[]){ "sysact", NULL } } },
  { MODKEY,                       XK_BackSpace,  spawn,                  {.v = (const char*[]){ "sysact", NULL } } },
	{ MODKEY|ControlMask|ShiftMask, XK_q,          quit,                   {1} },

	{ MODKEY,                       XK_t,          setlayout,              {.v = &layouts[0]} },
	{ MODKEY|ShiftMask,             XK_f,          setlayout,              {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,          setlayout,              {.v = &layouts[2]} },
	{ MODKEY|ControlMask,           XK_space,      setlayout,              {0} },
	{ MODKEY|ShiftMask|ControlMask, XK_space,      togglealwaysontop,      {0} },
	{ MODKEY,                       XK_grave,      togglescratch,          {.ui = 0 } },
	{ MODKEY|ControlMask,           XK_grave,      setscratch,             {.ui = 0 } },
	{ MODKEY|ShiftMask,             XK_grave,      removescratch,          {.ui = 0 } },
	{ MODKEY|ShiftMask,             XK_0,          tag,                    {.ui = ~SPTAGMASK } },
	{ MODKEY,                       XK_comma,      focusmon,               {.i = -1 } },
	{ MODKEY,                       XK_period,     focusmon,               {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,      tagmon,                 {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,     tagmon,                 {.i = +1 } },

	/* Scratchpad */
	{ MODKEY,			                  XK_apostrophe, togglescratch,          {.ui = 1} },

	/* Brightness Controls */
	{ 0, XF86XK_MonBrightnessUp,                   spawn,                  SHCMD("brightnessctl s 1000+") },
	{ 0, XF86XK_MonBrightnessDown,                 spawn,                  SHCMD("brightnessctl s 1000-") },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask           button          function        argument */
	{ ClkLtSymbol,          0,                   Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,                   Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,                   Button2,        zoom,           {0} },
	{ ClkStatusText,        0,                   Button1,        sigstatusbar,   {.i = 1 } },
	{ ClkStatusText,        0,                   Button2,        sigstatusbar,   {.i = 2 } },
	{ ClkStatusText,        0,                   Button3,        sigstatusbar,   {.i = 3 } },
	{ ClkClientWin,         MODKEY,              Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,              Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,              Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,                   Button1,        view,           {0} },
	{ ClkTagBar,            0,                   Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,              Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,              Button3,        toggletag,      {0} },
};

