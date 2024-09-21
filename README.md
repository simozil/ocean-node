
# Install dependencies :
```sudo apt-get update && sudo apt-get upgrade -y
sudo apt install curl -y
sudo apt install ca-certificates
```

# Install Docker :
Skip if you already have it
```curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
docker version
```
# Install Docker Compose :
Skip if you already have it
```VER=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)

curl -L "https://github.com/docker/compose/releases/download/"$VER"/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

# 1. Step-by-Step Command

Clone the repository from GitHub

```
git clone https://github.com/simozil/ocean-node.git
```
Change directory to the cloned repository

```
cd ocean-node
```
Make the script executable

```
chmod +x run-ocean-node.sh
```

Run the script

```
./run-ocean-node.sh
```

Check Log's 
```
docker-compose logs -f
```

Check peer ID : change port respectively
http:/IP_address:8000/dashboard/

Reward Eligibility
https://nodes.oceanprotocol.com/

Check Reward $FET
https://rewards.autobotocean.com/
