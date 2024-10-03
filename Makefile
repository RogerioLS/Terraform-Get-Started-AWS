# Define the installation rules for Docker, Terraform, and AWS CLI
.PHONY: all docker terraform awscli

# Run all installations
all: docker terraform awscli
	@echo "All tools installed successfully."

# Install Docker
docker:
	@echo "Installing Docker..."
	#sudo rm /etc/apt/sources.list.d/docker.list
	sudo apt-get update
	sudo apt install -y ca-certificates curl gnupg lsb-release
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	# Adiciona o repositório correto para Ubuntu focal (20.04)
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io
	@echo "Docker instalado com sucesso."

# Install Terraform
terraform:
	@echo "Installing Terraform..."
	sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
	wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
	# Adiciona o repositório correto com a arquitetura para Ubuntu focal (20.04)
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
	sudo apt-get update && sudo apt-get install -y terraform
	@echo "Terraform installed successfully."

terraformlint:
	@echo "Terraform Lint"
	@terraform fmt
	@terraform validate

# Install AWS CLI
awscli:
	@echo "Installing AWS CLI..."
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
	rm -rf awscliv2.zip aws
	@echo "AWS CLI installed successfully."

awsconfig:
	@echo "Configure AWS CLI"
	aws configure
