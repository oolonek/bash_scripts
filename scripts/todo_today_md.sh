#!/bin/sh
# Set IFS to handle spaces in task descriptions and tags
IFS=$(printf '\n\t')

# Export all next tasks as JSON and store in variable
tasks=$(task export next | jq -c '.[]')

# Sort tasks by urgency and take the top 3
top3=$(echo "$tasks" | jq -s 'sort_by(.urgency) | reverse | .[0:3]')

# Loop through the top 3 tasks and print them
for task in $(echo "$top3" | jq -c '.[]'); do
    description=$(echo "$task" | jq -r '.description')
    project=$(echo "$task" | jq -r '.project')
    due=$(echo "$task" | jq -r '.due')
    tags=$(echo "$task" | jq -r '.tags | @csv' | tr -d '"' | sed 's/,/, #/g')

    # Convert due date to human-readable format
    if [[ -n "$due" && "$due" != "null" ]]; then
        timestamp=$(date -j -f "%Y%m%dT%H%M%SZ" "$due" '+%Y-%m-%d')
        due="Due: $timestamp"
    else
        due="No date"
    fi

    printf -- "- [ ] %s (%s, Project: %s, Tags: #%s)\n" "$description" "$due" "$project" "$tags"
done