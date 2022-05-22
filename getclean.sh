#

find . -name '*~1' -delete
pwd=$(pwd)
cd /media/$USER/4TB/repos/github.com/token-list/src/tokens
top=$(git rev-parse --show-toplevel)
cd $top/src/tokens
cp -p solana.tokenlist.json solana.tokenlist.json~
rename solana.tokenlist.json
mv solana.tokenlist_*.json $pwd
cd $pwd
git add *.json
git commit -a -m "token list on $(date)"
git push
cd $top/src/tokens

git checkout -f origin/main solana.tokenlist.json
ed solana.tokenlist.json <<EOT
\$
?chainId?-2
.r $pwd/token-item.json
c
    },
.
w solana.tokenlist.json
q
EOT
# remove trailing \n
perl -S chompnl.pl solana.tokenlist.json
git diff solana.tokenlist.json
colored vi -d solana.tokenlist.json solana.tokenlist.json~
#gvim --servername SOLLIST --remote-wait-tab-silent solana.tokenlist.json
msg=$(git diff origin/main solana.tokenlist.json | grep name)
echo "msg: $msg"
tokenid=$(cat $pwd/token-item.json | json_xs -t string -e '$_ = $_->{address}');

git commit -a -uno --no-ahead-behind -m "$msg, $tokenid on $(date +%Y-%m-%d)"
fork=$(cat $pwd/fork.yml | cut -d' ' -f2)
echo git push $fork
git push $fork
if [ "$fork" = "fork" ]; then
  echo fork: fork2 > $pwd/fork.yml
  xdg-open https://github.com/DrI-T/token-list/pulls
else
  echo fork: fork > $pwd/fork.yml
  xdg-open https://github.com/Doctor-I-T/token-list/pulls
fi



exit $?
1;
