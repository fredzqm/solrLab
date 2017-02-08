cd export;
for file in *; do
  echo 'id	coordinate' > "$file.tsv";
  cat "$file" >> "$file.tsv";
  rm -rf "$file";
done
