# Red Ira
Red Ira is an cloud automation system scheme for Red Teams, built on the work done in [Red Baron](https://github.com/Coalfire-Research/Red-Baron). It currently supports AWS only. The accompanying blog post can be [found here](https://blog.joeminicucci.com/2021/redira).
 
## Design Philosophy
 The design philosophy differs from Red Baron in the following :

- Deployments only require modification of cut-and-dry configuration JSON templates.
- All configuration is done by Ansible, automatically.
    - In-line scripts remain an option (recommended against).
- Publicly facing assets only expose ports & services necessary for their core offensive function to the internet.
    - All administrative functions are exposed to the internal operators' network only.
        - Obscures the underlying operations infrasturcture to curious Blue teams.

## Improvements
- Terraform upgrade to .14
    - Includes new Terraform syntax paradigms, such as :
        - Non-interpolated variable invocation 
        - explicit `depends` patterns
        - local variables
        - Upgraded acme providers
- Complete, hands-off Cobalt Strike and Gophish Ansible playbooks.
    - Added J2 templates & c2 profiles that can be fed into the playbooks.
- Cleaned up code
    - Removed count where unnecessary
    - Simplified outputs
    - Simplified modules
    - Added explicit type constraints where possible
- Boilerplate base variable files for unmanaged infrastructure declaration
- Deployment specific module abstractions (infra as well as ansible modules)
    - Cobalt strike, Gophish 
- Ansible on python3

## Versioning
This following components were leveraged for development and are stable for this release:
- Terraform v0.14.4
- Ansible v2.10.4
- Cobalt Strike 4.2
    - Oracle JDK jdk-8u261-linux-x64.tar.gz
- gophish 0.11.0

The Ansible Playbooks are currently built for and tested on the latest Amazon Debian Buster AMIs.


## Install 
### First Run - Dependencies
    apt-get -y install ansible terraform python3-pip
    ansible-galaxy install -r ./data/playbooks/requirements.yml

### First Run - AWS SES Verification

SES requires verification before the relays can be used for Phishing. See the instructions in [the README](./modules/aws/smtp/README.md#initial-setup) 
### First Run - AWS Environment Preparation
Since this framework will isolate back-end operator actions from the internet, some manual setup is required in AWS before the framework can be deployed.

In the root directory, copy the [environment variables template file](environment_variables.auto.tfvars.json.template) as:

```cp ./environment_variables.auto.tfvars.json.template ./environment_variables.auto.tfvars.json```

Then add the following properties:
#### VPC
Pick an existing VPC or create new one. Record `the vpc_id`.

        "vpc_id" : "vpc-aabbccdd",
#### Private Subnet
Create or select an existing subnet which will be used for the back-end infrastructure, and which is intended to be accessed by operators only. Record the `private_subnet_id`.

        "private_subnet_id" : "subnet-aabbccdd",
#### Public Subnet
Create a subnet in which publicly facing redirectors & assets will be placed. Record the `public_subnet_id`.
    
        "public_subnet_id" : "subnet-aabbccdd",
#### Public Security Groups
This will be the Security Group(s) which redirectors and publicly facing assets will inherit. They only need to define incoming traffic from internal sources to the public subnet, as public sources are resolved through Terraform at runtime depending on the chosen deployment.  

Create the SG or multiple, which allows incoming traffic from the private subnet you just created and optionally anywhere in the VPC which you would like to access the publicly facing assets from. 
 
 The following is an example which additionally allows the required private subnet total access for managing redirectors, as well as the Terraform controller's subnet prefix from which to ssh in:
 
| Type        | Protocol | Port Range | Source          | Description                                                                    |
|-------------|----------|------------|-----------------|--------------------------------------------------------------------------------|
| All traffic | All      | All        | 172.14.130.0/24 | Private Subnet (required)                                                      |
| SSH         | TCP      | 22         | 172.1.111.0/24  | Internal SSH access (from Terraform controller's subnet)                       |
|             |          |            |                 |                                                                                |
	

Record these SG(s) as `base-public-security-groups`.

        "base-public-security_groups" : ["sg-12345678912345678"]
#### Internal Security Groups
This will be the security group that allows operators to access the back-end infrastructure (the private subnet).  

The public SG is required (the one created above), as it allows all incoming traffic from the redirectors/public assets to communicate inbound. The VPN server addition in the example below is an example of how one may allow operators to connect to the internal red team assets from a VPN server.

| Type        | Protocol | Port Range | Source               | Description            |
|-------------|----------|------------|----------------------|------------------------|
| All traffic | All      | All        | sg-12345678912345678 | Public SG (required)   |
| All traffic | All      | All        | 172.12.130.101/32    | VPN Server             |
|             |          |            |                      |                        |


Record this SG as the `base-internal-security-groups`.

    "base-internal-security_groups" : ["sg-12345678912345678"],

## Deployment
### Prepare the environment for Terraform
```shell script
export AWS_SECRET_ACCESS_KEY="<secret_key>"
export AWS_DEFAULT_REGION="us-east-1"
export AWS_ACCESS_KEY_ID="<key_id>"
```
### Deployment Prep
1. Reference the [AWS Deployment README](./deployments/aws/README.md) to select the desired deployment.
 
2. Clean the root of the previous deployment.
    > :warning: Be careful as to not clear out someone's pre-existing environment!
    ```shell script
    rm -f ./aws_*
    ```

3. Copy the desired deployment folder from the [AWS Deployments folder](./deployments/aws/) to the root.
    ```shell script
    cp ./deployments/aws/complete/* ./
    ``` 

4. Rename the `auto.tfvars.json.template` file to `.json` for that deployment, and fill in the json variables with target values: 
    ```shell script
    mv ./aws_complete.auto.tfvars.json.template ./aws_complete.auto.tfvars.json
    ```

5. If working with Cobalt Strike, retrieve an Oracle JDK gz tar from the Oracle website and copy it to the [./data/oracle](./data/oracle) folder. This is necessary due to Oracle's licensing restrictions.

    ```cp jdk-8u261-linux-x64.tar.gz ./data/oracle/```

    6. If a custom c2 profile file is desired, copy the file to [./data/c2_profiles](./data/c2_profiles) fill in the filename within the c2-profile variable in the respective `.auto.tfvars.json` deployment config file you created. Otherwise, the default CS profile will be used (not recommended).
        
        ```cp <profile filename> ./data/c2_profiles/```
    
### Deploy with Terraform
From the root directory:
```shell script
terraform init
terraform plan -out <plan file>
terraform apply <plan file>
```

## Contributing to Red Ira
### Development Process
GitHub is used to sync code, as well as to track issues, feature requests, and pull requests.

### Pull Requests
Pull Requests are always welcome. The following procedure should be adhered to:

1. Fork the repo and create your branch from `master`.
2. If you've added code, please ensure that you have already deployed several times and tested successfully before submission.
3. If relevant, update the documentation.
4. Make sure your code lints. Currently the [Hashicorp HCL/Terraform plugin](https://plugins.jetbrains.com/plugin/7808-hashicorp-terraform--hcl-language-support) is used within a JetBrains IDE.

### Issues
Use GitHub issues to track public bugs. Please ensure your description is clear and has sufficient instructions to be able to reproduce the issue.

### Coding Style  
* Follow the current conventions in place for splitting up HCL elements in separate files
* 2 spaces for indentation
* Currently no line length restrictions in place due to the way HCL is handled, but try to keep it at a minimum where possible.
* Use an HCL linter to ensure your code passes basic convention tests

### License
By contributing to RedIra, you agree that your contributions will be licensed under its [GPLv3 license](./LICENSE).

## Known Issues
### Locals & Provisioners
If the locals are changed, the paths in the destroy provisioners will need to be updated due to a limitation in terraform
`https://github.com/hashicorp/terraform/issues/23675`
### Relative Paths
Terraform doesn't support variables in module source paths, meaning that core modules must remain in place, and deployments must be copied to the root folder or else the module sources will not resolve properly. If Hashicorp implements it in the future, dynamic path resolution could be accomplished by modifying base variables.

## Credit
- [Joe Minicucci](https://joeminicucci.com) - Author
- [Red Baron](https://github.com/Coalfire-Research/Red-Baron) - Used as a starting point, built on Terraform architecture and coding style.
- [ansible-role-cobalt-strike](https://github.com/chryzsh/ansible-role-cobalt-strike) - Built on with several additions.
- [Richard Ira Bong](https://en.wikipedia.org/wiki/Richard_Bong) for name of the project.
## TODO 

### Future Needs and Ideas
#### Needs
- Pwndrop for payload server
- Domain Fronting Implementation
- RedELK Implementation
- Hosted Zone / Create VPC implementation, as needed or if requested
- Molecule & InSpec integration tests
#### Ideas
- Remove ansible invocations entirely from terraform, and leverage the [terraform inventory tool](https://github.com/adammck/terraform-inventory) as explained by xpn [in this excellent blog post.](https://blog.xpnsec.com/testing-redteam-infra/)
    - For dynamic inventories, alternatively use template files in native terraform resources as [outlined here](https://www.linkbynet.com/produce-an-ansible-inventory-with-terraform)
- Encapsulate JSON config with a micro-service, which can easily be leveraged for a ChatOps deployment approach
- Web clone / APT - tailored website deployments with nginx redirectors on HTTP C2s
- Domain name automation with evilurl / domaincheck
- CLI implementation with https://github.com/amplify-education/terrawrap or https://github.com/beelit94/python-terraform if needed. TF CLI seems to suffice.
