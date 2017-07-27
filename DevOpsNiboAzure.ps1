# Script para automatizar a criação de um WebApp no Azure e fazer deploy de um projeto do github

################## Instalando o PowerShellGet ####################
Get-Module PowerShellGet -list | Select-Object Name,Version,Path
##################################################################

####### Instalando o módulo Azure Powershell ######
Install-Module AzureRM
###################################################

####### Carregando o módulo Azure Powershell ######
Import-Module AzureRM
###################################################

####### Realizando login no Azure para permitir a execução dos comandos #########
az login
#################################################################################

############## Armazenando as variáveis #########################
$gitrepo="https://github.com/Skolzack/Nibo.DevOps.Challenge.git"
$webappchallenge="DevOpsNiboAzure"
#################################################################


################ Criando um Resource Group ######################
az group create --location southcentralus --name DevOpsChallenge
#################################################################


########################## Criando um plano STANDARD #######################################
az appservice plan create --name $webappchallenge --resource-group DevOpsChallenge --sku S1
############################################################################################


############################## Criando o WebApp ##################################################
az webapp create --name $webappchallenge --resource-group DevOpsChallenge --plan $webappchallenge
##################################################################################################

################### Dando Deploy do código do github da Branch Master para o WebApp #################################################################
az webapp deployment source config --name $webappchallenge --resource-group DevOpsChallenge --repo-url $gitrepo --branch master --manual-integration
#####################################################################################################################################################

################### Criando um Deployment Slot com o nome de Staging ###################################
#az webapp deployment slot create --name $webappchallenge --resource-group DevOpsChallenge --slot staging
########################################################################################################

################### Dando Deploy do código do github da Branch Master para Staging #################################################################################
#az webapp deployment source config --name $webappchallenge --resource-group DevOpsChallenge --slot staging --repo-url $gitrepo --branch master --manual-integration
####################################################################################################################################################################
