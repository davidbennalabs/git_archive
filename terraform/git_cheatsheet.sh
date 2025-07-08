https://www.atlassian.com/git/tutorials/using-branches/git-merge

git checkout -b phase1
git add .
git commit -m "Add new feature"
# this will causer
git push --set-upstream origin phase1

# checkout main but keep phase1
git checkout main

git merge phase1



git branch -d phase1 # delete local