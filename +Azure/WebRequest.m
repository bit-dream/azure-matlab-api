classdef WebRequest < handle
    %AUTHORIZATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        options
        url
        apiVersion
    end
    
    methods
        function obj = WebRequest(url)
            obj.url = url;
        end
        
        function setApiVersion(obj,version)
            obj.apiVersion = version;   
        end
        
        function setBasicAuthHeader(obj, token)
            import Azure.BasicAuth
            auth = BasicAuth(token);
            obj.options = auth.options;
        end
        
        function url = formUrlFromBase(obj,endpoint)
            url = strcat(obj.url, '/', endpoint);
        end
        
        function data = get(obj, endpoint, varargin)
            if isempty(obj.apiVersion)
                if isempty(obj.options)
                    data = webread(obj.formUrlFromBase(endpoint),...
                        varargin{:});
                else
                    data = webread(obj.formUrlFromBase(endpoint),...
                        varargin{:}, obj.options);
                end
            else
                if isempty(obj.options)
                    data = webread(obj.formUrlFromBase(endpoint), 'api-version', obj.apiVersion,...
                        varargin{:});
                else
                    data = webread(obj.formUrlFromBase(endpoint), 'api-version', obj.apiVersion,...
                        varargin{:}, obj.options);
                end
            end

        end
        
        function data = post(obj, endpoint, varargin)
            
            if isempty(obj.apiVersion)
                if isempty(obj.options)
                    data = webwrite(obj.formUrlFromBase(endpoint),...
                        varargin{:});
                else
                    data = webwrite(obj.formUrlFromBase(endpoint),...
                        varargin{:}, obj.options);
                end
            else
                if isempty(obj.options)
                    data = webwrite(obj.formUrlFromBase(endpoint), 'api-version', obj.apiVersion,...
                        varargin{:});
                else
                    data = webwrite(obj.formUrlFromBase(endpoint), 'api-version', obj.apiVersion,...
                        varargin{:}, obj.options);
                end
            end
        end
        
    end
    
end

