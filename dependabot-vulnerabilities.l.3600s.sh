#!/usr/bin/env bash


# Set the GitHub access token
# You can generate a personal access token at https://github.com/settings/tokens
access_token=""

# Define the repositories to check
repositories=(
    "surfly/cobro"
    # "surfly/deployment"
    # "surfly/install"
    # "surfly/session-recording"
    # "surfly/ci"
)

# Initialize the total number of vulnerabilities to 0
total_vulnerabilities=0

# Loop through the repositories and add up the number of pending vulnerabilities
for repository in "${repositories[@]}"; do
    url="https://api.github.com/repos/$repository/dependabot/alerts?severity=critical&state=open"
    vulnerabilities=$(curl -s -H "Authorization: token $access_token" "$url" | jq -r ". | length")
    total_vulnerabilities=$((total_vulnerabilities + vulnerabilities))
done

# Print the total number of pull requests
if [ "$total_vulnerabilities" -gt 0 ]; then
    echo "$total_vulnerabilities | color=#FF0000 image=$(curl -s "https://github.githubassets.com/assets/dependabot-icon-3f88d04d37bc.png" | base64 -w 0) imageWidth=20"
else
    echo "| color=#00FF00 image=$(curl -s "https://github.githubassets.com/assets/dependabot-icon-3f88d04d37bc.png" | base64 -w 0) imageWidth=20"
fi

echo "---"
echo "View Vulnerabilities | href=https://github.com/surfly/cobro/security/dependabot?q=is%3Aopen+severity%3Acritical"
