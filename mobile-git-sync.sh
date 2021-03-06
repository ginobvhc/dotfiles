#!/bin/bash

set -e

CONF_LOC_1="$HOME/.mobile-git-sync"
CONF_LOC_2="/etc/mobile-git-sync"

GIT_QUIET="--quiet"
CURL_QUIET="--silent --show-error"

mobile_git_sha=""

if [ -f "$CONF_LOC_1" ]; then
    source "$CONF_LOC_1"
elif [ -f "$CONF_LOC_2" ]; then
    source "$CONF_LOC_2"
else
    echo "No configuration found in either '$CONF_LOC_1' or '$CONF_LOC_2'."
    exit 1
fi

file_download()
{
    curl $CURL_QUIET --netrc-optional --remote-name $MOBILE_URL/$1
}

file_upload()
{
    curl $CURL_QUIET --netrc-optional --upload-file $1 $MOBILE_URL/
}

download_from_mobile()
{
    for sync_file in $SYNC_FILES; do
        file_download $sync_file || exit 1
    done
}

upload_to_mobile()
{
    for sync_file in $SYNC_FILES; do
        if [ -z "$mobile_git_sha" ] || ! git diff --quiet $mobile_git_sha -- $sync_file; then
            file_upload $sync_file
        fi
    done
}

pull_from_server()
{
    if [ -n "$GIT_REMOTE" ]; then
        git checkout $GIT_QUIET $MERGE_BRANCH
        git pull $GIT_QUIET $GIT_REMOTE $MERGE_BRANCH
    fi
}

push_to_server()
{
    if [ -n "$GIT_REMOTE" ]; then
        git push $GIT_QUIET $GIT_REMOTE $MERGE_BRANCH
    fi
}

checkout_mobile_branch()
{
    if git rev-parse --verify --quiet $MOBILE_BRANCH > /dev/null; then
        git checkout $GIT_QUIET $MOBILE_BRANCH
    else
        git checkout $GIT_QUIET $MERGE_BRANCH -b $MOBILE_BRANCH
    fi
}

merge_changes()
{
    if [ -n "$(git status --porcelain)" ]; then
        git add $SYNC_FILES
        git commit $GIT_QUIET -m "$COMMIT_MESSAGE" || true
        mobile_git_sha=$(git rev-parse HEAD)
        git checkout $GIT_QUIET $MERGE_BRANCH
        git merge $GIT_QUIET --no-edit $MOBILE_BRANCH
    else
        mobile_git_sha=$(git rev-parse HEAD)
    fi
}

merge_back_to_mobile_branch()
{
    git merge $GIT_QUIET --ff-only $MERGE_BRANCH
    git checkout $GIT_QUIET $MERGE_BRANCH
}

options=$(getopt --name $(basename $0) --options uv --long upload-only,verbose -- "$@") || exit 1

for opt in $options; do
    case $opt in
        -u | --upload-only)
            UPLOAD_ONLY=1
            ;;
        -v | --verbose)
            GIT_QUIET=""
            CURL_QUIET=""
            ;;
    esac
done

cd "$WORK_REPO"

if [ -n "$(git status --porcelain)" ]; then
    echo "Working copy is dirty"
    exit 1
fi

if [ -z "$UPLOAD_ONLY" ]; then
    pull_from_server
    checkout_mobile_branch
    download_from_mobile
    merge_changes
fi

checkout_mobile_branch
merge_back_to_mobile_branch
push_to_server
upload_to_mobile
