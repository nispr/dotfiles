#!/usr/bin/env zsh

# Usage: fetch_hacker_news count
#
# Fetches first {count} entries from top hacker-news
fetch_hacker_news() {
    topNews="https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"
    count=$1
    if [ -z "$count" ]; then count=6; fi

    rawIds=( $(curl "$topNews" -s -G | jq -r ".[:$count][]") )

    for id in $rawIds; do
        baseUrl="https://news.ycombinator.com/item?id="
        itemApi="https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty"
        news=$(curl "$itemApi" -G -s | jq -rc ".title, \"> $baseUrl\(.id)\"")
        details=$(echo -e $news)
        string+="$details\n\n"
    done

    echo "$string"
}

