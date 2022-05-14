#

top=$(git rev-parse --show-toplevel)
cd $top/src/tokens
cp -p solana.tokenlist.json solana.tokenlist.json~0
rename solana.tokenlist.json
git checkout -f origin/main solana.tokenlist.json
ed solana.tokenlist.json <<EOT
\$
?chainId?-2
.r token-item.json
c
    },
.
w solana.tokenlist.json
q
EOT
git diff solana.tokenlist.json
colored vi -d solana.tokenlist.json solana.tokenlist.json~0
#gvim --servername SOLLIST --remote-wait-tab-silent solana.tokenlist.json
msg=$(git diff origin/main solana.tokenlist.json | grep name)
echo "msg: $msg"
git commit -a -m "$msg on $(date +%Y-%m-%d)"
git push fork2
