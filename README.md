# DevCon-5

DevCon-5 is an application for easy deployment of development environments in containers.
The application works by using a PowerShell module for deploying and managing your development
environments.

</br>

**What is a Development environment?**

Well in the case of DevCon-5 it is a container running in Azure. The container will be configured
with Visual Studio in the browser. It will then be specificly configured for either PowerShell, Python
or Golang development.

</br>

**How does it work?**

Simple by using the PowerShell module you can authenticate to Azure Active Directory. Once authenticated
you can go ahead and deploy your first container. Once the container is deployed you will be provided with
a URL for accessing the container. Then once you have your environment ready to go you can go ahead and start develop. The container will have git installed for you to start pulling down your repository and start developing.

</br>