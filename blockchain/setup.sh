# These are the requirements to set up the blockchain

# These need to be installed on your system, you should be able to run these commands to do so
# sudo apt install curl
# curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
# nvm install node
# nvm use node
# npm install



killall -9 node
curl http://localhost:3001/peers
HTTP_PORT=3001 P2P_PORT=6001 npm start &
HTTP_PORT=3002 P2P_PORT=6002 PEERS=ws://localhost:6001 npm start &
curl -H "Content-type:application/json" --data '{"data" : "Some data to the first block"}' http://localhost:3001/mineBlock
echo
