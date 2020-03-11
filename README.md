# cloud-shell-commands

Set of scripts to enable fast access to setup to the **Cloud Native Toolkit** in the cloud shell, if you shell has expired you will need to re-run your setup.

### Follow these commands to configure the commands

The **cloud-shell-commands** contains a number of very useful commands for a developer or sys admin. They are also very useful for when you are running education, enablement or workshops where you want the developer to live 100% in the web browser.

```
git clone https://github.com/ibm-garage-cloud/cloud-shell-commands.git
export PATH=~/cloud-shell-commands:$PATH
```

## Installing Cloud Native Toolkit CLI

Run the following to install `igc` and add it to the path.

```
source ./cloud-shell-commands/install-igc
```

## Enabling fast Cluster switching 

Using the utility CLI `icc` you can make it easy to switch between cluster accounts, follow the instructions below:

### Add API Key

Edit the `.ibmcloud.yaml` file in the `cloud-shell-commands` replace the accounts with the correct API Keys.

```
vi ./cloud-shell-commands/.ibmcloud.yaml
```

Replace the accounts with the correct API Keys. Store the keys in your password managed in the format below and just cut and paste then into the file using `vi` , yes `vi` is installed in the Cloud Shell.

```
accounts:
  europe: <api key>
  north-america: <api key>
```

Note: Never store API Keys in Git, its a small price to pay for the simplicity of the time this little CLI trick saves you 

### Define an Account

Add an account to the `.ibmcloud.yaml` using the following format:

```
 ocp-eu:
    region: eu-gb
    resourceGroup: cloudnative-squad
    cluster: learning-ocp4-cluster
    account: europe
 iks-na:
    region: us-east
    resourceGroup: cloudnative-squad
    cluster: learning-iks-cluster
    account: north-america
```

### Login into you multiple accounts quickly

```
icc ocp-eu
```

This speeds up you ability to switch accounts:
```
Logging into ibmcloud: eu-gb/cloudnative-squad
Logging into IKS cluster: learning-ocp4-cluster
OK
The configuration for learning-ocp4-cluster was downloaded successfully.

Added context for gsi-learning-iks-cluster to the current kubeconfig file.
You can now execute 'kubectl' commands against your cluster. For example, run 'kubectl get nodes'.
```
