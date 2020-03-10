# cloud-shell-commands

Set of scripts to enable fast access to setup in the cloud shell

### Follow these commands to configure


```
git clone https://github.com/mjperrins/cloud-shell-commands.git
chmod +x ./cloud-shell-commands/*
export PATH=~/cloud-shell-commands:$PATH
```

## Installing Cloud Native Toolkit CLI

Run the following command `./cloud-shell-commands/install-igc` this will install and add `igc` to the path

## Enabling fast Cluster switching 

Using the utility CLI `icc` you can make it easy to switch between cluster accounts, follow the instructions below:

### Add API Key

Edit the `.ibmcloud.yaml` file in the `cloud-shell-commands` replace the accounts with the correct API Keys.

```
vi ./cloud-shell-commands/.ibmcloud.yaml
```

Replace the accounts with the correct API Keys.

```
accounts:
  mooc: <api key>
  gsi: <api ke>
```

Note: Never story API Keys in Git, its a small price to pay for the simplicity of the time this little CLI trick saves you 


### Define an Account

Add an account to the `.ibmcloud.yaml` using the following format:

```
g1o:
    region: eu-gb
    resourceGroup: gsi-cloudnative-squad
    cluster: gsi-learning-ocp311-cluster
    account: gsi
 g1k:
    region: eu-gb
    resourceGroup: gsi-cloudnative-squad
    cluster: gsi-learning-iks-cluster
    account: gsi
```

### Login into you multiple accounts quickly

```
icc g1k
```

This speeds up you ability to switch accounts:
```
Logging into ibmcloud: eu-gb/gsi-cloudnative-squad
Logging into IKS cluster: gsi-learning-iks-cluster
OK
The configuration for gsi-learning-iks-cluster was downloaded successfully.

Added context for gsi-learning-iks-cluster to the current kubeconfig file.
You can now execute 'kubectl' commands against your cluster. For example, run 'kubectl get nodes'.
```
