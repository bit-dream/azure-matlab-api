classdef DevOps < handle
    %AZURE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        group
        apiVersion = '7.1-preview.1'
        requests
    end
    
    properties(Access = private)
        baseUrl
        token
    end
    
    methods
        function obj = DevOps(group)
            obj.group = group;
            obj.baseUrl = strcat('https://dev.azure.com/', obj.group, '/_apis/');
            
            import Azure.WebRequest
            obj.requests = WebRequest(obj.baseUrl);
            obj.requests.setApiVersion(obj.apiVersion);
        end
        
        function basicAuth(obj, token)
            obj.token = token;
            obj.requests.setBasicAuthHeader(obj.token);
        end
        
        function setApiVersion(obj, version)
           obj.apiVersion = version;
           obj.requests.setApiVersion(obj.apiVersion); 
        end
        
        function projects = getProjects(obj)
           projects = obj.requests.get('projects');
        end
        
        function repos = getRepositories(obj)
            repos = obj.requests.get('git/repositories/');
        end
        
        function repo = getRepository(obj, repoId)
            requestUrl = strcat('git/repositories/', repoId);
            repo = obj.requests.get(requestUrl);
        end
        
        function refs = getRepositoryRefs(obj, repoId)
            requestUrl = strcat('git/repositories/', repoId, '/refs');
            refs = obj.requests.get(requestUrl);
        end
        
        function tags = getRepositoryTags(obj, repoId)
            refs = obj.getRepositoryRefs(repoId);
            tags = {};
            for i = 1 : length(refs.value)
               if startsWith(refs.value(i).name, 'refs/tags/')
                   tags{end+1} = refs.value(i);
               end
            end
        end
    end
     
end

