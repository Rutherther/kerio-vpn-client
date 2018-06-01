if [[ $(ip a show kvnet up | grep inet | wc -l) -eq 0 ]]; then
  exit 1
fi

exit 0
