# User configuration

# include Z
. /usr/local/etc/profile.d/z.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# prompt greeting
h=`date +%H`
if [ $h -lt 12 ]; then
  TIMEOFDAY="morning"
elif [ $h -lt 18 ]; then
  TIMEOFDAY="afternoon"
else
  TIMEOFDAY="evening"
fi
echo "Good ${TIMEOFDAY}, Yevhen."

