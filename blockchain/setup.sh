# These are the requirements to set up the blockchain

# Tutorial found here
# https://medium.freecodecamp.org/from-what-is-blockchain-to-building-a-blockchain-within-an-hour-4e738efc819d


sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install -y ethereum

mkdir eth-new
cd eth-new
vi genesis.json
cd ..


mkdir eth-data
geth --datadir eth-new genesis.json init eth-new/genesis.json --networkid 123 --nodiscover --maxpeers 0 console