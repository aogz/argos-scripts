#!/usr/bin/env bash

# Set the GitHub username
username=""

# Set the GitHub access token
# You can generate a personal access token at https://github.com/settings/tokens
access_token=""

# Define the repositories to check
repositories=(
    "user/repository"
    "user/repository"
    "user/repository"
)

# Initialize the total number of pull requests to 0
total_pull_requests=0

# Loop through the repositories and add up the number of pending pull request reviews for the specified user
for repository in "${repositories[@]}"; do
    pull_requests=$(curl -s -H "Authorization: token $access_token" "https://api.github.com/repos/$repository/pulls?state=open" | jq --arg username "$username" '.[] | select(.requested_reviewers[].login == $username) | .number' | wc -l)
    total_pull_requests=$((total_pull_requests + pull_requests))
done

if [ "$total_pull_requests" -gt 0 ]; then
    pending_gh_icon=$(curl -s "https://github.githubassets.com/favicons/favicon-pending-dark.png" | base64 -w 0)
    echo "Pending: $total_pull_requests | image=$pending_gh_icon imageWidth=20"
else
    success_gh_icon=$(curl -s "https://github.githubassets.com/favicons/favicon-success-dark.png" | base64 -w 0)
    echo "| image=$success_gh_icon imageWidth=20"
fi

echo "---"
echo "View Pull Requests | href=https://github.com/pulls/review-requested"