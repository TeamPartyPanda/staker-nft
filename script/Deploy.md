## Deploy

1. Deploy Staker
source .env
forge script script/Staker.s.sol:StakerScript --rpc-url $GOERLI_RPC_URL --etherscan-api-key $ETHERSCAN_KEY --broadcast --verify -vvvv
forge script script/Staker.s.sol:StakerScript --rpc-url $OPTIMISM_RPC_URL --etherscan-api-key $OPTIMISTIC_ETHERSCAN_KEY --broadcast --verify -vvvv

