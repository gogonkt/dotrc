#export GTK2_RC_FILES="~/.gtkrc-2.0:$GTK2_RC_FILES"
export "LANG=zh_CN.UTF-8"
export LC_CTYPE="zh_CN.UTF-8"
export XMODIFIERS="@im=fcitx"
export XIM=fcitx
export XIM_PROGRAM=fcitx
export GTK_IM_MODULE="fcitx"

exec fcitx &
#conky -d&
exec /home/gogonkt/.pack_ffox.sh&
#tpb -d
#exec terminal &
#exec terminal &

xmodmap -e "keycode 131 = Super_L" -e "add mod4 = Super_L"

#exec startxfce4

DEFAULT_SESSION=awesome
#DEFAULT_SESSION=startxfce4

case $1 in
kde)
	exec startkde
	;;
xfce4)
	exec startxfce4
	;;
fluxbox)
	exec fluxbox
	;;
e17)
	exec enlightenment_start
	;;
fvwm-crystal)
	exec fvwm-crystal
	;;
fvwm-themes)
	exec fvwm-themes-start
	;;
fvwm)
	exec fvwm
	;;
awesome)
	conky -d&
	exec xrdb ~/.Xresources&
	exec xfce4-panel&
	exec awesome
	;;
*)
	exec $DEFAULT_SESSION
	;;
esac
