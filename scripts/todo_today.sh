# Set IFS to handle spaces in task descriptions and tags
IFS=$(printf '\n\t')

# Check if argument is provided, otherwise use default "next"
if [ $# -eq 0 ]; then
    export_arg="export next"
else
    export_arg="$*"
fi

# Export all next tasks as JSON and store in variable
tasks=$(task $export_arg | jq -c '.')

echo "Exporting tasks with command: task $export_arg"

# Print table headers
echo "| Project | Description                                             | Due Date   | Tags     |"
echo "| ------- | ------------------------------------------------------- | ---------- | -------- |"

# Loop through all tasks and print them in a Markdown table
for task in $(echo "$tasks" | jq -c '.[]'); do
    description=$(echo "$task" | jq -r '.description')
    project=$(echo "$task" | jq -r '.project')
    due=$(echo "$task" | jq -r '.due')
    tags=$(echo "$task" | jq -r '.tags')
    if [[ "$tags" == "null" ]]; then
        tags="None"
    else
    tags=$(echo "$task" | jq -r '.tags | map("#" + gsub("\"";"")) | @csv' | tr -d '"')
    fi


    # # Check if tags field is not null or empty
    # if [[ -n "$tags" && "$tags" != "null" ]]; then
    #     tags=$(echo "$tags" | tr -d '[]' | tr ',' '\n' | sed 's/ //g' | sed 's/^/#/g' | tr '\n' ', ')
    #     tags="${tags%, }"
    # else
    #     tags="None"
    # fi

    # Convert due date to human-readable format
    if [[ -n "$due" && "$due" != "null" ]]; then
        timestamp=$(date -j -f "%Y%m%dT%H%M%SZ" "$due" '+%Y-%m-%d')
        due="$timestamp"
    else
        due="No date"
    fi

    # Print task details as a table row
    printf "| %-8s | - [ ] %-50s | %-10s | %-8s |\n" "$project" "$description" "$due" "$tags"
done
