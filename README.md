# Azure DevOps MATLAB API

## Motivation
Wrap the devops web api with matlab classes for easy access to the Azure DevOps apis

## Usage

### Basic Authorization
A PAT (Personal Access Token) will be needed for the basic authorization workflow. One can be setup within the
Azure DevOps settings menu for your personal account. Oauth2 workflow is currently
not implemented.

### Create devops instance
```matlab
% All functions in this library exist within the Azure namespace
% DevOps() class expects a group name. ie. dev.azure.com/MY-GROUP-NAME/
devOps = Azure.DevOps('my-group-name');

% Authorize with your PAT
PERSONAL_ACCESS_TOKEN = 'your token here';
devOps.basicAuth(PERSONAL_ACCESS_TOKEN);

% Get a list of all projects
projects = devOps.getProjects();

% Get a list of existing repositories
repos = devOps.getRepositories();

% Get a list of refs for a repository
% A repo id can be obtained through the getRepositories() function
% which will return all of the repo names as well as their unique ID
refs = devOps.getRepositoryRefs(repoId);

% Get only tagged releases from a repo
tags = devOps.getRepositoryTags(repoId);
```

### Other
Not all API endpoints are currently implemented, however the Azure namespace
contains a wrapper for general web requests/posts

```matlab
devOps = Azure.DevOps('my-group-name');
devOps.basicAuth(PERSONAL_ACCESS_TOKEN);

% You can alternatively set your own api version if need be. It defaults to 7.1-preview.1
devOps.setApiVersion(VERSION)

% get() is general method querying a DevOps endpoint.
% First argument is always the endpoint you are wanting to reach
% get() also accepts variable arguments that you can use as your query name and parameters
devOps.requests.get('endpoint/to/reach','QueryParameterName1','QueryParameterValue1',...);
```