hugo new "changelog/new-content.md"
if [ -z "$2"];then
	hugo new "blog/$1"
	nvim ./content/blog/$1
else
	hugo new "$2/$1";
	nvim ./content/$2/$1
fi
