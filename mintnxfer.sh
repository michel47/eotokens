#

# 390mg is on breath CO2e emission
amount=${2:-0.000390}
tokenid=${1:-CArBo4puwrkEsEqDY5SDxNwj31bi3V2ZubimRNSwXVNr}
recipient={3:-rJCDKYNQv3i6kHDFWbZejzk32qBavHCtJkxrErfwTtC}

spl-token mint $tokenid $amount
spl-token transfer --allow-unfunded-recipient --fund-recipient $tokenid $amount $recipient 
