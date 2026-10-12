source scripts/check.sh

test_begin $1 exo.tar 4

cat > "$OUTPUT_PATH/answer.txt" << 'END'
drwx--xr-x 2 - Jun 1 20:47 test0
-rwx--xr-- 1 4 Jun 1 21:46 test1
dr-x---r-- 2 - Jun 1 22:45 test2
-r-----r-- 2 1 Jun 1 23:44 test3
-rw-r----x 1 2 Jun 1 23:43 test4
-r-----r-- 2 1 Jun 1 23:44 test5
lrwxrwxrwx 1 5 Jun 1 22:20 test6 -> test0
END

# ls -l like listing: perms links size(- for dirs) date name [-> target]
list_files ()
{
	for f in *; do
		SIZE=$(stat -c %s "$f")
		[ -d "$f" ] && [ ! -L "$f" ] && SIZE=-
		DATE=$(LC_ALL=C date -d "@$(stat -c %Y "$f")" "+%b %-d %H:%M")
		LINE="$(stat -c '%A %h' "$f") $SIZE $DATE $f"
		[ -L "$f" ] && LINE="$LINE -> $(readlink "$f")"
		echo "$LINE"
	done
}

tar_extract ()
{
	test -f "$USER_DIR/exo.tar" && tar -xpf "$USER_DIR/exo.tar" -C "$WORK"
}
check "exo.tar exists and extracts" tar_extract

tar_content ()
{
	printf "test0\ntest1\ntest2\ntest3\ntest4\ntest5\ntest6\n" > "$OUTPUT_PATH/answer_names.txt"
	tar -tf "$USER_DIR/exo.tar" | sed 's|/$||' | grep -v / | sort > "$OUTPUT_PATH/user_names.txt"
	same_output "$OUTPUT_PATH/answer_names.txt" "$OUTPUT_PATH/user_names.txt"
}
check "exo.tar contains exactly test0..test6" tar_content

ls_output ()
{
	(cd "$WORK" && list_files) > "$OUTPUT_PATH/user.txt"
	same_output "$OUTPUT_PATH/answer.txt" "$OUTPUT_PATH/user.txt"
}
check "ls -l (perms, links, sizes, dates, link target)" ls_output

hard_link ()
{
	[ "$(stat -c %i "$WORK/test3")" = "$(stat -c %i "$WORK/test5")" ]
}
check "test3 and test5 are hard links to the same file" hard_link

chmod -R u+w "$WORK" 2> /dev/null
test_end
