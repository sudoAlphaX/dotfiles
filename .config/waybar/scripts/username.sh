username=$(whoami)
formatted=$(echo "$username" | sed -E 's/(.)(.*)/\U\1\L\2/')

echo "$formatted"
