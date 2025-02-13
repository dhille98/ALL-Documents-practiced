#############################
## write shell scripting file is exit or not 

#!/bin/bash

# Ask for a filename
echo "Enter the filename to check:"
read filename

# Check if the file exists
if [ -e "$filename" ]; then
    echo "✅ The file '$filename' exists."
else
    echo "❌ The file '$filename' does not exist."
fi

### 2nd version 
#!/bin/bash

echo "Enter the file or directory name:"
read item

if [ -f "$item" ]; then
    echo "✅ '$item' is a file."
elif [ -d "$item" ]; then
    echo "📂 '$item' is a directory."
else
    echo "❌ '$item' does not exist."
fi


############################################