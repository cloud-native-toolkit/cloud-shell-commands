# IBM Cloud Shell Command

Set of scripts to enable fast access to setup to the **Cloud Native Toolkit** in the cloud shell, if you shell has expired you will need to re-run your setup.


## Fork

Fork this repo into you personal github account and customize the parameters for you personal configuration. Then use the git repo to clone into the Cloud Shell.

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

A utility CLI named `icc` has been provided to make it easy to switch between cluster across IBM Cloud accounts. There are three files that make up the `icc` CLI:

- `icc` - the executable shell script. This file can be copied into the path or run from its current location
- `ibmcloud-account.yaml` - the yaml configuration file containing the API keys for the various IBM Cloud accounts

    This file contains sensitive information and should not be checked into source control. Example contents of this file are provided below:

    ```yaml
    accounts:
      myaccount: {APIKey}
    ```

    where:
    - `myaccount` is any arbitrary nickname for the account
    - `{APIKey}` is the API key value used to access that account
  
- `ibmcloud.yaml` - the yaml configuration of the clusters in the accounts. This file has a reference to the account nickname used in `ibmcloud-account.yaml` but does not contain any sensitive information so it can be shared with others. The `icc` command will generate this configuration file for the existing clusters in the account by running `icc --generate`


To configure the CLI for your environment, follow the instructions below:

### (Optionally) Install the icc in the path

1. Run the `install-icc` command to copy the `icc` command to ~/bin and update .bashrc
2. Source .bashrc to pick up the change: `source ~/.bashrc`

### (Optionally) Set ICC_HOME

By default the `icc` command looks for the configuration files in the `ICC_HOME` directory. If the environment variable has not been set the value defaults to
the `HOME` directory. If you would like to store the files in a location other than the `HOME` directory, set the `ICC_HOME` environment variable to your desired directory
and export the variable. E.g.

```shell script
export ICC_HOME=$PWD
```

### Add API Key(s)

Run `icc --add-account` to register the apikey for an account.

```shell script
icc --add-account
```

You will be prompted for the account nickname and the api key. The api key will not be echoed to the console.

**Note:** Never store API Keys in Git, its a small price to pay for the simplicity of the time this little CLI trick saves you.

### Generate the cluster configuration

1. Use the `icc --generate` command to initialize the `ibmcloud.yaml` file with the existing clusters in the account:
       
    ```shell script
    icc --generate
    ```

    **Note:** If you have multiple accounts configured and would only like to generate the cluster configuration for a single account then provide the account name, e.g. `icc --generate myaccount`

    **Note:** The `--generate` process merges the new results with the existing configuration, so it can be run repeatedly without losing information.

### Update the cluster nicknames

The generated file uses the cluster name as the nickname. In most cases you will want to use a shorter nickname to speed up the process.

1. List the defined clusters with `icc`
   
    ```shell script
    icc
    ```

2. Update the generated nicknames using `icc --nickname`
   
    ```shell script
    icc --nickname
    ```

    You will be prompted to provide the cluster name or the existing cluster nickname then the new cluster nickname.

### Print the configured clusters

To see the list of clusters that have been configured and the nickname that can be used for login, run the `icc` command without any parameters:

```shell script
icc
```

If you have a large number of clusters, you can filter the list to an account and/or a resource group by providing the `--account` and/or `--resourceGroup` flags to the command:

```shell script
icc --account europe
icc --resourceGroup dev
icc --account europe --resourceGroup dev
```

### Login into you multiple accounts quickly

```shell script
icc gdev45
```

This speeds up you ability to switch accounts:

```
Logging into ibmcloud: us-east/garage-dev-tools
Logging into OpenShift cluster garage-dev-ocp45-vpc with server url https://c104-e.us-east.containers.cloud.ibm.com:30922
```

## Install kube annotation to shell prompt

The following commands will add the current cluster and project to the command prompt.

### For bash shell (like IBM Cloud shell)

1. Run `./install-kube-ps1-bash` to set up the prompt
2. Source the .bashrc file to load the changes - `source ~/.bashrc`

### For zsh shell

1. Run `./install-kube-ps1-zsh` to set up the prompt
2. Source the .zshrc file to load the changes - `source ~/.zshrc`
