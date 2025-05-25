# Check if running under WSL, reload /etc/environment proxy variables
if grep -qiE 'microsoft|wsl' /proc/version; then
  export $(cat /etc/environment | xargs)
fi
