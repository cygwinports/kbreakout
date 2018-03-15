#! /bin/sh

p="$1"
p1=$(basename $p)
p_dir=${p1%*.tar.xz}
p_version="${p_dir#kbreakout-}"
p_name=${p%-*}
out=$(mktemp -d /tmp/output.XXXXXXXXXX) || { echo "Failed to create temp file"; exit 1; }

tar Jxf $p -C $out
pushd $out
find $p_dir/ \! \( -name *.svgz -prune \) -type f -exec sed -i -e "s|&kbreakout;|KBrickbuster|g" {} \;
find $p_dir/ \! \( -name *.svgz -prune \) -type f -exec sed -i -e "s|kbreakout|kbrickbuster|g" {} \;
find $p_dir/ \! \( -name *.svgz -prune \) -type f -exec sed -i -e "s|KBreakout|KBrickbuster|g" {} \;
find $p_dir/ \! \( -name *.svgz -prune \) -type f -exec sed -i -e "s|Break[Oo]ut|Brickbuster|g" {} \;
find $p_dir/ \! \( -name *.svgz -prune \) -type f -exec sed -i -e "s|breakout|brickbuster|g" {} \;
find $p_dir/ \! \( -name *.svgz -prune \) -type f -exec sed -i -e "s|alienbreakout|alienbrickbuster|g" {} \;
find $p_dir/ \! \( -name *.svgz -prune \) -type f -exec sed -i -e "s|KBreakOut|KBrickbuster|g" {} \;

for f in 128 64 48 32 22 16 ; do 
  if [ -f "$p_dir/pics/$f-apps-kbreakout.png" ]; then
  mv $p_dir/pics/$f-apps-kbreakout.png $p_dir/pics/$f-apps-kbrickbuster.png
  fi
done

for lang in $p_dir/po/* ; do
  mv $lang/kbreakout.po $lang/kbrickbuster.po
  if [ -d "$lang/docs/kbreakout" ] ; then
  mv $lang/docs/kbreakout $lang/docs/kbrickbuster
  fi
done

mv $p_dir/org.kde.kbreakout.desktop $p_dir/org.kde.kbrickbuster.desktop
mv $p_dir/pics/sc-apps-kbreakout.svg $p_dir/pics/sc-apps-kbrickbuster.svg
mv $p_dir/themes/alienbreakout.desktop $p_dir/themes/alienbrickbuster.desktop
mv $p_dir/themes/alienbreakout.svgz $p_dir/themes/alienbrickbuster.svgz
mv $p_dir/themes/egyptian_breakout_preview.png $p_dir/themes/egyptian_brickbuster_preview.png
mv $p_dir/themes/egyptianbreakout.svgz $p_dir/themes/egyptianbrickbuster.svgz
mv $p_dir/src/kbreakout.kcfg $p_dir/src/kbrickbuster.kcfg
mv $p_dir/src/kbreakout.qrc $p_dir/src/kbrickbuster.qrc
mv $p_dir/src/kbreakoutui.rc $p_dir/src/kbrickbusterui.rc
mv $p_dir/src/kbreakout_debug.cpp $p_dir/src/kbrickbuster_debug.cpp
mv $p_dir/src/kbreakout_debug.h $p_dir/src/kbrickbuster_debug.h
popd

mv $out/$p_dir $out/kbrickbuster-${p_version}
pushd $out/
tar Jcf /tmp/kbrickbuster-${p_version}.tar.xz *
popd
echo /tmp/kbrickbuster-${p_version}.tar.xz is created.
rm -rf $out
